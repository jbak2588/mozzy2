import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/payment_model.dart';
import '../models/payment_status.dart';
import 'payment_repository.dart';

class FirestorePaymentRepository implements PaymentRepository {
  final FirebaseFirestore _firestore;

  FirestorePaymentRepository(this._firestore);

  CollectionReference get _paymentsRef => _firestore.collection('payments');

  @override
  Future<String> createPayment(PaymentModel payment) async {
    final docRef = _paymentsRef.doc(payment.id.isEmpty ? null : payment.id);
    final finalPayment = payment.id.isEmpty ? payment.copyWith(id: docRef.id) : payment;
    await docRef.set(finalPayment.toJson());
    return docRef.id;
  }

  @override
  Stream<PaymentModel?> watchPayment(String paymentId) {
    return _paymentsRef.doc(paymentId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return PaymentModel.fromJson(doc.data() as Map<String, dynamic>);
    });
  }

  @override
  Future<PaymentModel?> fetchPayment(String paymentId) async {
    final doc = await _paymentsRef.doc(paymentId).get();
    if (!doc.exists) return null;
    return PaymentModel.fromJson(doc.data() as Map<String, dynamic>);
  }

  @override
  Future<void> markPaymentPending(String paymentId) {
    return _paymentsRef.doc(paymentId).update({
      'status': PaymentStatus.pending.name,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> markPaymentPaid(String paymentId, {DateTime? paidAt}) {
    return _paymentsRef.doc(paymentId).update({
      'status': PaymentStatus.paid.name,
      'paidAt': paidAt != null ? Timestamp.fromDate(paidAt) : FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> markPaymentFailed(String paymentId, {String? reason}) {
    return _paymentsRef.doc(paymentId).update({
      'status': PaymentStatus.failed.name,
      'metadata.failReason': reason,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> markPaymentExpired(String paymentId) {
    return _paymentsRef.doc(paymentId).update({
      'status': PaymentStatus.expired.name,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> attachProviderInvoice(
    String paymentId, {
    required String providerInvoiceId,
    required String providerInvoiceUrl,
    String? rawStatus,
  }) {
    return _paymentsRef.doc(paymentId).update({
      'providerInvoiceId': providerInvoiceId,
      'providerInvoiceUrl': providerInvoiceUrl,
      'rawProviderStatus': rawStatus,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> updateWebhookReceived(String paymentId, Map<String, dynamic> rawPayload) {
    return _paymentsRef.doc(paymentId).update({
      'webhookLastReceivedAt': FieldValue.serverTimestamp(),
      'metadata.lastWebhookPayload': rawPayload,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
