const fs = require('fs');
let content = fs.readFileSync('firestore.rules', 'utf8');

// Update products rules
content = content.replace(
  /allow update: if isAuthenticated\(\)\s+&& resource\.data\.sellerId == request\.auth\.uid\s+&& request\.resource\.data\.sellerId == resource\.data\.sellerId \/\/ immutable sellerId\s+&& !request\.resource\.data\.diff\(resource\.data\)\.affectedKeys\(\)\.hasAny\(\[\s+([^\]]+)\s+\]\)/g,
  (match, keys) => {
    if (!keys.includes('isPromoted')) {
      return match.replace(keys, keys + ',\n          \'isPromoted\',\n          \'boostStatus\',\n          \'boostPaymentId\',\n          \'boostPackageId\',\n          \'boostStartedAt\',\n          \'boostActiveUntil\',\n          \'boostDurationDays\'');
    }
    return match;
  }
);

// Update posts rules
content = content.replace(
  /allow update: if \(isOwner\(resource\.data\.userId\) && request\.resource\.data\.userId == resource\.data\.userId\) \|\| isAdmin\(\);/,
  `allow update: if ((isOwner(resource.data.userId) && request.resource.data.userId == resource.data.userId) || isAdmin())
        && !request.resource.data.diff(resource.data).affectedKeys().hasAny([
          'isPromoted',
          'boostStatus',
          'boostPaymentId',
          'boostPackageId',
          'boostStartedAt',
          'boostActiveUntil',
          'boostDurationDays'
        ]);`
);

fs.writeFileSync('firestore.rules', content);
console.log('firestore.rules updated');