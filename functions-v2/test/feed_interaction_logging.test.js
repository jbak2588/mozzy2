const { expect } = require("chai");
const myFunctions = require("../index.js");

describe("Feed Interaction Logging Cloud Function", () => {
    const helpers = myFunctions._testHelpers;

    it("should export logFeedInteraction", () => {
        expect(myFunctions.logFeedInteraction).to.not.be.undefined;
    });

    describe("isAllowedFeedInteractionType", () => {
        it("should allow standard snake_case types", () => {
            expect(helpers.isAllowedFeedInteractionType("impression")).to.be.true;
            expect(helpers.isAllowedFeedInteractionType("card_tap")).to.be.true;
            expect(helpers.isAllowedFeedInteractionType("detail_open")).to.be.true;
            expect(helpers.isAllowedFeedInteractionType("cta_tap")).to.be.true;
        });

        it("should reject camelCase types", () => {
            expect(helpers.isAllowedFeedInteractionType("cardTap")).to.be.false;
            expect(helpers.isAllowedFeedInteractionType("detailOpen")).to.be.false;
        });
    });

    describe("clampInteractionPosition", () => {
        it("should clamp values between 0 and 100", () => {
            expect(helpers.clampInteractionPosition(50)).to.equal(50);
            expect(helpers.clampInteractionPosition(150)).to.equal(100);
            expect(helpers.clampInteractionPosition(-10)).to.equal(0);
        });

        it("should handle strings and invalid numbers", () => {
            expect(helpers.clampInteractionPosition("25")).to.equal(25);
            expect(helpers.clampInteractionPosition("abc")).to.equal(0);
        });
    });

    describe("sanitizeFeedInteractionMetadata", () => {
        it("should remove forbidden fields", () => {
            const raw = {
                validField: "value",
                intent: "secret intent",
                email: "test@example.com",
                phone: "0812",
                userId: "uid123",
                ownerId: "owner456"
            };
            const sanitized = helpers.sanitizeFeedInteractionMetadata(raw);
            expect(sanitized).to.have.property("validField");
            expect(sanitized).to.not.have.property("intent");
            expect(sanitized).to.not.have.property("email");
            expect(sanitized).to.not.have.property("phone");
            expect(sanitized).to.not.have.property("userId");
            expect(sanitized).to.not.have.property("ownerId");
        });
    });

    describe("sanitizeFeedInteractionPayload", () => {
        const validData = {
            eventType: "impression",
            feedItemId: "item1",
            sourceId: "src1",
            sourceType: "job",
            position: 5,
            sessionId: "session123",
            intentLengthBucket: "medium"
        };
        const uid = "user99";

        it("should build valid interaction data", () => {
            const result = helpers.sanitizeFeedInteractionPayload(validData, uid);
            expect(result.userId).to.equal(uid);
            expect(result.eventType).to.equal("impression");
            expect(result.sessionId).to.equal("session123");
            expect(result.intentLengthBucket).to.equal("medium");
        });

        it("should throw for missing required fields", () => {
            expect(() => helpers.sanitizeFeedInteractionPayload({ ...validData, feedItemId: "" }, uid)).to.throw();
            expect(() => helpers.sanitizeFeedInteractionPayload({ ...validData, eventType: "unknown" }, uid)).to.throw();
        });

        it("should fallback for sessionId and intentLengthBucket", () => {
            const data = { ...validData };
            delete data.sessionId;
            delete data.intentLengthBucket;
            
            const result = helpers.sanitizeFeedInteractionPayload(data, uid);
            expect(result.sessionId).to.equal("unknown");
            expect(result.intentLengthBucket).to.equal("none");
        });

        it("should reject invalid intentLengthBucket values", () => {
            const data = { ...validData, intentLengthBucket: "very_long" };
            const result = helpers.sanitizeFeedInteractionPayload(data, uid);
            expect(result.intentLengthBucket).to.equal("none");
        });
    });
});
