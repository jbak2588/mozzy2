import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../geo/utils/geo_path_builder.dart';
import '../../../geo/models/location_parts.dart';
import '../../../geo/providers/location_provider.dart';
import '../models/post_model.dart';
import '../providers/posts_provider.dart';
import '../../../shared/contracts/mozzy_post_contract.dart';

// Provider that exposes current user id (easy to override in tests)
final currentUserIdProvider = Provider<String?>(
  (ref) => FirebaseAuth.instance.currentUser?.uid,
);

// Indirection to make location easily overrideable in tests.
final effectiveLocationProvider = Provider.autoDispose<AsyncValue<LocationParts?>>(
  (ref) => ref.watch(locationProvider),
);

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();
  String _category = 'umum';
  bool _isSaving = false;

  final categories = ['umum', 'info', 'event', 'darurat', 'kuliner', 'tips'];

  @override
  void dispose() {
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    // Field validation first (so tests can validate without auth/location)
    if (_titleCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('news.titleRequired'.tr())));
      return;
    }
    if (_contentCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('news.contentRequired'.tr())));
      return;
    }

    final userId = ref.read(currentUserIdProvider);
    if (userId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('news.loginRequired'.tr())));
      return;
    }

    final locationAsync = ref.read(effectiveLocationProvider);
    final location = locationAsync.maybeWhen(
      data: (l) => l,
      orElse: () => null,
    );
    if (location == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('news.locationRequired'.tr())));
      return;
    }

    setState(() => _isSaving = true);

    try {
      final repo = ref.read(postRepositoryProvider);
      final newId = repo.postsCollection.doc().id;
      final geoPath = buildIndonesiaGeoPath(location);

      // Try read trustScore from user doc - best effort
      double trustScore = 0.3;
      try {
        final userDoc = await repo.postsCollection.firestore
            .collection('users')
            .doc(userId)
            .get();
        if (userDoc.exists) {
          final data = userDoc.data() as Map<String, dynamic>?;
          if (data != null && data['trustScore'] is num)
            trustScore = (data['trustScore'] as num).toDouble();
        }
      } catch (_) {}

      final post = PostModel(
        id: newId,
        userId: userId,
        title: _titleCtrl.text.trim(),
        content: _contentCtrl.text.trim(),
        imageUrls: const [],
        category: _category,
        geoScope: GeoScope.neighborhood,
        reachMode: ReachMode.localOnly,
        translationState: {},
        trustScore: trustScore,
        signalScore: 0.0,
        geoPath: geoPath,
        location: location,
        countryCode: 'ID',
        isDeleted: false,
        reportCount: 0,
        mapVisibility: true,
        discoveryChannels: ['feed', 'search'],
        relayTargets: const [],
        createdAt: DateTime.now().toUtc(),
        updatedAt: null,
      );

      await ref.read(createLocalNewsPostProvider).call(post);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('news.createSuccess'.tr())));
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('news.createFailed'.tr())));
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationAsync = ref.watch(effectiveLocationProvider);
    final locText = locationAsync.maybeWhen(
      data: (l) => l?.idAddress != null
          ? '${l!.idAddress!.kecamatan}, ${l.idAddress!.kabupaten}'
          : 'news.locationFallback'.tr(),
      orElse: () => 'news.locationFallback'.tr(),
    );

    return Scaffold(
      appBar: AppBar(title: Text('news.createPost'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleCtrl,
              decoration: InputDecoration(hintText: 'news.titleHint'.tr()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _contentCtrl,
              maxLines: 5,
              decoration: InputDecoration(hintText: 'news.contentHint'.tr()),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _category,
              items: categories
                  .map(
                    (c) => DropdownMenuItem(
                      value: c,
                      child: Text('news.category.$c'.tr()),
                    ),
                  )
                  .toList(),
              onChanged: (v) => setState(() => _category = v ?? 'umum'),
              decoration: InputDecoration(
                labelText: 'news.selectCategory'.tr(),
              ),
            ),
            const SizedBox(height: 12),
            Text(locText, style: Theme.of(context).textTheme.bodySmall),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _onSubmit,
                child: _isSaving
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          const SizedBox(width: 8),
                          Text('news.saving'.tr()),
                        ],
                      )
                    : Text('news.submit'.tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
