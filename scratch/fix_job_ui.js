const fs = require('fs');

let file = 'lib/mozzy_ii/domains/jobs/screens/job_detail_screen.dart';
let content = fs.readFileSync(file, 'utf8');

content = content.replace(
  /onPressed: job\.isBoostActive \? null : \(\) => context\.push\('\/jobs\/\$\{job\.id\}\/boost'\),/,
  `onPressed: job.isBoostActive ? null : () => UgcBoostBottomSheet.show(
                  context: context,
                  title: job.title,
                  purpose: PaymentPurpose.boostJob,
                  sourceType: 'jobs',
                  sourceId: job.id,
                  userId: job.ownerId,
                  countryCode: 'ID',
                ),`
);

fs.writeFileSync(file, content);
console.log('job_detail_screen.dart UI fixed');
