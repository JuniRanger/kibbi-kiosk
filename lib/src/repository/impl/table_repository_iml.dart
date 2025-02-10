
import 'package:flutter/material.dart';
import 'package:kiosk/src/core/di/dependency_manager.dart';
import 'package:kiosk/src/core/utils/time_service.dart';
import 'package:kiosk/src/models/response/shop_section_response.dart';
import 'package:kiosk/src/models/response/table_response.dart';
import 'package:kiosk/src/repository/table.dart';

import 'package:kiosk/src/core/handlers/handlers.dart';
import '../../core/utils/utils.dart';

class TableRepositoryIml extends TableRepository {
  @override
  Future<ApiResult<ShopSectionResponse>> getSection({
    int? page,
    int? shopId,
    String? query,
  }) async {
    final data = {
      if (page != null) 'page': page,
      'perPage': 50,
      if (query != null) 'search': query,
      if (shopId != null) 'shop_id': shopId,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/rest/booking/shop-sections',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ShopSectionResponse.fromJson(response.data),
        // data: TableResponse.fromJson(mapData),
      );
    } catch (e) {
      debugPrint('==> get getSection failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }



  @override
  Future<ApiResult<TableResponse>> getTables({
    int? page,
    int? shopId,
    int? shopSectionId,
    String? type,
    String? query,
    DateTime? from,
    DateTime? to,
  }) async {
    from ??= from ?? DateTime.now();
    to ??= to ?? DateTime.now();
    to = to.add(const Duration(days: 1));
    final data = {
      if (page != null) 'page': page,
      'perPage': 10,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
      if (type != null) 'status': type,
      if (shopId != null) 'shop_id': shopId,
      if (shopSectionId != null) "shop_section_id": shopSectionId,
      if (type != null) "date_from": TimeService.dateFormatYMD(from),
      if (type != null) "date_to": TimeService.dateFormatYMD(to),
      if (query != null) "search":query,
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/rest/booking/tables',
        queryParameters: data,
      );
      return ApiResult.success(
        data: TableResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get getTableInfo failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }



}
