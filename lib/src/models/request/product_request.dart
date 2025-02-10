import 'package:kiosk/src/core/utils/utils.dart';

class ProductRequest {
  final int? shopId;
  final int page;
  final int? categoryId;
  final List<int>? brands;

  ProductRequest({
    required this.shopId,
    required this.page,
    this.categoryId,
    this.brands,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["shop_id"] = shopId;
    map["lang"] = LocalStorage.getLanguage()?.locale ?? "en";
    map["currency_id"] = LocalStorage.getSelectedCurrency().id;

    map["page"] = page;
    map["status"] = "published";
    map["perPage"] = 20;
    map["column"] = "category_id";
    map["sort"] = "asc";
    if (brands?.isNotEmpty ?? false) {
      map['brand_ids'] = brands?.map((v) => v).toList();
    }

    return map;
  }

  Map<String, dynamic> toJsonPopular() {
    final map = <String, dynamic>{};
    map["lang"] = LocalStorage.getLanguage()?.locale ?? "en";
    map["currency_id"] = LocalStorage.getSelectedCurrency().id;

    map["page"] = page;
    map["status"] = "published";
    map["perPage"] = 20;
    map["column"] = "category_id";
    map["sort"] = "asc";
    if (brands?.isNotEmpty ?? false) {
      map['brand_ids'] = brands?.map((v) => v).toList();
    }
    return map;
  }

  Map<String, dynamic> toJsonByCategory() {
    final map = <String, dynamic>{};
    map["shop_id"] = shopId;
    map["column"] = "category_id";
    map["sort"] = "asc";
    map["lang"] = LocalStorage.getLanguage()?.locale ?? "en";
    map["currency_id"] = LocalStorage.getSelectedCurrency().id;

    map["page"] = page;
    map["status"] = "published";
    map["category_id"] = categoryId;
    map["perPage"] = 20;
    if (brands?.isNotEmpty ?? false) {
      map['brand_ids'] = brands?.map((v) => v).toList();
    }
    return map;
  }
}
