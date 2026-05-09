const { expect } = require("chai");
const myFunctions = require("../index.js");

describe("Feed Interaction Logging Cloud Function", () => {
    const helpers = myFunctions._testHelpers;

    it("should export logFeedInteraction", () => {
        expect(myFunctions.logFeedInteraction).to.not.be.undefined;
    });

    describe("ALLOWED_FEED_INTERACTION_TYPES", () => {
        it("should contain required interaction types", () => {
            const types = helpers.ALLOWED_FEED_INTERACTION_TYPES;
            expect(types).to.include("impression");
            expect(types).to.include("card_tap");
            expect(types).to.include("detail_open");
            expect(types).to.include("cta_tap");
        });
    });

    describe("FORBIDDEN_FEED_INTERACTION_FIELDS", () => {
        it("should contain required forbidden fields", () => {
            const fields = helpers.FORBIDDEN_FEED_INTERACTION_FIELDS;
            expect(fields).to.include("intent");
            expect(fields).to.include("searchQuery");
            expect(fields).to.include("email");
            expect(fields).to.include("phone");
            expect(fields).to.include("exactAddress");
            expect(fields).to.include("paymentId");
            expect(fields).to.include("fcmToken");
        });
    });
});
