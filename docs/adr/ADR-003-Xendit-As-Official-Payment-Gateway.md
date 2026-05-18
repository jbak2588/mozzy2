# ADR-003: Xendit as Official Payment Gateway

## Status
Accepted

## Context
The original Mozzy Indonesia development plan described Midtrans as the payment gateway.
The CTO has decided that Mozzy will use Xendit instead.

## Decision
Mozzy Indonesia will use Xendit as the official payment gateway for:
- AI verification payments
- Boost payments
- Marketplace transaction support
- QRIS
- Virtual Account
- Wallet top-up if implemented
- Subscription payments where technically applicable
- Business+ / Warung / Store monetization

## Consequences
- Any Midtrans service, config, environment variable, document, test, or workflow must be treated as deprecated.
- New payment work must use Xendit naming and architecture.
- Revenue KPI references should use Xendit payment success rate.
