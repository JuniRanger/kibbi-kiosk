import 'kiosk_data.dart';

class BagData {
  BagData({
    int? index,
    String? shopId,
    KioskData? selectedUser,
    // PaymentData? selectedPayment,
    List<BagProductData>? bagProducts,
  }) {
    _index = index;
    _shopId = shopId;
    _selectedUser = selectedUser;
    // _selectedPayment = selectedPayment;
    _bagProducts = bagProducts;
  }

  BagData.fromJson(dynamic json) {
    _index = json['index'];
    _shopId = json['shop_id'];
    _selectedUser = json['selected_user'] != null
        ? KioskData.fromJson(json['selected_user'])
        : null;
    // _selectedPayment = json['selected_payment'] != null
    //     ? PaymentData.fromJson(json['selected_payment'])
    //     : null;
    if (json['bag_products'] != null) {
      _bagProducts = [];
      json['bag_products'].forEach((v) {
        _bagProducts?.add(BagProductData.fromJson(v));
      });
    }
  }

  int? _index;
  String? _shopId;
  KioskData? _selectedUser;
  // PaymentData? _selectedPayment;
  List<BagProductData>? _bagProducts;

  BagData copyWith({
    int? index,
    String? shopId,
    KioskData? selectedUser,
    // PaymentData? selectedPayment,
    List<BagProductData>? bagProducts,
  }) =>
      BagData(
        index: index ?? _index,
        shopId: shopId ?? _shopId,
        selectedUser: selectedUser,
        // selectedPayment: selectedPayment ?? _selectedPayment,
        bagProducts: bagProducts ?? _bagProducts,
      );

  int? get index => _index;

  String? get shopId => _shopId;

  KioskData? get selectedUser => _selectedUser;

  // PaymentData? get selectedPayment => _selectedPayment;

  List<BagProductData>? get bagProducts => _bagProducts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['index'] = _index;
    map['shop_id'] = _shopId;
    if (_selectedUser != null) {
      map['selected_user'] = _selectedUser?.toJson();
    }
    // if (_selectedPayment != null) {
    //   map['selected_payment'] = _selectedPayment?.toJson();
    // }
    if (_bagProducts != null) {
      map['bag_products'] = _bagProducts?.map((v) => v.toJsonInsert()).toList();
    }
    return map;
  }
}

class BagProductData {
  final int? stockId;
  final int? quantity;
  final List<BagProductData>? carts;

  BagProductData({
    this.stockId,
    this.quantity,
    this.carts,
  });

  factory BagProductData.fromJson(Map data) {
    List<BagProductData> newList = [];
    data["products"]?.forEach((e) {
      newList.add(BagProductData.fromJson(e));
    });
    return BagProductData(
        stockId: data["stock_id"], quantity: data["quantity"], carts: newList);
  }

  BagProductData copyWith({int? quantity}) {
    return BagProductData(
        stockId: stockId, quantity: quantity ?? this.quantity, carts: carts);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (stockId != null) map["stock_id"] = stockId;
    if (quantity != null) map["quantity"] = quantity;
    return map;
  }

  Map<String, dynamic> toJsonInsert() {
    final map = <String, dynamic>{};
    if (stockId != null) map["stock_id"] = stockId;
    if (quantity != null) map["quantity"] = quantity;
    if (carts != null) map["products"] = toJsonCart();
    return map;
  }

  List<Map<String, dynamic>> toJsonCart() {
    List<Map<String, dynamic>> list = [];
    carts?.forEach((element) {
      final map = <String, dynamic>{};
      map["stock_id"] = element.stockId;
      map["quantity"] = element.quantity;
      list.add(map);
    });

    return list;
  }
}
