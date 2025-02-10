import 'package:kiosk/src/core/di/dependency_manager.dart';
import 'package:kiosk/src/models/request/only_shop.dart';
import 'package:kiosk/src/models/request/shop_request.dart';
import 'package:kiosk/src/models/response/single_shop_response.dart';
import 'package:flutter/material.dart';
import 'package:kiosk/src/core/handlers/handlers.dart';
import '../../core/utils/utils.dart';
import 'package:kiosk/src/models/models.dart';
import '../repository.dart';

class ShopsRepositoryImpl extends ShopsRepository {
  @override
  Future<ApiResult<ShopsPaginateResponse>> searchShops(String? query) async {
    final data = {
      if (query != null) 'search': query,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
      'status': 'approved',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard//shops/search',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ShopsPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> search shops failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<SingleShopResponse>> getSingleShop(
      {required String uuid}) async {
    final data = OnlyShopRequest();
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get('/api/v1/rest/shops/$uuid',
          queryParameters: data.toJson());
      return ApiResult.success(
        data: SingleShopResponse.fromJson(response.data),
      );
    } catch (e) {
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<CategoriesPaginateResponse>> getShopCategory() async {
    final data = <String, dynamic>{
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
      'type': 'shop'
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/categories',
        queryParameters: data,
      );
      return ApiResult.success(
        data: CategoriesPaginateResponse.fromJson(response.data),
      );
    } catch (e, s) {
      debugPrint('==> get shops category failure: $e');
      debugPrint('==> get shops category failure: $s');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<CategoriesPaginateResponse>> getShopTag() async {
    final data = <String, dynamic>{
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/shop-tags/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: CategoriesPaginateResponse.fromJson(response.data),
      );
    } catch (e, s) {
      debugPrint('==> get shops category failure: $e');
      debugPrint('==> get shops category failure: $s');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<ShopsPaginateResponse>> getAllShops({
    required int page,
    int? categoryId,
    String? query,
     bool? isOpen,
    bool? verify,
  }) async {
    final data = ShopRequest(
      page: page,
      categoryId: categoryId,
      onlyOpen: isOpen,
      verify: verify,
      query: query,
    );
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/shops/paginate',
        queryParameters: data.toJson(),
      );
      return ApiResult.success(
        data: ShopsPaginateResponse.fromJson(response.data),
      );
    } catch (e, s) {
      debugPrint('==> get all shops failure: $e,$s');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }
}
