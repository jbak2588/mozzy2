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

    describe("isValidEngagementInteraction", () => {
        it("should return true for valid interaction", () => {
            const data = { sourceType: "job", sourceId: "123", eventType: "impression" };
            expect(helpers.isValidEngagementInteraction(data)).to.be.true;
        });

        it("should return false if sourceType is missing", () => {
            const data = { sourceId: "123", eventType: "impression" };
            expect(helpers.isValidEngagementInteraction(data)).to.be.false;
        });

        it("should return false if sourceId is missing", () => {
            const data = { sourceType: "job", eventType: "impression" };
            expect(helpers.isValidEngagementInteraction(data)).to.be.false;
        });

        it("should return false if eventType is missing", () => {
            const data = { sourceType: "job", sourceId: "123" };
            expect(helpers.isValidEngagementInteraction(data)).to.be.false;
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

        it("should skip invalid interactions", () => {
            const invalidInteractions = [
                {
                    data: () => ({
                        sourceType: "job",
                        // missing sourceId
                        eventType: "impression"
                    })
                }
            ];
            const groups = helpers.groupFeedInteractions(invalidInteractions);
            expect(Object.keys(groups)).to.have.lengthOf(0);
        });

        it("should not count 'unknown' sessionId in uniqueSessionCount", () => {
            const mockWithUnknownSession = [
                {
                    data: () => ({
                        sourceType: "job",
                        sourceId: "job1",
                        eventType: "impression",
                        sessionId: "unknown"
                    })
                },
                {
                    data: () => ({
                        sourceType: "job",
                        sourceId: "job1",
                        eventType: "impression",
                        sessionId: "real-session"
                    })
                }
            ];
            const groups = helpers.groupFeedInteractions(mockWithUnknownSession);
            expect(groups.job_job1.sessions.size).to.equal(1);
            expect(groups.job_job1.sessions.has("real-session")).to.be.true;
            expect(groups.job_job1.sessions.has("unknown")).to.be.false;
        });

        it("should exclude interactions with medium or high abuse severity", () => {
            const interactions = [
                {
                    data: () => ({
                        sourceType: "job", sourceId: "123", feedItemId: "fi", eventType: "impression", sessionId: "s1",
                        abuseCheck: { severity: "high" }
                    })
                },
                {
                    data: () => ({
                        sourceType: "job", sourceId: "123", feedItemId: "fi", eventType: "card_tap", sessionId: "s1",
                        abuseCheck: { severity: "medium" }
                    })
                },
                {
                    data: () => ({
                        sourceType: "job", sourceId: "123", feedItemId: "fi", eventType: "detail_open", sessionId: "s1",
                        abuseCheck: { severity: "none" }
                    })
                }
            ];
            const groups = helpers.groupFeedInteractions(interactions);
            expect(groups.job_123.counts.impression).to.equal(0);
            expect(groups.job_123.counts.card_tap).to.equal(0);
            expect(groups.job_123.counts.detail_open).to.equal(1);
        });

        it("should cap impressions to 1 per session", () => {
            const interactions = Array.from({ length: 5 }).map(() => ({
                data: () => ({ sourceType: "job", sourceId: "123", feedItemId: "fi", eventType: "impression", sessionId: "s1" })
            }));
            const groups = helpers.groupFeedInteractions(interactions);
            expect(groups.job_123.counts.impression).to.equal(1);
        });

        it("should cap card_tap to 3 per session", () => {
            const interactions = Array.from({ length: 10 }).map(() => ({
                data: () => ({ sourceType: "job", sourceId: "123", feedItemId: "fi", eventType: "card_tap", sessionId: "s1" })
            }));
            const groups = helpers.groupFeedInteractions(interactions);
            expect(groups.job_123.counts.card_tap).to.equal(3);
        });
    });

    describe("sanitizeFeedInteractionPayload", () => {
        const basePayload = {
            eventType: "impression",
            feedItemId: "fi1",
            sourceId: "src1",
            sourceType: "job",
            route: "/jobs/1",
            position: 1,
            isPromoted: false,
            hasSemanticIntent: false,
            intentLengthBucket: "none"
        };

        it("should allow valid interaction and set abuse severity to none", () => {
            const result = helpers.sanitizeFeedInteractionPayload(basePayload, "uid123");
            expect(result.abuseCheck).to.exist;
            expect(result.abuseCheck.severity).to.equal("none");
            expect(result.abuseCheck.isSuspicious).to.be.false;
        });

        it("should reject invalid sourceType", () => {
            const payload = { ...basePayload, sourceType: "invalid_type" };
            expect(() => helpers.sanitizeFeedInteractionPayload(payload, "uid123"))
                .to.throw("Invalid source type: invalid_type");
        });

        it("should reject forbidden top-level fields like searchQuery", () => {
            const payload = { ...basePayload, searchQuery: "loker" };
            expect(() => helpers.sanitizeFeedInteractionPayload(payload, "uid123"))
                .to.throw("Forbidden top-level field: searchQuery");
        });

        it("should mark position out of bounds as suspicious (medium severity)", () => {
            const payload = { ...basePayload, position: 1000 };
            const result = helpers.sanitizeFeedInteractionPayload(payload, "uid123");
            expect(result.abuseCheck.severity).to.equal("medium");
            expect(result.abuseCheck.reason).to.equal("suspicious_position");
        });

        it("should allow valid viewport impression", () => {
            const payload = {
                ...basePayload,
                impressionMode: "viewport",
                visibleRatio: 0.6,
                dwellMs: 1000
            };
            const result = helpers.sanitizeFeedInteractionPayload(payload, "uid123");
            expect(result.impressionMode).to.equal("viewport");
            expect(result.visibleRatio).to.equal(0.6);
            expect(result.dwellMs).to.equal(1000);
        });

        it("should reject viewport impression if visibleRatio < 0.5", () => {
            const payload = {
                ...basePayload,
                impressionMode: "viewport",
                visibleRatio: 0.49,
                dwellMs: 1000
            };
            expect(() => helpers.sanitizeFeedInteractionPayload(payload, "uid123"))
                .to.throw("Viewport impression must have visibleRatio >= 0.5");
        });

        it("should reject viewport impression if dwellMs < 800", () => {
            const payload = {
                ...basePayload,
                impressionMode: "viewport",
                visibleRatio: 0.8,
                dwellMs: 799
            };
            expect(() => helpers.sanitizeFeedInteractionPayload(payload, "uid123"))
                .to.throw("Viewport impression must have 800 <= dwellMs <= 60000");
        });

        it("should reject viewport impression if dwellMs > 60000", () => {
            const payload = {
                ...basePayload,
                impressionMode: "viewport",
                visibleRatio: 0.8,
                dwellMs: 60001
            };
            expect(() => helpers.sanitizeFeedInteractionPayload(payload, "uid123"))
                .to.throw("Viewport impression must have 800 <= dwellMs <= 60000");
        });

        it("should ignore invalid fields like userId, sessionId, searchQuery from metadata", () => {
            const payload = {
                ...basePayload,
                metadata: {
                    userId: "hidden",
                    searchQuery: "buy car"
                }
            };
            const result = helpers.sanitizeFeedInteractionPayload(payload, "uid123");
            expect(result.metadata.userId).to.be.undefined;
            expect(result.metadata.searchQuery).to.be.undefined;
            expect(result.userId).to.equal("uid123");
        });
    });
});
