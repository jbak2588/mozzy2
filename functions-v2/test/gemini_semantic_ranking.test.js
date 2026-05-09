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
            expect(helpers.clampSemanticScore(25.5)).to.equal(25.5);
            expect(helpers.clampSemanticScore("20")).to.equal(20);
            expect(helpers.clampSemanticScore("invalid")).to.equal(0);
        });
    });

    describe("normalizeSemanticIntent", () => {
        it("should trim and truncate intent", () => {
            const longIntent = "  " + "a".repeat(150) + "  ";
            const normalized = helpers.normalizeSemanticIntent(longIntent);
            expect(normalized.length).to.equal(100);
            expect(normalized.startsWith(" ")).to.be.false;
            expect(normalized.endsWith(" ")).to.be.false;
        });

        it("should handle null/empty intent", () => {
            expect(helpers.normalizeSemanticIntent(null)).to.equal("");
            expect(helpers.normalizeSemanticIntent("")).to.equal("");
        });
    });

    describe("sanitizeSemanticRankingItems", () => {
        it("should limit to 30 items", () => {
            const items = Array(50).fill({ feedItemId: "1" });
            const sanitized = helpers.sanitizeSemanticRankingItems(items);
            expect(sanitized.length).to.equal(30);
        });

        it("should only keep allowed fields and remove sensitive ones", () => {
            const items = [{
                feedItemId: "1",
                title: "Job",
                ownerId: "user123", // Forbidden
                email: "test@example.com", // Forbidden
                paymentId: "pay999" // Forbidden
            }];
            const sanitized = helpers.sanitizeSemanticRankingItems(items);
            expect(sanitized[0].feedItemId).to.equal("1");
            expect(sanitized[0].title).to.equal("Job");
            expect(sanitized[0].ownerId).to.be.undefined;
            expect(sanitized[0].email).to.be.undefined;
            expect(sanitized[0].paymentId).to.be.undefined;
        });
    });

    describe("parseGeminiRankingResponse", () => {
        const items = [{ feedItemId: "1" }, { feedItemId: "2" }];

        it("should parse valid JSON response", () => {
            const content = JSON.stringify({
                results: [
                    { feedItemId: "1", score: 25.5, reason: "Match" },
                    { feedItemId: "2", score: 5.0, reason: "Low" }
                ]
            });
            const results = helpers.parseGeminiRankingResponse(content, items);
            expect(results.length).to.equal(2);
            expect(results[0].score).to.equal(25.5);
            expect(results[1].score).to.equal(5.0);
        });

        it("should handle malformed JSON", () => {
            const content = "invalid json";
            expect(() => helpers.parseGeminiRankingResponse(content, items)).to.throw("Invalid response format");
        });

        it("should handle missing items in response with score 0", () => {
            const content = JSON.stringify({
                results: [{ feedItemId: "1", score: 10 }]
            });
            const results = helpers.parseGeminiRankingResponse(content, items);
            expect(results[0].score).to.equal(10);
            expect(results[1].score).to.equal(0);
            expect(results[1].reason).to.equal("No specific reason provided");
        });

        it("should clamp scores from Gemini", () => {
            const content = JSON.stringify({
                results: [{ feedItemId: "1", score: 100 }, { feedItemId: "2", score: -50 }]
            });
            const results = helpers.parseGeminiRankingResponse(content, items);
            expect(results[0].score).to.equal(30);
            expect(results[1].score).to.equal(0);
        });
    });
});
