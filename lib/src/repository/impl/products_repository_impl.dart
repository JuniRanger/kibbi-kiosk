import 'package:kibbi_kiosk/src/core/constants/constants.dart';
import 'package:kibbi_kiosk/src/core/di/dependency_manager.dart';
// import 'package:kibbi_kiosk/src/models/response/product_calculate_response.dart';
import 'package:flutter/material.dart';

import 'package:kibbi_kiosk/src/core/handlers/handlers.dart';
import '../../core/utils/utils.dart';
import 'package:kibbi_kiosk/src/models/models.dart';
import '../repository.dart';

class ProductsRepository extends ProductsFacade {
  @override
  Future<ApiResult<ProductsPaginateResponse>> getProductsPaginate({
    String? query,
    String? categoryId,
    required int page,
  }) async {
    final data = {
      if (categoryId != null) 'category_id': categoryId,
      if (query != null) 'search': query,
      'perPage': 12,
      'page': page,
      'lang': 'es',
      "status": "published",
      "addon_status": "published"
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/products/mineProducts',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ProductsPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get products failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  // @override
  // Future<ApiResult<ProductCalculateResponse>> getAllCalculations(
  //   List<BagProductData> bagProducts,
  //   String type,
  //   String? shopId, {
  //   String? coupon,
  // }) async {
  //   final data = {
  //     'currency_id': LocalStorage.getSelectedCurrency().id,
  //     'lang': LocalStorage.getLanguage()?.locale,
  //     'shop_id': shopId,
  //     'type': type.isEmpty ? TrKeys.kiosk : type,
  //     if (coupon != null) "coupon": coupon,
  //   };
  //   for (int i = 0; i < (bagProducts.length); i++) {
  //     data['products[$i][stock_id]'] = bagProducts[i].stockId;
  //     data['products[$i][quantity]'] = bagProducts[i].quantity;
  //     for (int j = 0; j < (bagProducts[i].carts?.length ?? 0); j++) {
  //       data['products[$i][addons][$j][stock_id]'] =
  //           bagProducts[i].carts?[j].stockId;
  //       data['products[$i][addons][$j][quantity]'] =
  //           bagProducts[i].carts?[j].quantity;
  //     }
  //   }

  //   try {
  //     final client = dioHttp.client(requireAuth: true);
  //     final response = await client.get(
  //       '/api/v1/rest/order/products/calculate',
  //       queryParameters: data,
  //     );
  //     return ApiResult.success(
  //       data: ProductCalculateResponse.fromJson(response.data),
  //     );
  //   } catch (e, s) {
  //     debugPrint('==> get all calculations failure: $e, $s');
  //     return ApiResult.failure(error: AppHelpers.errorHandler(e));
  //   }
  // }
}
