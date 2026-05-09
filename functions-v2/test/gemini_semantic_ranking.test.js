const { expect } = require("chai");
const myFunctions = require("../index.js");

describe("Gemini Semantic Ranking Cloud Function", () => {
    const helpers = myFunctions._testHelpers;

    it("should export rankSmartFeedWithGemini", () => {
        expect(myFunctions.rankSmartFeedWithGemini).to.not.be.undefined;
    });

    describe("mockGeminiRanking", () => {
        const items = [
            { feedItemId: "1", type: "job", title: "Admin Staff", publicSummary: "Need admin" },
            { feedItemId: "2", type: "marketplaceProduct", title: "iPhone 13", publicSummary: "Used phone" },
            { feedItemId: "3", type: "job", title: "Developer", publicSummary: "Flutter dev" }
        ];

        it("should boost job items when intent is 'loker'", () => {
            const results = helpers.mockGeminiRanking("loker", items);
            const job1 = results.find(r => r.feedItemId === "1");
            const job2 = results.find(r => r.feedItemId === "3");
            const product = results.find(r => r.feedItemId === "2");

            expect(job1.score).to.be.at.least(10);
            expect(job2.score).to.be.at.least(10);
            expect(product.score).to.equal(0);
        });

        it("should boost product items when intent is 'jual'", () => {
            const results = helpers.mockGeminiRanking("jual", items);
            const job = results.find(r => r.feedItemId === "1");
            const product = results.find(r => r.feedItemId === "2");

            expect(product.score).to.be.at.least(10);
            expect(job.score).to.equal(0);
        });

        it("should boost by keyword match", () => {
            const results = helpers.mockGeminiRanking("iphone", items);
            const product = results.find(r => r.feedItemId === "2");
            expect(product.score).to.be.at.least(15);
        });

        it("should clamp score to 30", () => {
            const results = helpers.mockGeminiRanking("Admin Staff loker", items);
            const job = results.find(r => r.feedItemId === "1");
            expect(job.score).to.be.at.most(30);
        });
    });

    describe("buildGeminiRankingPrompt", () => {
        it("should include intent and items in prompt", () => {
            const intent = "test intent";
            const items = [{ feedItemId: "1", title: "item1" }];
            const prompt = helpers.buildGeminiRankingPrompt(intent, items, "id");
            
            expect(prompt).to.contain(intent);
            expect(prompt).to.contain("item1");
            expect(prompt).to.contain("JSON");
        });
    });

    describe("clampSemanticScore", () => {
        it("should clamp scores between 0 and 30", () => {
            expect(helpers.clampSemanticScore(50)).to.equal(30);
            expect(helpers.clampSemanticScore(-10)).to.equal(0);
            expect(helpers.clampSemanticScore(25)).to.equal(25);
        });
    });
});
