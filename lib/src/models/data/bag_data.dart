// import 'package:kibbi_kiosk/src/models/models.dart';

// import '../response/payments_response.dart';

class BagData {
  BagData({
    // PaymentData? selectedPayment,
    List<BagProductData>? bagProducts,
  }) {
    _bagProducts = bagProducts;
  }

  BagData.fromJson(dynamic json) {
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

  // PaymentData? _selectedPayment;
  List<BagProductData>? _bagProducts;

  BagData copyWith({
    List<BagProductData>? bagProducts,
    // PaymentData? selectedPayment,
  }) {
    return BagData(
      bagProducts: bagProducts ?? _bagProducts,
      // selectedPayment: selectedPayment ?? _selectedPayment,
    );
  }

  // PaymentData? get selectedPayment => _selectedPayment;

  List<BagProductData>? get bagProducts => _bagProducts;

  get selectedPayment => null;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    // if (_selectedPayment != null) {
    //   map['selected_payment'] = _selectedPayment?.toJson();
    // }
    if (_bagProducts != null) {
      map['bag_products'] = _bagProducts?.map((v) => v.toJsonInsert()).toList();
    }
    return map;
  }

  // Sobrescribir toString para ver los valores de la bolsa
  @override
  String toString() {
    return '_bagProducts: $_bagProducts}';
  }
}

class BagProductData {
  final int? quantity;
  final String?
      productId; // Solo el productId y la cantidad, sin carts ni addons.

  BagProductData({
    this.quantity,
    this.productId, // Asegúrate de tener productId en el constructor.
  });

  factory BagProductData.fromJson(Map data) {
    return BagProductData(
      quantity: data["quantity"],
      productId: data["product_id"], // Asegúrate de leer el productId del JSON.
    );
  }

  BagProductData copyWith({
    int? quantity,
    String? productId,
  }) {
    return BagProductData(
      quantity: quantity ?? this.quantity,
      productId: productId ?? this.productId,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (quantity != null) map["quantity"] = quantity;
    if (productId != null) map["product_id"] = productId;
    return map;
  }

  Map<String, dynamic> toJsonInsert() {
    final map = <String, dynamic>{};
    if (quantity != null) map["quantity"] = quantity;
    if (productId != null)
      map["product_id"] = productId; // Guarda el productId.
    return map;
  }
}
