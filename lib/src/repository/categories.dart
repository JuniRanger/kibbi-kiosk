import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class CategoriesRepository {
  Future<ApiResult<List<CategoryData>>> searchCategories(
    String? query
  );
}
