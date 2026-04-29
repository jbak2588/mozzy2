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
}
