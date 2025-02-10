import 'package:kiosk/src/models/response/product_calculate_response.dart';

import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class ProductsFacade {
  Future<ApiResult<ProductsPaginateResponse>> getProductsPaginate({
    String? query,
    int? categoryId,
    int? brandId,
    int? shopId,
    required int page,
  });

  Future<ApiResult<ProductCalculateResponse>> getAllCalculations(
      List<BagProductData> bagProducts, String type, int? shopId,
      {String? coupon});
}
