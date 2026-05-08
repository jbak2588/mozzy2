const { expect } = require("chai");
const admin = require("firebase-admin");
const { _testHelpers } = require("../index");

describe("Boost Expiry Scheduler Helper Tests", () => {
    const { 
        isBoostExpiredForScheduler, 
        buildBoostExpiredUpdate,
        buildAuditLogData,
        buildAuditLogId
    } = _testHelpers;

    describe("isBoostExpiredForScheduler", () => {
        const now = admin.firestore.Timestamp.fromDate(new Date("2026-05-08T10:00:00Z"));

        it("should return true if boost is active and expired", () => {
            const job = {
                boostStatus: "active",
                boostActiveUntil: admin.firestore.Timestamp.fromDate(new Date("2026-05-08T09:59:59Z"))
            };
            expect(isBoostExpiredForScheduler(job, now)).to.be.true;
        });

        it("should return true if boost is active and exactly now", () => {
            const job = {
                boostStatus: "active",
                boostActiveUntil: now
            };
            expect(isBoostExpiredForScheduler(job, now)).to.be.true;
        });

        it("should return false if boost is active but not yet expired", () => {
            const job = {
                boostStatus: "active",
                boostActiveUntil: admin.firestore.Timestamp.fromDate(new Date("2026-05-08T10:00:01Z"))
            };
            expect(isBoostExpiredForScheduler(job, now)).to.be.false;
        });

        it("should return false if boostStatus is not active", () => {
            const job = {
                boostStatus: "expired",
                boostActiveUntil: admin.firestore.Timestamp.fromDate(new Date("2026-05-08T09:00:00Z"))
            };
            expect(isBoostExpiredForScheduler(job, now)).to.be.false;
        });

        it("should return false if boostActiveUntil is missing", () => {
            const job = {
                boostStatus: "active"
            };
            expect(isBoostExpiredForScheduler(job, now)).to.be.false;
        });
    });

    describe("buildBoostExpiredUpdate", () => {
        it("should return correct update payload", () => {
            const update = buildBoostExpiredUpdate();
            expect(update.boostStatus).to.equal("expired");
            expect(update.boostSignalScore).to.equal(0.0);
            expect(update.updatedAt).to.be.instanceOf(admin.firestore.Timestamp);
        });
    });

    describe("Audit Log Helpers", () => {
        it("buildAuditLogData should create valid data object", () => {
            const logData = buildAuditLogData({
                type: "job_boost_activated",
                relatedDomain: "jobs",
                relatedId: "job_1",
                paymentId: "pay_1",
                actorType: "system",
                afterStatus: "active"
            });

            expect(logData.type).to.equal("job_boost_activated");
            expect(logData.relatedDomain).to.equal("jobs");
            expect(logData.relatedId).to.equal("job_1");
            expect(logData.paymentId).to.equal("pay_1");
            expect(logData.actorType).to.equal("system");
            expect(logData.afterStatus).to.equal("active");
            expect(logData.createdAt).to.be.instanceOf(admin.firestore.Timestamp);
        });

        it("buildAuditLogId should be deterministic for activation", () => {
            const id1 = buildAuditLogId("job_boost_activated", "job_1", "pay_1");
            const id2 = buildAuditLogId("job_boost_activated", "job_1", "pay_1");
            expect(id1).to.equal("job_boost_activated_pay_1");
            expect(id1).to.equal(id2);
        });

        it("buildAuditLogId should be unique for expiry", (done) => {
            const id1 = buildAuditLogId("job_boost_expired", "job_1");
            setTimeout(() => {
                const id2 = buildAuditLogId("job_boost_expired", "job_1");
                expect(id1).to.not.equal(id2);
                expect(id1).to.contain("job_boost_expired_job_1_");
                done();
            }, 2);
        });
    });
});
