import 'dart:convert';

import 'package:kibbi_kiosk/src/core/di/dependency_manager.dart';
import 'package:kibbi_kiosk/src/core/utils/utils.dart';
import 'package:kibbi_kiosk/src/repository/orders.dart';
import 'package:flutter/material.dart';
import 'package:kibbi_kiosk/src/core/handlers/handlers.dart';
import 'package:kibbi_kiosk/src/models/models.dart';

class OrdersRepositoryImpl extends OrdersRepository {
  @override
  Future<ApiResult<String>> process({String? orderId, String? name}) async {
    try {
      final client = dioHttp.client(requireAuth: false);
      var res = await client.get(
        '/api/v1/rest/order-$name-process',
        data: {"order_id": orderId},
      );
      return ApiResult.success(data: res.data["data"]["data"]["url"]);
    } catch (e) {
      debugPrint('==>  order process failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> createOrder(
      OrderBodyData orderBody) async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final data = orderBody.toJson();
      debugPrint('==> order create request: ${jsonEncode(data)}');
      final response = await client.post(
        '/api/orders/myOrder',
        data: data,
      );

      // En lugar de usar un modelo, directamente devolvemos los datos que viene de la API
      return ApiResult.success(data: response.data);
    } catch (e) {
      debugPrint('==> order create failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }
}
