# ADR-005: Smart Feed Pagination, Boost, and Materialized Feed Policy

## Status
Accepted

## Context
The Mozzy Smart Feed currently integrates Berita, Marketplace, and Jobs by merging three separate Firestore queries on the client side. It applies a complex ranking algorithm involving `signalScore` (official formula), time-based weighting (WIB/WITA/WIT), and diversity reranking (iterative penalty).

As of P6-S27, deep pagination is not supported, and boosted items use a fixed `+100.0` score override.

## Decision

### 1. Multi-Source Integration Strategy
- **Beta 1**: Maintain the **Client-Side Merge** strategy. It is cost-effective for a small number of sources (3) and manageable for the initial tester group.
- **Beta 2 / Scale Phase**: Migrate to a **Materialized Feed** (`smart_feed_items` collection). This will be triggered when the number of sources exceeds 5 or when query performance degrades.

### 2. Pagination Policy
- **Beta 1**: The feed is **First-Page Optimized**. We will fetch a fixed maximum number of items (default 60, roughly 20 per source) to ensure stability and ranking consistency.
- **Reason**: Reranking and diversity penalties make standard Firestore cursors (`startAfter`) unreliable across multiple streams.
- **Future**: Cursors will be implemented once the Materialized Feed is in place, allowing for a single, stable sort order.

### 3. Boost Policy
- **Beta 1**: Maintain the **Fixed Score Override** (`+100.0`). This ensures promoted items are always at the top for early visibility testing.
- **Beta 2**: Implement a **Promoted Layer** approach. Promoted items will be served in dedicated slots (e.g., top 2 positions, then every 10th item) to prevent them from overwhelming the `signalScore` (0.0~1.0) logic.

### 4. Constants and Limits
- **Source Limit**: Each source query is capped to `limit / sourceCount`.
- **Global Limit**: The final merged and ranked list is capped to a sensible value for mobile memory (default 60).

## Consequences
- Deep scrolling is intentionally limited in Beta 1.
- Ranking logic remains pure in the application layer.
- Xendit foundation can proceed without waiting for a complex feed rewrite.
