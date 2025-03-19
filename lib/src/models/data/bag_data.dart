// import 'package:flutter/material.dart';
// import 'package:kibbi_kiosk/src/models/models.dart';

// import '../response/payments_response.dart';

class BagData {
  BagData({
    List<BagProductData>? bagProducts,
    this.cartTotal = 0.0,
    // String? paymentMethod,
  }) {
    _bagProducts = bagProducts;
    // _paymentMethod = _validatePaymentMethod(paymentMethod);
  }

  BagData.fromJson(dynamic json)
      : cartTotal = (json['cart_total'] as num?) ?? 0.0 {
    // _paymentMethod = _validatePaymentMethod(json['payment_method'] as String?);

    if (json['bag_products'] != null) {
      _bagProducts = [];
      json['bag_products'].forEach((v) {
        _bagProducts?.add(BagProductData.fromJson(v));
      });
    }
  }

  List<BagProductData>? _bagProducts;
  num cartTotal;
  // String? _paymentMethod;

  // Getter para paymentMethod con validación
  // String get paymentMethod => _paymentMethod ?? "Efectivo"; // Default: "Efectivo"

  // Setter para asegurarse de que solo se asignen valores válidos
  // set paymentMethod(String? method) {
  //   _paymentMethod = _validatePaymentMethod(method);
  // }

  // Método privado para validar el método de pago
  // String _validatePaymentMethod(String? method) {
  //   return (method == "Tarjeta" || method == "Efectivo") ? method! : "Efectivo";
  // }

  BagData copyWith({
    List<BagProductData>? bagProducts,
    num? cartTotal,
    // String? paymentMethod,
  }) {
    return BagData(
      bagProducts: bagProducts ?? _bagProducts,
      cartTotal: cartTotal ?? this.cartTotal,
      // paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  List<BagProductData>? get bagProducts => _bagProducts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_bagProducts != null) {
      map['bag_products'] = _bagProducts?.map((v) => v.toJsonInsert()).toList();
    }
    // map['payment_method'] = paymentMethod;
    return map;
  }

  @override
  String toString() {
    return '_bagProducts: $_bagProducts, cartTotal: $cartTotal'; // , paymentMethod: $paymentMethod';
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
    if (productId != null) {
      map["product_id"] = productId; // Guarda el productId.
    }
    return map;
  }
}
