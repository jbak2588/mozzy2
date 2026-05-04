# Payment & Deals Firestore Schema

## 1. Deals
Path: `countries/ID/domains/marketplace/deals/{dealId}`

- `id`: String
- `productId`: String
- `buyerId`: String
- `sellerId`: String
- `status`: String (`pending`, `confirmed`, `payment_pending`, `paid`, `completed`, `canceled`, `expired`, `disputed`)
- `confirmationCode`: String (Optional, for COD)
- `codeExpiresAt`: Timestamp (Optional)
- `completedAt`: Timestamp (Optional)
- `createdAt`: Timestamp
- `updatedAt`: Timestamp

## 2. Payments
Path: `countries/ID/domains/marketplace/payments/{externalId}`

- `externalId`: String
- `dealId`: String
- `productId`: String
- `buyerId`: String
- `sellerId`: String
- `amount`: Number
- `currencyCode`: String (default: `IDR`)
- `provider`: String (`xendit`)
- `paymentMethod`: String (Optional)
- `status`: String (`pending`, `paid`, `failed`, `expired`, `refunded`, `canceled`)
- `xenditInvoiceId`: String (Optional)
- `xenditPaymentId`: String (Optional)
- `invoiceUrl`: String (Optional)
- `webhookEventIds`: Array of Strings
- `createdAt`: Timestamp
- `updatedAt`: Timestamp
- `paidAt`: Timestamp (Optional)

## 3. Payment Events (Audit)
Path: `countries/ID/domains/marketplace/payment_events/{eventId}`

- `id`: String (Webhook event ID)
- `externalId`: String
- `provider`: String
- `eventType`: String
- `rawStatus`: String
- `normalizedStatus`: String
- `receivedAt`: Timestamp
- `processedAt`: Timestamp
- `idempotencyResult`: String (`created`, `duplicate`, `ignored`, `failed`)

## 4. Buyer Private Deal Codes
Path: `users/{buyerId}/private_deal_codes/{dealId}`

- `dealId`: String
- `buyerId`: String
- `sellerId`: String
- `productId`: String
- `confirmationCode`: String
- `codeExpiresAt`: Timestamp
- `createdAt`: Timestamp

## State Transition Rules
Client direct write is FORBIDDEN for payment status.
Webhook/Admin SDK is source of truth for online payments.
COD deals are completed via client transaction in MVP (will move to Cloud Functions).

## Security Rules Draft
- Buyer can read own deal
- Seller can read own deal
- Buyer can read own private code
- Seller cannot read buyer private code
