const { expect } = require("chai");
const admin = require("firebase-admin");
const { _testHelpers } = require("../index");

describe("Job Boost Activation Helper Tests", () => {
    const { 
        resolveBoostDurationDays, 
        calculateBoostActiveUntil, 
        shouldActivateJobBoost, 
        buildJobBoostUpdate 
    } = _testHelpers;

    describe("resolveBoostDurationDays", () => {
        it("should return metadata.durationDays if provided", () => {
            expect(resolveBoostDurationDays("job_boost_1_day", 5)).to.equal(5);
        });

        it("should return 1 for job_boost_1_day", () => {
            expect(resolveBoostDurationDays("job_boost_1_day", null)).to.equal(1);
        });

        it("should return 3 for job_boost_3_days", () => {
            expect(resolveBoostDurationDays("job_boost_3_days", undefined)).to.equal(3);
        });

        it("should return 7 for job_boost_7_days", () => {
            expect(resolveBoostDurationDays("job_boost_7_days", 0)).to.equal(7);
        });

        it("should fallback to 1 for unknown package", () => {
            expect(resolveBoostDurationDays("unknown", null)).to.equal(1);
        });
    });

    describe("calculateBoostActiveUntil", () => {
        it("should add 3 days to the start date", () => {
            const start = new Date("2026-05-08T10:00:00Z");
            const until = calculateBoostActiveUntil(start, 3);
            const expected = new Date("2026-05-11T10:00:00Z");
            expect(until.toDate().getTime()).to.equal(expected.getTime());
        });

        it("should handle Firestore Timestamp as start date", () => {
            const start = admin.firestore.Timestamp.fromDate(new Date("2026-05-08T10:00:00Z"));
            const until = calculateBoostActiveUntil(start, 1);
            const expected = new Date("2026-05-09T10:00:00Z");
            expect(until.toDate().getTime()).to.equal(expected.getTime());
        });
    });

    describe("shouldActivateJobBoost", () => {
        const baseBefore = { status: "pending" };
        const baseAfter = { 
            status: "paid", 
            productType: "jobBoost", 
            relatedDomain: "jobs" 
        };

        it("should return true for valid transition", () => {
            expect(shouldActivateJobBoost(baseBefore, baseAfter)).to.be.true;
        });

        it("should return false if already paid", () => {
            expect(shouldActivateJobBoost({ status: "paid" }, baseAfter)).to.be.false;
        });

        it("should return false if after status is not paid", () => {
            expect(shouldActivateJobBoost(baseBefore, { ...baseAfter, status: "expired" })).to.be.false;
        });

        it("should return false for different productType", () => {
            expect(shouldActivateJobBoost(baseBefore, { ...baseAfter, productType: "marketplaceBoost" })).to.be.false;
        });

        it("should return false for different relatedDomain", () => {
            expect(shouldActivateJobBoost(baseBefore, { ...baseAfter, relatedDomain: "marketplace" })).to.be.false;
        });

        it("should return false if already activated", () => {
            const afterWithMetadata = { 
                ...baseAfter, 
                metadata: { boostActivated: true } 
            };
            expect(shouldActivateJobBoost(baseBefore, afterWithMetadata)).to.be.false;
        });
    });

    describe("buildJobBoostUpdate", () => {
        it("should build correct update object", () => {
            const paymentId = "pay_123";
            const paymentData = {
                status: "paid",
                productType: "jobBoost",
                relatedDomain: "jobs",
                metadata: { packageId: "job_boost_3_days" },
                paidAt: admin.firestore.Timestamp.fromDate(new Date("2026-05-08T10:00:00Z"))
            };

            const update = buildJobBoostUpdate(paymentId, paymentData);
            
            expect(update.boostStatus).to.equal("active");
            expect(update.boostPaymentId).to.equal(paymentId);
            expect(update.boostPackageId).to.equal("job_boost_3_days");
            expect(update.boostDurationDays).to.equal(3);
            expect(update.boostSignalScore).to.equal(100.0);
            expect(update.boostActiveUntil.toDate().getTime()).to.equal(new Date("2026-05-11T10:00:00Z").getTime());
        });
    });
});
