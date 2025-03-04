import 'package:kiosk/src/core/di/dependency_manager.dart';
import 'package:flutter/material.dart';

import 'package:kiosk/src/core/handlers/handlers.dart';
import '../../core/utils/utils.dart';
import 'package:kiosk/src/models/models.dart';
import '../repository.dart';

class CategoriesRepositoryImpl extends CategoriesRepository {
  @override
  Future<ApiResult<CategoriesPaginateResponse>> searchCategories(
    String? query
  ) async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/categories/mineCategory',
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
