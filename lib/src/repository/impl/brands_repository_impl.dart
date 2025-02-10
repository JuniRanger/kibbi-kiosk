import 'package:kiosk/src/core/di/dependency_manager.dart';
import 'package:kiosk/src/core/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:kiosk/src/core/handlers/handlers.dart';
import 'package:kiosk/src/models/models.dart';
import '../repository.dart';

class BrandsRepositoryImpl extends BrandsRepository {
  @override
  Future<ApiResult<BrandsPaginateResponse>> searchBrands(String? query) async {
    final data = {'search': query};
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/rest/brands/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: BrandsPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> search brands failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }
}
