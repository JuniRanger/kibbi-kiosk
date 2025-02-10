import 'package:kiosk/src/models/response/single_shop_response.dart';

import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class ShopsRepository {
  Future<ApiResult<ShopsPaginateResponse>> searchShops(String? query);

  Future<ApiResult<SingleShopResponse>> getSingleShop({required String uuid});


  Future<ApiResult<CategoriesPaginateResponse>> getShopCategory();

  Future<ApiResult<CategoriesPaginateResponse>> getShopTag();

  Future<ApiResult<ShopsPaginateResponse>> getAllShops({
    required int page,
    int? categoryId,
    String? query,
    bool? isOpen,
    bool? verify,
  });
}
