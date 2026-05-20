const fs = require('fs');

let productFile = 'lib/mozzy_ii/domains/marketplace/screens/product_detail_screen.dart';
let productContent = fs.readFileSync(productFile, 'utf8');

productContent = productContent.replace(
  /SizedBox\(\s*width: double\.infinity,\s*height: 48,\s*child: OutlinedButton\.icon\(\s*onPressed: \(\) => context\.push\('\/marketplace\/deals\?tab=sales'\),\s*icon: const Icon\(Icons\.receipt_long\),\s*label: Text\('marketplace\.openSalesCod'\.tr\(\)\),\s*\),\s*\),/,
  `if (product.boostStatus == 'active')
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
            $&`
);
fs.writeFileSync(productFile, productContent);
console.log('product_detail_screen.dart fixed');

let newsFile = 'lib/mozzy_ii/domains/news/screens/local_news_detail_screen.dart';
let newsContent = fs.readFileSync(newsFile, 'utf8');

newsContent = newsContent.replace(
  /const SizedBox\(height: 16\),\n\s*Text\(post\.content, style: const TextStyle\(fontSize: 16\)\),/,
  `const SizedBox(height: 16),
                if (currentUserId != null && currentUserId == post.userId) ...[
                  if (post.boostStatus == 'active')
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
                          'Boost Aktif sampai \${post.boostActiveUntil != null ? MozzyFormatters.formatDateID(post.boostActiveUntil!) : "-"}',
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
                          title: post.title,
                          purpose: PaymentPurpose.boostPost,
                          sourceType: 'news',
                          sourceId: post.id,
                          userId: post.userId,
                          countryCode: post.countryCode,
                        ),
                        icon: const Icon(Icons.rocket_launch),
                        label: const Text('Boost Berita'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                ],
                Text(post.content, style: const TextStyle(fontSize: 16)),`
);

fs.writeFileSync(newsFile, newsContent);
console.log('local_news_detail_screen.dart fixed');
