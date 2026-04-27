# i18n-agent.md — 다국어 · 인도네시아 현지화 에이전트

> **역할**: Bahasa Indonesia 우선 · 25개 언어 동기화 · easy_localization 관리

---

## 인도네시아 현지화 우선순위

```
1순위: id   — Bahasa Indonesia (필수, 인도네시아 공용어)
2순위: en   — English (관광, 외국인)
3순위: jv   — Javanese (자바어, 인도네시아 내 최다 사용 지역어)
4순위: su   — Sundanese (순다어, 서부 자바)
5순위: ko   — Korean (앱 개발팀 내부)
```

---

## 파일 구조

```
assets/
└── translations/
    ├── id.json   ← MASTER (인도네시아어 — 우선 완성 필수)
    ├── en.json
    ├── ko.json
    ├── jv.json
    └── ... (총 25개 언어)
```

---

## 인도네시아어(id.json) 핵심 키 — 완전판

```json
{
  "app": {
    "name": "Mozzy",
    "tagline": "Temukan dunia di sekitar kamu"
  },

  "nav": {
    "home": "Beranda",
    "news": "Berita Lokal",
    "marketplace": "Jual Beli",
    "jobs": "Lowongan",
    "auction": "Lelang",
    "clubs": "Komunitas",
    "lostFound": "Barang Hilang",
    "pom": "Pamer",
    "realEstate": "Properti",
    "stores": "Toko Sekitar",
    "together": "Bareng Yuk",
    "chat": "Pesan"
  },

  "geo": {
    "neighborhood": "Kelurahan",
    "district": "Kecamatan",
    "city": "Kota/Kabupaten",
    "province": "Provinsi",
    "nearMe": "Di Sekitar Saya",
    "changeLocation": "Ubah Lokasi",
    "detectingLocation": "Mendeteksi lokasi...",
    "locationPermissionNeeded": "Izinkan akses lokasi untuk fitur terbaik"
  },

  "marketplace": {
    "title": "Jual Beli",
    "sell": "Jual Barang",
    "buy": "Beli",
    "price": "Harga",
    "negotiate": "Bisa Nego",
    "fixed": "Harga Pas",
    "condition": {
      "new": "Baru",
      "likeNew": "Seperti Baru",
      "good": "Bagus",
      "fair": "Layak",
      "poor": "Perlu Perbaikan"
    },
    "aiVerified": "Terverifikasi AI",
    "aiVerifiedDesc": "Kondisi dan harga sudah diverifikasi oleh AI Mozzy",
    "delivery": "Pengiriman",
    "meetup": "COD (Ketemu Langsung)",
    "chat": "Chat dengan Penjual",
    "report": "Laporkan",
    "boost": "Promosikan",
    "boostDesc": "Tampil lebih banyak orang di sekitar kamu"
  },

  "jobs": {
    "title": "Lowongan Kerja",
    "post": "Buka Lowongan",
    "apply": "Lamar Sekarang",
    "salary": "Gaji",
    "salaryType": {
      "monthly": "Bulanan",
      "daily": "Harian",
      "hourly": "Per Jam",
      "negotiable": "Bisa Nego"
    },
    "type": {
      "fullTime": "Full Time",
      "partTime": "Part Time",
      "freelance": "Freelance",
      "intern": "Magang"
    }
  },

  "payment": {
    "method": "Metode Pembayaran",
    "gopay": "GoPay",
    "ovo": "OVO",
    "dana": "DANA",
    "virtualAccount": "Transfer Bank (VA)",
    "alfamart": "Alfamart",
    "indomaret": "Indomaret",
    "qris": "QRIS",
    "success": "Pembayaran Berhasil!",
    "failed": "Pembayaran Gagal",
    "pending": "Menunggu Pembayaran"
  },

  "subscription": {
    "mozzyPlus": "Mozzy+",
    "business": "Bisnis+",
    "monthly": "Bulanan",
    "yearly": "Tahunan",
    "perMonth": "/bulan",
    "perYear": "/tahun",
    "upgrade": "Upgrade Sekarang",
    "benefit": "Keuntungan:"
  },

  "trust": {
    "level": {
      "new": "Anggota Baru",
      "trusted": "Terpercaya",
      "verified": "Terverifikasi",
      "hero": "Hero Lokal"
    },
    "score": "Skor Kepercayaan",
    "verifyPhone": "Verifikasi Nomor HP",
    "verifyKtp": "Verifikasi KTP"
  },

  "together": {
    "title": "Bareng Yuk!",
    "create": "Buat Ajakan",
    "join": "Gabung",
    "full": "Sudah Penuh",
    "slogan": "Sekarang, mau bareng?",
    "what": "Ngapain?",
    "when": "Kapan?",
    "where": "Di mana?",
    "maxParticipants": "Maks Peserta",
    "qrTicket": "Tiket QR"
  },

  "pom": {
    "title": "Pamer!",
    "myNeighborhood": "Kampungku",
    "trending": "Trending",
    "popular": "Populer",
    "upload": "Upload",
    "short": "Video Pendek",
    "album": "Foto Album"
  },

  "crossLink": {
    "sectionTitle": "Lainnya di {{neighborhood}}",
    "types": {
      "product": "Barang Dijual",
      "shop": "Toko Sekitar",
      "together": "Ajakan Bareng",
      "job": "Lowongan",
      "room": "Properti",
      "post": "Berita Lokal"
    }
  },

  "neighborhood": {
    "title": "Profil {{name}}",
    "activeResidents": "Warga Aktif",
    "todayPosts": "Postingan Hari Ini",
    "popularTags": "Tag Populer",
    "latestNews": "Berita Terbaru",
    "topSelling": "Paling Laris",
    "topStores": "Toko Unggulan",
    "ongoingEvents": "Acara Berlangsung",
    "topPom": "Pamer Populer"
  },

  "error": {
    "networkError": "Tidak ada koneksi internet. Coba lagi.",
    "serverError": "Server bermasalah. Coba beberapa saat lagi.",
    "locationDenied": "Akses lokasi ditolak. Aktifkan di pengaturan HP.",
    "imageTooLarge": "Foto terlalu besar. Maksimal 5MB.",
    "fillRequired": "Isi semua kolom yang wajib diisi"
  },

  "action": {
    "save": "Simpan",
    "cancel": "Batal",
    "delete": "Hapus",
    "edit": "Edit",
    "share": "Bagikan",
    "report": "Laporkan",
    "back": "Kembali",
    "next": "Lanjut",
    "confirm": "Konfirmasi",
    "loading": "Memuat...",
    "retry": "Coba Lagi",
    "seeAll": "Lihat Semua"
  }
}
```

---

## i18n 키 검증 규칙

```bash
# 신규 키 추가 시 반드시 실행
./scripts/gen-l10n.sh

# id.json이 마스터 — 다른 언어 파일의 키는 id.json 기준으로 동기화
# 누락된 키는 영어(en.json) 값으로 fallback
```

---

## 인도네시아 숫자/통화 포맷

```dart
// IDR 포맷: 인도네시아식 (점=천단위, 쉼표=소수)
// ✅ Rp 1.500.000  (1,500,000 IDR)
// ❌ Rp 1,500,000  (한국식 - 사용 금지)

String formatIDR(double amount) {
  return 'Rp ${NumberFormat('#,###', 'id_ID').format(amount)}';
  // 인도네시아 로케일에서 ',' → '.' 로 표시됨
}

// 단축형 (50만원 이상)
String formatIDRCompact(double amount) {
  if (amount >= 1000000) return 'Rp ${(amount/1000000).toStringAsFixed(1)}Jt';
  if (amount >= 1000) return 'Rp ${(amount/1000).toStringAsFixed(0)}Rb';
  return formatIDR(amount);
}
```
