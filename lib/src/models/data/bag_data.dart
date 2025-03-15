import 'package:flutter/material.dart';
import 'package:kibbi_kiosk/src/models/models.dart';

// import '../response/payments_response.dart';

class BagData {
  BagData({
    // PaymentData? selectedPayment,
    List<BagProductData>? bagProducts,
    this.cartTotal =
        0.0, // Inicializamos cartTotal con un valor predeterminado.
  }) {
    _bagProducts = bagProducts;
  }

  BagData.fromJson(dynamic json)
      : cartTotal = (json['cart_total'] as num?)?.toDouble() ?? 0.0 {
    // ✅ Leer cart_total si existe
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
  double cartTotal; // Nuevo campo para el total del carrito.

  BagData copyWith({
    List<BagProductData>? bagProducts,
    // PaymentData? selectedPayment,
    double? cartTotal,
  }) {
    return BagData(
      bagProducts: bagProducts ?? _bagProducts,
      // selectedPayment: selectedPayment ?? _selectedPayment,
      cartTotal: cartTotal ?? this.cartTotal,
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
    // map['cart_total'] = cartTotal; // Excluir cartTotal de las llamadas API.
    return map;
  }

  // Sobrescribir toString para ver los valores de la bolsa
  @override
  String toString() {
    return '_bagProducts: $_bagProducts, cartTotal: $cartTotal}';
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

  // Método para obtener el nombre del producto según el productId
  String getProductName(List<ProductData> products) {
    final product = products.firstWhere(
      (product) => product.id == productId,
      orElse: () => ProductData(id: productId, name: 'Producto no encontrado'),
    );
    return product.name ?? 'Producto no encontrado';
  }

  // Método para obtener el salePrice del producto según el productId
  num getProductSalePrice(List<ProductData> products) {
    final product = products.firstWhere(
      (product) => product.id.toString() == productId, // Convertir _id a cadena
      orElse: () {
        debugPrint('Producto no encontrado para productId: $productId');
        return ProductData(id: productId, salePrice: 0.0);
      },
    );
    debugPrint(
        'Precio encontrado para productId: $productId -> ${product.salePrice}');
    return product.salePrice ?? 0.0;
  }
}
