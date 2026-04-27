# Firestore Architecture & Index Strategy
**Date**: 2026-04-27
**Context**: Mozzy Indonesia Version 2 (Global One Build 적용 및 132개 인덱스 한도 준수)

## 1. 배경 및 문제점 (Version 1 - bling_app 분석 결과)
초기 MVP 모델이었던 `bling_app` 분석 결과, Firestore 인덱스가 350여 개까지 팽창한 원인은 다음과 같습니다.
1. **필드 기반의 국가 코드 혼재**: 기존의 모든 쿼리 조합에 `countryCode` 필드가 뒤늦게 추가되면서 모든 복합 인덱스가 중복 생성됨.
2. **위치 정보의 파편화**: 행정구역 데이터(`locationParts.prov`, `locationParts.kec`, `locationParts.kel`)를 개별 Map 필드로 분리하여, 각 깊이별로 인덱스를 요구함.
3. **상태 필드 과다**: `status`, `condition`, `isAiVerified` 등 쿼리에 조합되는 상태 필드가 많아 복합 인덱스 경우의 수가 기하급수적으로 증가.

## 2. Mozzy 신규 아키텍처 개선 전략 (Phase 0)
132개 인덱스 제한을 준수하고, 향후 다국가(Global One Build) 확장 시 인덱스 팽창을 방지하기 위해 다음 전략을 도입합니다.

### A. 경로 기반 격리 (Path-based Sharding for Country Codes)
`countryCode`를 개별 문서의 필드로 두어 쿼리 조건으로 사용하는 대신, **데이터베이스 경로(Path)** 자체에 국가를 명시합니다.
* **Bad**: `db.collection('posts').where('countryCode', '==', 'ID').where('category', '==', 'news')` (인덱스에 countryCode 필수 포함)
* **Good**: `db.collection('countries').doc('ID').collection('domains').doc('news').collection('posts').where('category', '==', 'news')` 
* **효과**: 국가 단위 데이터가 물리적으로 격리되어, 인덱스 생성 시 국가 코드를 조합할 필요가 없어 인덱스 수가 획기적으로 감소합니다.

### B. Shared Contract (`MozzyPostContract`) 기반의 통합 쿼리
11개 피처(Feature) 도메인이 개별 컬렉션을 가지더라도, 공통된 쿼리 인터페이스를 유지합니다.
* 모든 피처 모델은 `geoScope`, `reachMode`, `trustScore`, `signalScore`를 필수 구현합니다.
* **Collection Group Query**를 활용하여, 피처별로 10개씩 만들던 인덱스를 공통 인덱스 1~2개로 압축합니다.

### C. GeoPath 직렬화 (Track 1+2 통합)
행정구역 단위를 개별 필드로 검색하지 않고, 계층형 문자열(Prefix)로 직렬화하여 단일 인덱스로 처리합니다.
* **적용**: `geoPath: "ID#JB#Bandung#Coblong"`
* **효과**: Prefix Match(`>= "ID#JB#Bandung#Coblong"` & `< "ID#JB#Bandung#Coblong~"`)를 사용하여 깊이별 인덱스 중복을 제거합니다.

## 3. 결론
이 전략을 통해 확장 가능한 글로벌 아키텍처를 확보하면서도 132개 미만의 인덱스로 11개 전체 피처의 쿼리를 최적화합니다. 이 원칙은 Phase 0의 `MozzyPostContract` 설계에 즉각 반영됩니다.
