import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class OrdersRepository {
  Future<ApiResult<String>> process({String? orderId, String? name});

  // Aquí cambiamos el tipo de la respuesta a Map<String, dynamic>
  Future<ApiResult<Map<String, dynamic>>> createOrder(OrderBodyData orderBody);
}
