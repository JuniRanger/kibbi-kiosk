import '../core/handlers/handlers.dart';
import '../models/response/delivery_zone_paginate.dart';
import '../models/response/profile_response.dart';

abstract class UsersRepository {

  Future<ApiResult<DeliveryZonePaginate>> getDeliveryZone(int? shopId);


  Future<ApiResult> checkCoupon({
    required String coupon,
    required int shopId,
  });

  Future<ApiResult> updateStatus({
    required int? id,
    required String status,
  });

  Future<ApiResult<ProfileResponse>> getProfileDetails();

}
