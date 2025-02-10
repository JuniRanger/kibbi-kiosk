import 'package:kiosk/src/core/utils/local_storage.dart';
import 'package:kiosk/src/models/data/bag_data.dart';

import 'user_data.dart';

class OrderBodyData {
  final String? note;
  final int? currencyId;
  final int? tableId;
  final num? rate;
  final String deliveryType;
  final UserData? user;
  final String? coupon;
  final BagData bagData;

  OrderBodyData({
    required this.currencyId,
    required this.rate,
    required this.deliveryType,
    required this.user,
    required this.tableId,
    this.coupon,
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
          'stock_id': addon.stockId,
          'quantity': addon.quantity,
        });
      }
      products.add({
        'stock_id': stock.stockId,
        'quantity': stock.quantity,
        if (addons.isNotEmpty) 'addons': addons,
      });
    }
    newMap["currency_id"] = currencyId;
    newMap["rate"] = rate;
    if (tableId != null) newMap["table_id"] = tableId;
    if (user?.phone?.isNotEmpty ?? false) newMap['phone'] = user?.phone;
    newMap["shop_id"] = bagData.shopId;
    if (user?.name?.isNotEmpty ?? false) newMap["username"] = user?.name;
    newMap["delivery_type"] = deliveryType.toLowerCase();
    if (coupon?.isNotEmpty ?? false) newMap["coupon"] = coupon;
    if (note?.isNotEmpty ?? false) newMap["note"] = note;
    newMap['products'] = products;
    newMap['lang'] = LocalStorage.getLanguage()?.locale;
    return newMap;
  }
}

class AddressModel {
  final String? address;
  final String? office;
  final String? house;
  final String? floor;

  AddressModel({
    this.address,
    this.office,
    this.house,
    this.floor,
  });

  Map toJson() {
    return {
      "address": address,
      "office": office,
      "house": house,
      "floor": floor
    };
  }

  factory AddressModel.fromJson(Map? data) {
    return AddressModel(
      address: data?["address"],
      office: data?["office"],
      house: data?["house"],
      floor: data?["floor"],
    );
  }
}

class ProductOrder {
  final int stockId;
  final num price;
  final int quantity;
  final num tax;
  final num discount;
  final num totalPrice;

  ProductOrder({
    required this.stockId,
    required this.price,
    required this.quantity,
    required this.tax,
    required this.discount,
    required this.totalPrice,
  });

  @override
  String toString() {
    return "{\"stock_id\":$stockId, \"price\":$price, \"qty\":$quantity, \"tax\":$tax, \"discount\":$discount, \"total_price\":$totalPrice}";
  }
}
