import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class PaymentsRepository {
  Future<ApiResult<PaymentsResponse>> getPayments();

  Future<ApiResult<TransactionsResponse>> createTransaction({
    required String? orderId,
    required String? paymentId,
  });
}