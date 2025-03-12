import '../response/payments_response.dart';

class BagData {
  BagData({
    // PaymentData? selectedPayment,
    List<BagProductData>? bagProducts,
  }) {
    _bagProducts = bagProducts;
  }

  BagData.fromJson(dynamic json) {
    _selectedPayment = json['selected_payment'] != null
        ? PaymentData.fromJson(json['selected_payment'])
        : null;
    if (json['bag_products'] != null) {
      _bagProducts = [];
      json['bag_products'].forEach((v) {
        _bagProducts?.add(BagProductData.fromJson(v));
      });
    }
  }

  PaymentData? _selectedPayment;
  List<BagProductData>? _bagProducts;

  BagData copyWith({
    int? index,
    PaymentData? selectedPayment,
    List<BagProductData>? bagProducts,
  }) =>
      BagData(
        // selectedPayment: selectedPayment ?? _selectedPayment,
        bagProducts: bagProducts ?? _bagProducts,
      );

  PaymentData? get selectedPayment => _selectedPayment;

  List<BagProductData>? get bagProducts => _bagProducts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_selectedPayment != null) {
      map['selected_payment'] = _selectedPayment?.toJson();
    }
    if (_bagProducts != null) {
      map['bag_products'] = _bagProducts?.map((v) => v.toJsonInsert()).toList();
    }
    return map;
  }
}

class BagProductData {
  final int? quantity;
  final List<BagProductData>? carts;
  final String? productId;  // Cambié stockId por productId

  BagProductData({
    this.quantity,
    this.carts,
    this.productId,  // Asegúrate de agregar el productId en el constructor
  });

  factory BagProductData.fromJson(Map data) {
    List<BagProductData> newList = [];
    data["products"]?.forEach((e) {
      newList.add(BagProductData.fromJson(e));
    });
    return BagProductData(
      quantity: data["quantity"],
      productId: data["product_id"], // Asegúrate de leer el productId del JSON
      carts: newList,
    );
  }

  BagProductData copyWith({
    int? quantity,
    List<BagProductData>? carts,
    String? productId,
  }) {
    return BagProductData(
      quantity: quantity ?? this.quantity,
      carts: carts ?? this.carts,
      productId: productId ?? this.productId,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (quantity != null) map["quantity"] = quantity;
    if (productId != null) map["product_id"] = productId; // Guarda el productId
    return map;
  }

  Map<String, dynamic> toJsonInsert() {
    final map = <String, dynamic>{};
    if (quantity != null) map["quantity"] = quantity;
    if (productId != null) map["product_id"] = productId; // Guarda el productId también
    if (carts != null) map["products"] = toJsonCart();
    return map;
  }

  List<Map<String, dynamic>> toJsonCart() {
    List<Map<String, dynamic>> list = [];
    carts?.forEach((element) {
      final map = <String, dynamic>{};
      map["quantity"] = element.quantity;
      if (element.productId != null) map["product_id"] = element.productId; // Asegúrate de agregar el productId
      list.add(map);
    });
    return list;
  }
}
