const { expect } = require("chai");
const admin = require("firebase-admin");
const sinon = require("sinon");
const myFunctions = require("../index.js");

describe("AI Verification Paid Trigger Helper Tests", () => {
    const helpers = myFunctions._testHelpers;

    describe("shouldTriggerAiVerification", () => {
        const baseBefore = { status: "pending" };
        const baseAfter = { 
            status: "paid", 
            provider: "xendit",
            purpose: "aiVerification",
            sourceType: "product",
            sourceId: "prod_123",
            userId: "user_123"
        };

        it("should return true for a valid transition", () => {
            expect(helpers.shouldTriggerAiVerification(baseBefore, baseAfter)).to.be.true;
        });

        it("should return false if already paid in beforeData", () => {
            expect(helpers.shouldTriggerAiVerification({ status: "paid" }, baseAfter)).to.be.false;
        });

        it("should return false if afterData status is not paid", () => {
            expect(helpers.shouldTriggerAiVerification(baseBefore, { ...baseAfter, status: "pending" })).to.be.false;
        });

        it("should return false if provider is not xendit", () => {
            expect(helpers.shouldTriggerAiVerification(baseBefore, { ...baseAfter, provider: "midtrans" })).to.be.false;
        });

        it("should return false if purpose is not aiVerification", () => {
            expect(helpers.shouldTriggerAiVerification(baseBefore, { ...baseAfter, purpose: "boostJob" })).to.be.false;
        });

        it("should return false if sourceType is not product", () => {
            expect(helpers.shouldTriggerAiVerification(baseBefore, { ...baseAfter, sourceType: "job" })).to.be.false;
        });

        it("should return false if already triggered (aiVerificationTriggeredAt exists)", () => {
            expect(helpers.shouldTriggerAiVerification(baseBefore, { ...baseAfter, aiVerificationTriggeredAt: new Date() })).to.be.false;
        });

        it("should return false if fulfillmentStatus is processing or completed", () => {
            expect(helpers.shouldTriggerAiVerification(baseBefore, { ...baseAfter, fulfillmentStatus: "processing" })).to.be.false;
            expect(helpers.shouldTriggerAiVerification(baseBefore, { ...baseAfter, fulfillmentStatus: "completed" })).to.be.false;
        });
    });

    describe("mockGeminiVerification behavior", () => {
        it("should return passed result for standard title", async () => {
            const result = await helpers.runMockGeminiVerification({
                productId: "prod_123",
                title: "Oppo A78 Bagus",
                description: "Hp mulus no minus",
                category: "Electronics",
                imageUrls: ["https://example.com/image.png"]
            });
            expect(result.status).to.equal("passed");
            expect(result.score).to.be.greaterThan(0.9);
            expect(result.conditionLabel).to.equal("good");
        });

        it("should return failed result if title contains fail", async () => {
            const result = await helpers.runMockGeminiVerification({
                productId: "prod_123",
                title: "Iphone clone fail copy",
                description: "Hp rusak no box",
                category: "Electronics",
                imageUrls: ["https://example.com/image.png"]
            });
            expect(result.status).to.equal("failed");
            expect(result.score).to.be.lessThan(0.2);
            expect(result.conditionLabel).to.equal("damaged");
        });

        it("should return failed result if title contains fraud", async () => {
            const result = await helpers.runMockGeminiVerification({
                productId: "prod_123",
                title: "Fraud AirPods Pro copy",
                description: "Cheap airpods replica",
                category: "Electronics",
                imageUrls: ["https://example.com/image.png"]
            });
            expect(result.status).to.equal("failed");
        });
    });
});
