import '../response/payments_response.dart';

class BagData {
  BagData({
    int? index,
    PaymentData? selectedPayment,
    List<BagProductData>? bagProducts,
  }) {
    _index = index;
    _bagProducts = bagProducts;
  }

  BagData.fromJson(dynamic json) {
    _index = json['index'];
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

  int? _index;
  PaymentData? _selectedPayment;
  List<BagProductData>? _bagProducts;

  BagData copyWith({
    int? index,
    PaymentData? selectedPayment,
    List<BagProductData>? bagProducts,
  }) =>
      BagData(
        index: index ?? _index,
        selectedPayment: selectedPayment ?? _selectedPayment,
        bagProducts: bagProducts ?? _bagProducts,
      );

  int? get index => _index;
  PaymentData? get selectedPayment => _selectedPayment;

  List<BagProductData>? get bagProducts => _bagProducts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['index'] = _index;
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
  final int? stockId;  // Agregado el campo stockId

  BagProductData({
    this.quantity,
    this.carts,
    this.stockId,  // Asegúrate de agregarlo al constructor
  });

  factory BagProductData.fromJson(Map data) {
    List<BagProductData> newList = [];
    data["products"]?.forEach((e) {
      newList.add(BagProductData.fromJson(e));
    });
    return BagProductData(
        quantity: data["quantity"],
        carts: newList,
        stockId: data["stockId"],  // Asegúrate de leer stockId del JSON
    );
  }

  BagProductData copyWith({int? quantity, int? stockId}) {
    return BagProductData(
        quantity: quantity ?? this.quantity,
        carts: carts,
        stockId: stockId ?? this.stockId,  // Permite copiar el stockId
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (quantity != null) map["quantity"] = quantity;
    if (stockId != null) map["stockId"] = stockId;  // Agrega stockId a la salida
    return map;
  }

  Map<String, dynamic> toJsonInsert() {
    final map = <String, dynamic>{};
    if (quantity != null) map["quantity"] = quantity;
    if (stockId != null) map["stockId"] = stockId;  // Agrega stockId a la salida
    if (carts != null) map["products"] = toJsonCart();
    return map;
  }

  List<Map<String, dynamic>> toJsonCart() {
    List<Map<String, dynamic>> list = [];
    carts?.forEach((element) {
      final map = <String, dynamic>{};
      map["quantity"] = element.quantity;
      if (element.stockId != null) map["stockId"] = element.stockId;  // Incluye stockId en los productos dentro del carrito
      list.add(map);
    });
    return list;
  }
}
