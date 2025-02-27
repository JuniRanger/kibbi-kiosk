import 'package:kiosk/src/models/response/shop_section_response.dart';
import 'package:kiosk/src/models/response/table_response.dart';

import '../core/handlers/handlers.dart';

abstract class TableRepository {
  Future<ApiResult<ShopSectionResponse>> getSection({
    int? page,
    String? shopId,
    String? query,
  });

  Future<ApiResult<TableResponse>> getTables({
    int? page,
    String? shopId,
    String? query,
    String? shopSectionId,
    String? type,
    DateTime? from,
    DateTime? to,
  });
}
