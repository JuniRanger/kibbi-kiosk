import 'dart:convert';

import 'package:kibbi_kiosk/src/core/di/dependency_manager.dart';
import 'package:kibbi_kiosk/src/core/utils/utils.dart';
import 'package:kibbi_kiosk/src/repository/orders.dart';
import 'package:flutter/material.dart';
import 'package:kibbi_kiosk/src/core/handlers/handlers.dart';
import 'package:kibbi_kiosk/src/models/models.dart';

class OrdersRepositoryImpl extends OrdersRepository {
@override
Future<ApiResult<OrderResponse>> createOrder(OrderBodyData orderBody) async {
  try {
    final client = dioHttp.client(requireAuth: true);
    final data = orderBody.toJson();
    debugPrint('==> order create request: ${jsonEncode(data)}');

    final response = await client.post(
      '/api/orders/myOrder',
      data: data,
    );

    // Imprime la respuesta cruda
    debugPrint('==> raw response: ${response.data}');

    // Parsea la respuesta utilizando el modelo OrderResponse
    final orderResponse = OrderResponse.fromJson(response.data);

    return ApiResult.success(data: orderResponse);
  } catch (e) {
    debugPrint('==> order create failure: $e');
    return ApiResult.failure(error: AppHelpers.errorHandler(e));
  }
}
}