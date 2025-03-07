import 'package:kibbi_kiosk/src/core/di/dependency_manager.dart';
import 'package:flutter/material.dart';
import 'package:kibbi_kiosk/src/core/handlers/handlers.dart';
import '../../core/utils/utils.dart';
import 'package:kibbi_kiosk/src/models/models.dart';
import '../repository.dart';

class CategoriesRepositoryImpl extends CategoriesRepository {
  @override
  Future<ApiResult<List<CategoryData>>> searchCategories(String? query) async {
    try {
      final client = dioHttp.client(requireAuth: true);

      debugPrint('==> Making API call to: /api/categories/mineCategory');
      if (query != null) {
        debugPrint('==> Query parameter: $query');
      }

      final response = await client.get(
        '/api/categories/mineCategory',
      );

      debugPrint('==> API response: ${response.data}');

      // Convertir la respuesta en una lista de CategoryData
      final List<dynamic> responseData = response.data;
      final categories = responseData
          .map((categoryJson) => CategoryData.fromJson(categoryJson))
          .toList();

      return ApiResult.success(data: categories);
    } catch (e) {
      debugPrint('==> get categories failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }
}