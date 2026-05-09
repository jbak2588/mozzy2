const { expect } = require("chai");
const myFunctions = require("../index.js");

describe("Feed Engagement Aggregation Cloud Function", () => {
    const helpers = myFunctions._testHelpers;

    it("should export aggregateFeedEngagement", () => {
        expect(myFunctions.aggregateFeedEngagement).to.not.be.undefined;
    });

    describe("calculateEngagementScore", () => {
        it("should calculate correct score based on weights", () => {
            const counts = {
                impression: 10,  // 10 * 0.1 = 1.0
                card_tap: 2,     // 2 * 2.0 = 4.0
                detail_open: 1,  // 1 * 3.0 = 3.0
                cta_tap: 1,      // 1 * 5.0 = 5.0
                semantic_intent: 2 // 2 * 0.5 = 1.0
            };
            // Total = 1.0 + 4.0 + 3.0 + 5.0 + 1.0 = 14.0
            expect(helpers.calculateEngagementScore(counts)).to.equal(14.0);
        });

        it("should clamp maximum score to 30.0", () => {
            const counts = {
                cta_tap: 10 // 10 * 5.0 = 50.0
            };
            expect(helpers.calculateEngagementScore(counts)).to.equal(30.0);
        });

        it("should handle missing event types", () => {
            expect(helpers.calculateEngagementScore({})).to.equal(0.0);
        });
    });

    describe("buildEngagementSummaryId", () => {
        it("should combine sourceType and sourceId", () => {
            expect(helpers.buildEngagementSummaryId("job", "123")).to.equal("job_123");
            expect(helpers.buildEngagementSummaryId("marketplaceProduct", "abc")).to.equal("marketplaceProduct_abc");
        });
    });

    describe("groupFeedInteractions", () => {
        const mockInteractions = [
            {
                data: () => ({
                    sourceType: "job",
                    sourceId: "job1",
                    feedItemId: "fi1",
                    eventType: "impression",
                    sessionId: "s1",
                    createdAt: new Date("2026-05-10T00:00:00Z")
                })
            },
            {
                data: () => ({
                    sourceType: "job",
                    sourceId: "job1",
                    feedItemId: "fi1",
                    eventType: "card_tap",
                    sessionId: "s1",
                    hasSemanticIntent: true,
                    createdAt: new Date("2026-05-10T00:01:00Z")
                })
            },
            {
                data: () => ({
                    sourceType: "marketplace",
                    sourceId: "prod1",
                    feedItemId: "fi2",
                    eventType: "cta_tap",
                    sessionId: "s2",
                    createdAt: new Date("2026-05-10T00:02:00Z")
                })
            }
        ];

        it("should group by summaryId and count events", () => {
            const groups = helpers.groupFeedInteractions(mockInteractions);
            
            expect(groups).to.have.property("job_job1");
            expect(groups.job_job1.counts.impression).to.equal(1);
            expect(groups.job_job1.counts.card_tap).to.equal(1);
            expect(groups.job_job1.counts.semantic_intent).to.equal(1);
            expect(groups.job_job1.sessions.size).to.equal(1);
            expect(groups.job_job1.feedItemId).to.equal("fi1");

            expect(groups).to.have.property("marketplace_prod1");
            expect(groups.marketplace_prod1.counts.cta_tap).to.equal(1);
            expect(groups.marketplace_prod1.sessions.size).to.equal(1);
        });

        it("should ignore unknown event types for counting", () => {
            const unknownEvent = [
                {
                    data: () => ({
                        sourceType: "job",
                        sourceId: "job1",
                        eventType: "view_profile" // not in weights
                    })
                }
            ];
            const groups = helpers.groupFeedInteractions(unknownEvent);
            expect(groups.job_job1.counts.impression).to.equal(0);
        });
    });
});
