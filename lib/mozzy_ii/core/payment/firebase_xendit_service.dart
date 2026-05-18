import 'package:cloud_functions/cloud_functions.dart';
import 'models/payment_request.dart';
import 'models/payment_result.dart';
import 'xendit_service.dart';

class FirebaseXenditService implements XenditService {
  final FirebaseFunctions _functions;

  FirebaseXenditService({
    FirebaseFunctions? functions,
  }) : _functions = functions ?? FirebaseFunctions.instanceFor(region: 'asia-southeast2');

  @override
  Future<PaymentResult> createInvoice(PaymentRequest request) async {
    final callable = _functions.httpsCallable('createXenditInvoice');
    final response = await callable.call(request.toJson());
    return PaymentResult.fromJson(Map<String, dynamic>.from(response.data));
  }

  @override
  Future<PaymentResult> createQris(PaymentRequest request) async {
    final callable = _functions.httpsCallable('createXenditQris');
    final response = await callable.call(request.toJson());
    return PaymentResult.fromJson(Map<String, dynamic>.from(response.data));
  }

  @override
  Future<PaymentResult> getPaymentStatus(String paymentId) async {
    final callable = _functions.httpsCallable('getXenditPaymentStatus');
    final response = await callable.call({'paymentId': paymentId});
    return PaymentResult.fromJson(Map<String, dynamic>.from(response.data));
  }
}
