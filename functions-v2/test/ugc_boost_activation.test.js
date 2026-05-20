const { expect } = require("chai");
const admin = require("firebase-admin");
const { _testHelpers } = require("../index");

describe("UGC Boost Activation Helper Tests", () => {
    const { 
        resolveBoostDurationDays, 
        calculateBoostActiveUntil, 
        shouldActivateUgcBoost, 
        buildUgcBoostUpdate 
    } = _testHelpers;

    describe("resolveBoostDurationDays", () => {
        it("should return metadata.durationDays if provided", () => {
            expect(resolveBoostDurationDays("boost_1d", 5)).to.equal(5);
        });

        it("should return 1 for job_boost_1_day legacy", () => {
            expect(resolveBoostDurationDays("job_boost_1_day", null)).to.equal(1);
        });

        it("should fallback to 1 for unknown package without durationDays", () => {
            expect(resolveBoostDurationDays("unknown", null)).to.equal(1);
        });
    });

    describe("shouldActivateUgcBoost", () => {
        const baseBefore = { status: "pending" };
        const baseAfter = { 
            status: "paid", 
            purpose: "boostPost", 
            sourceType: "news" 
        };

        it("should return true for valid transition", () => {
            expect(shouldActivateUgcBoost(baseBefore, baseAfter)).to.be.true;
        });

        it("should return false if already paid", () => {
            expect(shouldActivateUgcBoost({ status: "paid" }, baseAfter)).to.be.false;
        });

        it("should return false if after status is not paid", () => {
            expect(shouldActivateUgcBoost(baseBefore, { ...baseAfter, status: "expired" })).to.be.false;
        });

        it("should return false for unsupported purpose", () => {
            expect(shouldActivateUgcBoost(baseBefore, { ...baseAfter, purpose: "aiVerification" })).to.be.false;
        });

        it("should return true for legacy jobBoost", () => {
            expect(shouldActivateUgcBoost(baseBefore, { status: "paid", productType: "jobBoost", relatedDomain: "jobs" })).to.be.true;
        });

        it("should return false if already fulfilled", () => {
            const afterWithFulfillment = { 
                ...baseAfter, 
                fulfillmentStatus: "completed" 
            };
            expect(shouldActivateUgcBoost(baseBefore, afterWithFulfillment)).to.be.false;
        });
    });

    describe("buildUgcBoostUpdate", () => {
        it("should build correct update object for new boost", () => {
            const paymentId = "pay_123";
            const paymentData = {
                status: "paid",
                purpose: "boostProduct",
                metadata: { packageId: "boost_3d", durationDays: 3 },
                paidAt: admin.firestore.Timestamp.fromDate(new Date("2026-05-08T10:00:00Z"))
            };
            const targetData = {};

            const update = buildUgcBoostUpdate(paymentId, paymentData, targetData);
            
            expect(update.boostStatus).to.equal("active");
            expect(update.boostPaymentId).to.equal(paymentId);
            expect(update.boostPackageId).to.equal("boost_3d");
            expect(update.boostDurationDays).to.equal(3);
            expect(update.isPromoted).to.equal(true);
            expect(update.boostActiveUntil.toDate().getTime()).to.equal(new Date("2026-05-11T10:00:00Z").getTime());
        });

        it("should build correct update object by extending existing boost", () => {
            const paymentId = "pay_124";
            const paymentData = {
                status: "paid",
                purpose: "boostProduct",
                metadata: { packageId: "boost_1d", durationDays: 1 },
                paidAt: admin.firestore.Timestamp.fromDate(new Date("2026-05-08T10:00:00Z"))
            };
            const targetData = {
                boostActiveUntil: admin.firestore.Timestamp.fromDate(new Date("2026-05-11T10:00:00Z"))
            };

            const update = buildUgcBoostUpdate(paymentId, paymentData, targetData);
            
            // Should extend from May 11 -> May 12
            expect(update.boostActiveUntil.toDate().getTime()).to.equal(new Date("2026-05-12T10:00:00Z").getTime());
        });
    });
});
