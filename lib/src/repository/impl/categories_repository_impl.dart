import 'package:kiosk/src/core/di/dependency_manager.dart';
import 'package:flutter/material.dart';

import 'package:kiosk/src/core/handlers/handlers.dart';
import '../../core/utils/utils.dart';
import 'package:kiosk/src/models/models.dart';
import '../repository.dart';

class CategoriesRepositoryImpl extends CategoriesRepository {
  @override
  Future<ApiResult<CategoriesPaginateResponse>> searchCategories(
    String? query,
    String? shopId,
  ) async {
    final data = {
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
      'perPage': 100,
      'type': 'main',
      "has_products": 1,
      "p_shop_id": shopId
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/rest/categories/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: CategoriesPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get categories failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }
}
