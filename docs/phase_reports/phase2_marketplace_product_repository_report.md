# Phase 2 Marketplace ProductModel & Repository Report

## 1. Scope
- ProductModel implementation (Freezed)
- MarketplaceRepository implementation (Firestore)
- InMemoryMarketplaceRepository for integration tests/deterministic testing
- Marketplace providers (Riverpod)
- Firestore rules and indexes for products

## 2. Firestore Path
`countries/ID/domains/marketplace/products/{productId}`

## 3. ProductModel Fields
- `id`: String
- `userId` (mapped to `sellerId`): String
- `title`: String
- `description`: String
- `category`: String
- `price`: int
- `currencyCode`: String (default: IDR)
- `imageUrls`: List<String>
- `geoScope`: GeoScope (default: neighborhood)
- `reachMode`: ReachMode (default: localOnly)
- `translationState`: Map<String, String>
- `trustScore`: double (default: 0.3)
- `signalScore`: double
- `geoPath`: String
- `locationParts`: LocationParts?
- `countryCode`: String (default: ID)
- `isAiVerified`: bool (default: false)
- `aiVerificationStatus`: String (default: not_requested)
- `createdAt`: DateTime
- `updatedAt`: DateTime?
- `isDeleted`: bool (default: false)
- `viewsCount`: int
- `likesCount`: int
- `chatsCount`: int

## 4. Repository Methods
- `createProduct(ProductModel product)`
- `getProductById(String productId)`
- `fetchByKecamatan({required String kecamatan, int limit, DocumentSnapshot? startAfter})`
- `fetchByCategory({required String category, int limit, DocumentSnapshot? startAfter})`
- `updateProduct(ProductModel product)`
- `softDeleteProduct(String productId)`

## 5. InMemoryRepository Test Strategy
- Verified CRUD operations.
- Verified filtering by `category` and `kecamatan`.
- Verified soft delete behavior (excludes from list fetches).
- Verified sorting by `createdAt` descending.

## 6. Excluded Items (for this task)
- Payment / Xendit integration
- Image upload pipeline
- AI verification API calls
- Chat integration
- UI screens

## 7. Test Results
- `product_model_test.dart`: Passed
- `in_memory_marketplace_repository_test.dart`: Passed

## 8. Next Task
P2-B2: MarketplaceListScreen foundation
