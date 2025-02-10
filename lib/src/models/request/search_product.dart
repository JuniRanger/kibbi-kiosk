

import 'package:kiosk/src/core/utils/utils.dart';

class SearchProductModel {
  final String text;
  final int page;
  final int? shopId;
  SearchProductModel({
    required this.text,
    required this.page,
    required this.shopId,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["search"] = text;
    map["perPage"] = 10;
    map["status"] = "published";
    map["page"] = page;
    if(shopId != null) {
      map["shop_id"] = shopId;
    }
    map["lang"] = LocalStorage.getLanguage()?.locale ?? "en";
    return map;
  }
}
