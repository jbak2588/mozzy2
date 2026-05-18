const admin = require('firebase-admin');
const serviceAccount = require('./service-account-file.json'); // I'll check if this exists or use default

if (!admin.apps.length) {
  admin.initializeApp({
    credential: admin.credential.applicationDefault(), // Try application default first
    projectId: 'mozzy-v2'
  });
}

const db = admin.firestore();

async function checkFeedback() {
  const yesterday = new Date();
  yesterday.setDate(yesterday.getDate() - 1);

  console.log('Checking feedback since:', yesterday.toISOString());

  try {
    const snapshot = await db.collection('feedback')
      .where('createdAt', '>=', yesterday)
      .get();

    console.log('Total feedback found:', snapshot.size);
    snapshot.forEach(doc => {
      const data = doc.data();
      console.log(`- [${doc.id}] Type: ${data.type}, Status: ${data.status}`);
      // console.log(`  Message: ${data.message.substring(0, 50)}...`);
    });
  } catch (error) {
    console.error('Error fetching feedback:', error.message);
  }
}

async function checkCrashlyticsStats() {
  // We can't easily check Crashlytics stats via Admin SDK.
  // But we can check for common "error" or "crash" keywords in custom logs if any.
}

checkFeedback();
