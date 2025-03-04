import 'package:kiosk/src/models/response/product_calculate_response.dart';

import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class ProductsFacade {
  Future<ApiResult<ProductsPaginateResponse>> getProductsPaginate({
    String? query,
    String? categoryId,
    required int page,
  });

  Future<ApiResult<ProductCalculateResponse>> getAllCalculations(
      List<BagProductData> bagProducts, String type, String? shopId,
      {String? coupon});
}
