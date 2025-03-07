import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class ProductsFacade {
  Future<ApiResult<List<ProductData>>> getProductsPaginate({
    String? query
  });

  Future<ApiResult<List<ProductData>>> getProductsByCategoryId({
    required String categoryId,
  });
}
