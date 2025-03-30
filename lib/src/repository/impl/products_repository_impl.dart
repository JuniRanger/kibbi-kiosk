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
      final products =
          responseData.map((product) => ProductData.fromJson(product)).toList();

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
        '/api/products/mineProducts/category/$categoryId',
      );

      debugPrint('Response data: ${response.data}');
      final List<dynamic> responseData = response.data;
      final products =
          responseData.map((product) => ProductData.fromJson(product)).toList();

      debugPrint('==> get products by category success: $products');
      return ApiResult.success(data: products);
    } catch (e) {
      debugPrint('==> get products by category failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<num>> productsCalculateTotal(
      {required List<BagProductData> bagProducts}) async {
    debugPrint('==> productsCalculateTotal CALLED');
    final List<Map<String, dynamic>> data = bagProducts
        .map((product) => {
              "productId": product.productId,
              "quantity": product.quantity,
            })
        .toList();

    debugPrint('==> Calculating total sale with data: $data');

    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/orders/calculateTotalSale',
        data: data, // Mandamos el array directamente
      );

      debugPrint('==> Response status code: ${response.statusCode}');
      debugPrint('==> Response data: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        // Usar directamente como num, sin necesidad de conversión
        final totalSale = response.data['totalSale'] as num;
        debugPrint('==> Total sale calculated successfully: $totalSale');
        return ApiResult.success(data: totalSale);
      } else {
        debugPrint('==> Error: Unexpected response format or status code');
        throw Exception("Error al calcular el total del carrito");
      }
    } catch (e, s) {
      debugPrint('==> get cart total failure: $e, $s');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> fetchCouponAndDiscount({
    required String coupon,
    required num totalSale,
  }) async {
    final data = {
      'subtotal': totalSale,
    };

    debugPrint('==> Sending data for discount calculation: $data');

    try {
      final client = dioHttp.client(requireAuth: true);

      // Ejecutar ambas llamadas en paralelo
      final results = await Future.wait([
        client.get(
            '/api/coupons/myCoupon/code/$coupon'), // Obtener info del cupón
        client.post('/api/coupons/myCoupon/discount/$coupon',
            data: data), // Obtener descuento
      ]);

      final couponResponse = results[0]; // Respuesta del GET
      final discountResponse = results[1]; // Respuesta del POST

      debugPrint('==> Coupon response: ${couponResponse.data}');
      debugPrint('==> Discount response: ${discountResponse.data}');

      if (couponResponse.statusCode == 200 &&
          discountResponse.statusCode == 200 &&
          discountResponse.data != null) {
        final couponInfo = couponResponse.data; // Información del cupón
        final discount = discountResponse.data['discount'] as num; // Descuento

        return ApiResult.success(data: {
          'couponInfo': couponInfo,
          'discount': discount,
        });
      } else {
        throw Exception("Error al obtener los datos del cupón y el descuento");
      }
    } catch (e, s) {
      debugPrint('==> Fetch coupon and discount failure: $e, $s');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }
}
