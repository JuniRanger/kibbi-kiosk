import 'package:kiosk/src/core/di/dependency_manager.dart';
import 'package:flutter/material.dart';
import 'package:kiosk/src/models/response/profile_response.dart';

import '../../core/constants/tr_keys.dart';
import 'package:kiosk/src/core/handlers/handlers.dart';
import '../../core/utils/utils.dart';
import '../../models/response/delivery_zone_paginate.dart';
import '../repository.dart';

class UsersRepositoryImpl extends UsersRepository {
  @override
  Future<ApiResult<DeliveryZonePaginate>> getDeliveryZone(int? shopId) async {
    final data = {
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/rest/shop/delivery-zone/$shopId',
        queryParameters: data,
      );
      return ApiResult.success(
        data: DeliveryZonePaginate.fromJson(response.data),
      );
    } catch (e, s) {
      debugPrint('===> error get delivery zone $e');
      debugPrint('===> error get delivery zone $s');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult> checkCoupon({
    required String coupon,
    required int shopId,
  }) async {
    final data = {
      'coupon': coupon,
      'shop_id': shopId,
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.post(
        '/api/v1/rest/coupons/check',
        data: data,
      );
      return const ApiResult.success(data: true);
    } catch (e) {
      debugPrint('==> check coupon failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult> updateStatus({
    required int? id,
    required String status,
  }) async {
    List list = [
      TrKeys.newKey,
      TrKeys.viewed,
      TrKeys.accepted,
      TrKeys.rejected
    ];
    final data = {'status': list.indexOf(status) + 1};
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/Kiosk/shops/invites/$id/status/change',
        data: data,
      );
      return ApiResult.success(data: response.data);
    } catch (e) {
      debugPrint('==> update master status failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<ProfileResponse>> getProfileDetails() async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/user/profile/show',
      );
      LocalStorage.setUser(ProfileResponse.fromJson(response.data).data);
      return ApiResult.success(
        data: ProfileResponse.fromJson(response.data),
      );
    } catch (e) {
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }
}
