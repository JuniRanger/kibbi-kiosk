


import 'package:kiosk/src/core/utils/utils.dart';

class OnlyShopRequest {
  final String? lan;
  OnlyShopRequest({
    this.lan,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["lang"] = LocalStorage.getLanguage()?.locale ?? "en";
   map["currency_id"] = LocalStorage.getSelectedCurrency().id;
    return map;
  }
}