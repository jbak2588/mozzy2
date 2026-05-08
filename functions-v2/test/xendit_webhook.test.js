const { expect } = require("chai");
const { _testHelpers } = require("../index");

describe("Xendit Webhook Helper Tests", () => {
    describe("mapXenditInvoiceStatus", () => {
        const { mapXenditInvoiceStatus } = _testHelpers;

        it("should map PAID to paid", () => {
            expect(mapXenditInvoiceStatus("PAID")).to.equal("paid");
        });

        it("should map SETTLED to paid", () => {
            expect(mapXenditInvoiceStatus("SETTLED")).to.equal("paid");
        });

        it("should map EXPIRED to expired", () => {
            expect(mapXenditInvoiceStatus("EXPIRED")).to.equal("expired");
        });

        it("should map FAILED to failed", () => {
            expect(mapXenditInvoiceStatus("FAILED")).to.equal("failed");
        });

        it("should map PENDING to pending", () => {
            expect(mapXenditInvoiceStatus("PENDING")).to.equal("pending");
        });

        it("should map ACTIVE to pending", () => {
            expect(mapXenditInvoiceStatus("ACTIVE")).to.equal("pending");
        });

        it("should default to pending for unknown status", () => {
            expect(mapXenditInvoiceStatus("UNKNOWN")).to.equal("pending");
        });
    });

    describe("shouldSkipUpdate", () => {
        const { shouldSkipUpdate } = _testHelpers;

        it("should skip if statuses are identical", () => {
            expect(shouldSkipUpdate("paid", "paid")).to.be.true;
        });

        it("should allow pending -> paid", () => {
            expect(shouldSkipUpdate("pending", "paid")).to.be.false;
        });

        it("should allow pending -> expired", () => {
            expect(shouldSkipUpdate("pending", "expired")).to.be.false;
        });

        it("should prevent paid -> pending (downgrade)", () => {
            expect(shouldSkipUpdate("paid", "pending")).to.be.true;
        });

        it("should prevent paid -> expired (downgrade)", () => {
            expect(shouldSkipUpdate("paid", "expired")).to.be.true;
        });

        it("should allow expired -> paid (special case)", () => {
            expect(shouldSkipUpdate("expired", "paid")).to.be.false;
        });

        it("should prevent failed -> pending (downgrade)", () => {
            expect(shouldSkipUpdate("failed", "pending")).to.be.true;
        });

        it("should allow created -> pending", () => {
            expect(shouldSkipUpdate("created", "pending")).to.be.false;
        });
    });
});
