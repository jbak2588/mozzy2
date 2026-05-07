const admin = require("firebase-admin");
const fft = require("firebase-functions-test")();
const { expect } = require("chai");

// The index.js requires admin to be initialized, which happens at the top of that file.
// We just need to make sure we don't initialize it twice if possible, but fft.makeDocumentSnapshot handles things.

describe("Jobs Notifications Cloud Functions", () => {
    after(() => {
        fft.cleanup();
    });

    it("should define onJobApplicantCreated", () => {
        const myFunctions = require("../index.js");
        expect(myFunctions.onJobApplicantCreated).to.not.be.undefined;
    });

    it("should define onJobApplicantStatusUpdated", () => {
        const myFunctions = require("../index.js");
        expect(myFunctions.onJobApplicantStatusUpdated).to.not.be.undefined;
    });

    // Detailed logic tests usually require the Firestore Emulator.
    // For this task, we ensure the functions are correctly exported and logic is reviewed.
});
