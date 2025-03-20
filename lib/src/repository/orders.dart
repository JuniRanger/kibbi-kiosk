import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class OrdersRepository {

  // Aquí cambiamos el tipo de la respuesta a Map<String, dynamic>
  Future<ApiResult<OrderResponse>> createOrder(OrderBodyData orderBody);
}
