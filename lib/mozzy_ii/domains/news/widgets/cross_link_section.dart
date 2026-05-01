import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CrossLinkSection extends StatelessWidget {
  const CrossLinkSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'news.relatedLocalItems'.tr(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'news.crossLinkDescription'.tr(),
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 16),
          // TODO: Add marketplace, stores, together cross links here in the future
          const Center(child: Icon(Icons.link, size: 32, color: Colors.grey)),
        ],
      ),
    );
  }
}
