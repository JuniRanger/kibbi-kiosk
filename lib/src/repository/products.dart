
import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class ProductsFacade {
  Future<ApiResult<ProductsPaginateResponse>> getProductsPaginate({
    String? query,
    String? categoryId,
    required int page,
  });
}
