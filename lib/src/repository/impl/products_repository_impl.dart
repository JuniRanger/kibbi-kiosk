// import 'package:kibbi_kiosk/src/core/constants/constants.dart';
import 'package:kibbi_kiosk/src/core/di/dependency_manager.dart';
// import 'package:kibbi_kiosk/src/models/response/product_calculate_response.dart';
import 'package:flutter/material.dart';

import 'package:kibbi_kiosk/src/core/handlers/handlers.dart';
import '../../core/utils/utils.dart';
import 'package:kibbi_kiosk/src/models/models.dart';
import '../repository.dart';

class ProductsRepository extends ProductsFacade {
  @override
  Future<ApiResult<List<ProductData>>> getProductsPaginate({
    String? query,
  }) async {
    final data = {
      if (query != null) 'search': query,
    };

    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/products/mineProducts',
        queryParameters: data,
      );

      // Verifica la estructura de response.data
      debugPrint('Response data: ${response.data}');

      // Convierte la lista de productos
      final List<dynamic> responseData = response.data;
      final products = responseData.map((product) => ProductData.fromJson(product)).toList();

      debugPrint('==> get products success: $products');
      return ApiResult.success(data: products);
    } catch (e) {
      debugPrint('==> get products failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<List<ProductData>>> getProductsByCategoryId({
    required String categoryId,
  }) async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/products/$categoryId',
      );

      debugPrint('Response data: ${response.data}');
      final List<dynamic> responseData = response.data;
      final products = responseData.map((product) => ProductData.fromJson(product)).toList();

      debugPrint('==> get products by category success: $products');
      return ApiResult.success(data: products);
    } catch (e) {
      debugPrint('==> get products by category failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
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
  // }}
