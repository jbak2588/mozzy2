# Phase 2-B Marketplace Kickoff Spec

## 1. Purpose
Start Marketplace planning after Local News community flow is locked.

## 2. Current Dependency Status
- Auth: completed
- User profile: completed
- LocationParts: completed
- TrustScore: completed
- Integration test mode: completed
- Local News core/community flow: completed

## 3. Marketplace Scope
Included:
- ProductModel
- MarketplaceRepository
- MarketplaceListScreen
- ProductDetailScreen
- CreateProductScreen
- AI verification badge field
- IDR price
- imageUrls
- locationParts
- trustScore
- sellerId
- isAiVerified

Excluded for first commit:
- Payment
- Xendit
- escrow
- chat
- offer negotiation
- AI image verification call
- image upload pipeline

## 4. Firestore Path Proposal
countries/ID/domains/marketplace/products/{productId}

## 5. ProductModel Draft Fields
- id
- sellerId
- title
- description
- category
- price
- currencyCode: IDR
- imageUrls
- locationParts
- geoPath
- countryCode
- trustScore
- isAiVerified
- aiVerificationStatus
- createdAt
- updatedAt
- isDeleted
- viewsCount
- likesCount
- chatsCount

## 6. Contract
ProductModel should align with MozzyPostContract only where appropriate.
Do not force unrelated fields if product-specific contract is better.

## 7. Recommended Implementation Order
1. ProductModel
2. MarketplaceRepository
3. InMemoryMarketplaceRepository for integration tests
4. MarketplaceListScreen
5. ProductDetailScreen
6. CreateProductScreen
7. Automated integration test

## 8. Risks
- Image upload complexity
- AI verification cost
- Firestore index explosion
- payment/chat dependency creep

## 9. Decision
First Marketplace implementation task should be:
P2-B1 ProductModel + Repository foundation only.
