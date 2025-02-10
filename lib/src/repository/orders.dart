import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class OrdersRepository {
  Future<ApiResult<String>> process({int? orderId, String? name});

  Future<ApiResult<CreateOrderResponse>> createOrder(OrderBodyData orderBody);
}
