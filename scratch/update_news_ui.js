const fs = require('fs');

let newsFile = 'lib/mozzy_ii/domains/news/screens/local_news_detail_screen.dart';
let newsContent = fs.readFileSync(newsFile, 'utf8');

if (!newsContent.includes('ugc_boost_bottom_sheet.dart')) {
  // Add imports
  newsContent = newsContent.replace(
    /import '\.\.\/widgets\/comments_section\.dart';/,
    `import '../widgets/comments_section.dart';\nimport '../../../app/auth/auth_service.dart';\nimport '../../../core/payment/models/payment_purpose.dart';\nimport '../../../core/payment/boost/widgets/ugc_boost_bottom_sheet.dart';\nimport '../../../core/utils/formatters.dart';`
  );
  
  // Find current user logic and build the widget
  newsContent = newsContent.replace(
    /final postAsync = ref\.watch\(postByIdProvider\(postId\)\);/,
    `final postAsync = ref.watch(postByIdProvider(postId));\n    final currentUserId = ref.watch(authStateProvider).value?.uid;`
  );
  
  newsContent = newsContent.replace(
    /const SizedBox\(height: 16\),\n\s+Text\(post\.content, style: const TextStyle\(fontSize: 16\)\),/,
    `const SizedBox(height: 16),\n                if (currentUserId != null && currentUserId == post.userId) ...[\n                  if (post.boostStatus == 'active')\n                    Container(\n                      width: double.infinity,\n                      padding: const EdgeInsets.symmetric(vertical: 12),\n                      margin: const EdgeInsets.only(bottom: 8),\n                      decoration: BoxDecoration(\n                        color: Colors.green[50],\n                        borderRadius: BorderRadius.circular(8),\n                        border: Border.all(color: Colors.green[200]!),\n                      ),\n                      child: Center(\n                        child: Text(\n                          'Boost Aktif sampai \${post.boostActiveUntil != null ? MozzyFormatters.formatDateID(post.boostActiveUntil!) : "-"}',\n                          style: TextStyle(\n                            color: Colors.green[800],\n                            fontWeight: FontWeight.bold,\n                          ),\n                        ),\n                      ),\n                    )\n                  else\n                    SizedBox(\n                      width: double.infinity,\n                      height: 48,\n                      child: ElevatedButton.icon(\n                        onPressed: () => UgcBoostBottomSheet.show(\n                          context: context,\n                          title: post.title,\n                          purpose: PaymentPurpose.boostPost,\n                          sourceType: 'news',\n                          sourceId: post.id,\n                          userId: post.userId,\n                          countryCode: post.countryCode,\n                        ),\n                        icon: const Icon(Icons.rocket_launch),\n                        label: const Text('Boost Berita'),\n                        style: ElevatedButton.styleFrom(\n                          backgroundColor: Colors.teal,\n                          foregroundColor: Colors.white,\n                        ),\n                      ),\n                    ),\n                  const SizedBox(height: 16),\n                ],\n                Text(post.content, style: const TextStyle(fontSize: 16)),`
  );
  
  fs.writeFileSync(newsFile, newsContent);
  console.log('local_news_detail_screen.dart updated');
} else {
  console.log('local_news_detail_screen.dart already updated');
}
