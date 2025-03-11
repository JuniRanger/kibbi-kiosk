// import 'package:kibbi_kiosk/src/core/utils/local_storage.dart';
import 'package:kibbi_kiosk/src/models/data/bag_data.dart';

import 'kiosk_data.dart';

class OrderBodyData {
  final String? note;
  final BagData bagData;

  OrderBodyData({
    this.note,
    required this.bagData,
  });

  Map toJson() {
    Map newMap = {};
    List<Map<String, dynamic>> products = [];
    for (BagProductData stock in bagData.bagProducts ?? []) {
      List<Map<String, dynamic>> addons = [];
      for (BagProductData addon in stock.carts ?? []) {
        addons.add({
          'quantity': addon.quantity,
        });
      }
      products.add({
        'quantity': stock.quantity,
        if (addons.isNotEmpty) 'addons': addons,
      });
    }
    if (note?.isNotEmpty ?? false) newMap["note"] = note;
    newMap['products'] = products;
    return newMap;
  }
}

// class ProductOrder {
//   final int stockId;
//   final num price;
//   final int quantity;
//   final num tax;
//   final num discount;
//   final num totalPrice;

//   ProductOrder({
//     required this.stockId,
//     required this.price,
//     required this.quantity,
//     required this.tax,
//     required this.discount,
//     required this.totalPrice,
//   });

//   @override
//   String toString() {
//     return "{\"stock_id\":$stockId, \"price\":$price, \"qty\":$quantity, \"tax\":$tax, \"discount\":$discount, \"total_price\":$totalPrice}";
//   }
// }
