import 'dart:convert';

import 'package:kiosk/src/core/di/dependency_manager.dart';
import 'package:kiosk/src/core/utils/utils.dart';
import 'package:kiosk/src/repository/orders.dart';
import 'package:flutter/material.dart';
import 'package:kiosk/src/core/handlers/handlers.dart';
import 'package:kiosk/src/models/models.dart';

class OrdersRepositoryImpl extends OrdersRepository {
  @override
  Future<ApiResult<String>> process({int? orderId, String? name}) async {
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
  Future<ApiResult<CreateOrderResponse>> createOrder(
      OrderBodyData orderBody) async {
    try {
      final client = dioHttp.client(requireAuth: false);
      final data = orderBody.toJson();
      debugPrint('==> order create request: ${jsonEncode(data)}');
      final response = await client.post(
        '/api/v1/rest/orders',
        data: data,
      );

      return ApiResult.success(
        data: CreateOrderResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> order create failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }
}
