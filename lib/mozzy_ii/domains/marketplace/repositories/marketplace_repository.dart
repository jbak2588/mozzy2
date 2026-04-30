import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class MarketplaceRepository {
  final FirebaseFirestore _fs;
  static const String countryId = 'ID';
  static const String domainId = 'marketplace';

  MarketplaceRepository([FirebaseFirestore? fs])
    : _fs = fs ?? FirebaseFirestore.instance;

  String productsCollectionPath([String? country]) {
    final c = country ?? countryId;
    return 'countries/$c/domains/$domainId/products';
  }

  CollectionReference get productsCollection =>
      _fs.collection(productsCollectionPath());

  Future<String> createProduct(ProductModel product) async {
    final docRef = productsCollection.doc(product.id);
    await docRef.set(product.toJson());
    return docRef.id;
  }

  Future<ProductModel?> getProductById(String productId) async {
    final doc = await productsCollection.doc(productId).get();
    if (!doc.exists) return null;
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel.fromJson({...data, 'id': doc.id});
  }

  Future<List<ProductModel>> fetchByKecamatan({
    required String kecamatan,
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async {
    Query query = productsCollection
        .where('isDeleted', isEqualTo: false)
        .where('locationParts.idAddress.kecamatan', isEqualTo: kecamatan)
        .orderBy('createdAt', descending: true)
        .limit(limit);

    if (startAfter != null) query = query.startAfterDocument(startAfter);

    final snap = await query.get();
    return snap.docs
        .map(
          (d) => ProductModel.fromJson({
            ...d.data() as Map<String, dynamic>,
            'id': d.id,
          }),
        )
        .toList();
  }

  Future<List<ProductModel>> fetchByCategory({
    required String category,
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async {
    Query query = productsCollection
        .where('isDeleted', isEqualTo: false)
        .where('category', isEqualTo: category)
        .orderBy('createdAt', descending: true)
        .limit(limit);

    if (startAfter != null) query = query.startAfterDocument(startAfter);

    final snap = await query.get();
    return snap.docs
        .map(
          (d) => ProductModel.fromJson({
            ...d.data() as Map<String, dynamic>,
            'id': d.id,
          }),
        )
        .toList();
  }

  Future<void> updateProduct(ProductModel product) async {
    final docRef = productsCollection.doc(product.id);
    await docRef.set(product.toJson(), SetOptions(merge: true));
  }

  Future<void> softDeleteProduct(String productId) async {
    final now = DateTime.now().toUtc();
    await productsCollection.doc(productId).set({
      'isDeleted': true,
      'updatedAt': now,
    }, SetOptions(merge: true));
  }

  // --- Like Methods ---

  Future<bool> isProductLikedByUser({
    required String productId,
    required String userId,
  }) async {
    final doc = await productsCollection
        .doc(productId)
        .collection('likes')
        .doc(userId)
        .get();
    return doc.exists;
  }

  Future<void> likeProduct({
    required String productId,
    required String userId,
  }) async {
    final productRef = productsCollection.doc(productId);
    final likeRef = productRef.collection('likes').doc(userId);

    await _fs.runTransaction((transaction) async {
      final likeSnapshot = await transaction.get(likeRef);
      if (likeSnapshot.exists) return;

      transaction.set(likeRef, {
        'userId': userId,
        'productId': productId,
        'createdAt': FieldValue.serverTimestamp(),
      });

      transaction.update(productRef, {
        'likesCount': FieldValue.increment(1),
      });
    });
  }

  Future<void> unlikeProduct({
    required String productId,
    required String userId,
  }) async {
    final productRef = productsCollection.doc(productId);
    final likeRef = productRef.collection('likes').doc(userId);

    await _fs.runTransaction((transaction) async {
      final likeSnapshot = await transaction.get(likeRef);
      if (!likeSnapshot.exists) return;

      transaction.delete(likeRef);

      // likesCount should never be below 0. 
      // Firestore increment doesn't have min check, so we manually check current value.
      final productSnapshot = await transaction.get(productRef);
      final currentLikes = (productSnapshot.data() as Map<String, dynamic>?)?['likesCount'] ?? 0;
      
      if (currentLikes > 0) {
        transaction.update(productRef, {
          'likesCount': FieldValue.increment(-1),
        });
      }
    });
  }
}
