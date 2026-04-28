import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/post_model.dart';

class LocalNewsCard extends StatelessWidget {
  final PostModel post;
  const LocalNewsCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = DateFormat.yMMMd().format(post.createdAt.toLocal());
    final location =
        '${post.location.idAddress?.kecamatan ?? ''}${post.location.idAddress != null ? ', ${post.location.idAddress!.kabupaten}' : ''}';

    return ListTile(
      leading: post.imageUrls.isNotEmpty
          ? Image.network(
              post.imageUrls.first,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
            )
          : Container(
              width: 72,
              height: 72,
              color: Colors.grey[300],
              child: const Icon(Icons.image, color: Colors.white60),
            ),
      title: Row(
        children: [
          Chip(
            label: Text(post.category, style: const TextStyle(fontSize: 12)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              post.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(post.content, maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(location, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(width: 8),
              Text(date, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ],
      ),
      onTap: () {
        // TODO: navigate to detail screen
      },
    );
  }
}
