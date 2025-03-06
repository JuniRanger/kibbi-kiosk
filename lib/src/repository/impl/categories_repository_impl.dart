import 'package:kibbi_kiosk/src/core/di/dependency_manager.dart';
import 'package:flutter/material.dart';

import 'package:kibbi_kiosk/src/core/handlers/handlers.dart';
import '../../core/utils/utils.dart';
import 'package:kibbi_kiosk/src/models/models.dart';
import '../repository.dart';

class CategoriesRepositoryImpl extends CategoriesRepository {
  @override
  Future<ApiResult<CategoriesPaginateResponse>> searchCategories(
      String? query) async {
    try {
      final client = dioHttp.client(requireAuth: true);

      // Depurando antes de hacer la llamada
      debugPrint('==> Making API call to: /api/categories/mineCategory');
      if (query != null) {
        debugPrint('==> Query parameter: $query');
      }

      final response = await client.get(
        '/api/categories/mineCategory',
      );

      // Depurando la respuesta de la API
      debugPrint('==> API response: ${response.data}');

      return ApiResult.success(
        data: CategoriesPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      // Depurando cualquier error que ocurra durante la llamada
      debugPrint('==> get categories failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }
}
