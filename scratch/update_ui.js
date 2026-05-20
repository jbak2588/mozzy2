const fs = require('fs');

let productFile = 'lib/mozzy_ii/domains/marketplace/screens/product_detail_screen.dart';
let productContent = fs.readFileSync(productFile, 'utf8');

if (!productContent.includes('ugc_boost_bottom_sheet.dart')) {
  productContent = productContent.replace(
    /import '\.\.\/\.\.\/\.\.\/core\/utils\/formatters\.dart';/,
    `import '../../../core/utils/formatters.dart';\nimport '../../../core/payment/models/payment_purpose.dart';\nimport '../../../core/payment/boost/widgets/ugc_boost_bottom_sheet.dart';`
  );
  
  productContent = productContent.replace(
    /Widget _buildSellerOwnerActions\(BuildContext context\) \{[\s\S]*?if \(!isSold\) \.\.\.\[\s+SizedBox\(\s+width: double\.infinity,\s+height: 48,/,
    `Widget _buildSellerOwnerActions(BuildContext context) {
    final isSold = product.status == ProductStatus.sold;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSold ? Colors.grey[50] : Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isSold ? Colors.grey[300]! : Colors.orange[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isSold ? Icons.check_circle_outline : Icons.storefront,
                color: isSold ? Colors.grey : Colors.orange,
              ),
              const SizedBox(width: 8),
              Text(
                isSold ? 'marketplace.sold'.tr() : 'marketplace.myProduct'.tr(),
                style: TextStyle(
                  color: isSold ? Colors.grey : Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (!isSold) ...[
            if (product.boostStatus == 'active')
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green[200]!),
                ),
                child: Center(
                  child: Text(
                    'Boost Aktif sampai \${product.boostActiveUntil != null ? MozzyFormatters.formatDateID(product.boostActiveUntil!) : "-"}',
                    style: TextStyle(
                      color: Colors.green[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            else
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () => UgcBoostBottomSheet.show(
                    context: context,
                    title: product.title,
                    purpose: PaymentPurpose.boostProduct,
                    sourceType: 'marketplace',
                    sourceId: product.id,
                    userId: product.userId,
                    countryCode: product.countryCode,
                  ),
                  icon: const Icon(Icons.rocket_launch),
                  label: const Text('Boost Produk'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 48,`
  );
  
  fs.writeFileSync(productFile, productContent);
  console.log('product_detail_screen.dart updated');
} else {
  console.log('product_detail_screen.dart already updated');
}

let jobFile = 'lib/mozzy_ii/domains/jobs/screens/job_detail_screen.dart';
let jobContent = fs.readFileSync(jobFile, 'utf8');

if (!jobContent.includes('ugc_boost_bottom_sheet.dart')) {
  jobContent = jobContent.replace(
    /import '\.\.\/\.\.\/\.\.\/core\/utils\/formatters\.dart';/,
    `import '../../../core/utils/formatters.dart';\nimport '../../../core/payment/models/payment_purpose.dart';\nimport '../../../core/payment/boost/widgets/ugc_boost_bottom_sheet.dart';`
  );
  
  // Find where to insert Boost button in Job detail
  // Job detail has _buildOwnerActions
  jobContent = jobContent.replace(
    /Widget _buildOwnerActions\(BuildContext context\) \{[\s\S]*?if \(!isClosed\) \.\.\.\[\s+SizedBox\(\s+width: double\.infinity,\s+height: 48,/,
    `Widget _buildOwnerActions(BuildContext context) {
    final isClosed = job.status == 'closed';
    final isExpired = job.status == 'expired';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (isClosed || isExpired) ? Colors.grey[50] : Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: (isClosed || isExpired) ? Colors.grey[300]! : Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                (isClosed || isExpired) ? Icons.check_circle_outline : Icons.work,
                color: (isClosed || isExpired) ? Colors.grey : Colors.blue,
              ),
              const SizedBox(width: 8),
              Text(
                (isClosed || isExpired) ? 'Status: \${job.status.toUpperCase()}' : 'jobs.myJob'.tr(),
                style: TextStyle(
                  color: (isClosed || isExpired) ? Colors.grey : Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (!isClosed && !isExpired) ...[
            if (job.boostStatus == 'active')
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green[200]!),
                ),
                child: Center(
                  child: Text(
                    'Boost Aktif sampai \${job.boostActiveUntil != null ? MozzyFormatters.formatDateID(job.boostActiveUntil!) : "-"}',
                    style: TextStyle(
                      color: Colors.green[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            else
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () => UgcBoostBottomSheet.show(
                    context: context,
                    title: job.title,
                    purpose: PaymentPurpose.boostJob,
                    sourceType: 'jobs',
                    sourceId: job.id,
                    userId: job.ownerId,
                    countryCode: job.locationParts.idAddress?.provinsi != null ? 'ID' : 'ID',
                  ),
                  icon: const Icon(Icons.rocket_launch),
                  label: const Text('Boost Lowongan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 48,`
  );
  
  fs.writeFileSync(jobFile, jobContent);
  console.log('job_detail_screen.dart updated');
} else {
  console.log('job_detail_screen.dart already updated');
}
