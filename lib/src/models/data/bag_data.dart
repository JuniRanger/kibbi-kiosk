import 'address_data.dart';
import 'table_data.dart';
import 'kiosk_data.dart';
import 'currency_data.dart';

import '../response/payments_response.dart';

class BagData {
  BagData({
    int? index,
    String? shopId,
    KioskData? selectedUser,
    TableData? selectedTable,
    ShopSection? selectedSection,
    AddressData? selectedAddress,
    CurrencyData? selectedCurrency,
    PaymentData? selectedPayment,
    List<BagProductData>? bagProducts,
  }) {
    _index = index;
    _shopId = shopId;
    _selectedUser = selectedUser;
    _selectedAddress = selectedAddress;
    _selectedCurrency = selectedCurrency;
    _selectedPayment = selectedPayment;
    _bagProducts = bagProducts;
    _selectedTable = selectedTable;
    _selectedSection = selectedSection;
  }

  BagData.fromJson(dynamic json) {
    _index = json['index'];
    _shopId = json['shop_id'];
    _selectedUser = json['selected_user'] != null
        ? KioskData.fromJson(json['selected_user'])
        : null;
    _selectedTable = json['selected_table'] != null
        ? TableData.fromJson(json['selected_table'])
        : null;
    _selectedSection = json['selected_section'] != null
        ? ShopSection.fromJson(json['selected_section'])
        : null;
    _selectedAddress = json['selected_address'] != null
        ? AddressData.fromJson(json['selected_address'])
        : null;
    _selectedCurrency = json['selected_currency'] != null
        ? CurrencyData.fromJson(json['selected_currency'])
        : null;
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
  String? _shopId;
  KioskData? _selectedUser;
  TableData? _selectedTable;
  ShopSection? _selectedSection;
  AddressData? _selectedAddress;
  CurrencyData? _selectedCurrency;
  PaymentData? _selectedPayment;
  List<BagProductData>? _bagProducts;

  BagData copyWith({
    int? index,
    String? shopId,
    KioskData? selectedUser,
    ShopSection? selectedSection,
    TableData? selectedTable,
    AddressData? selectedAddress,
    CurrencyData? selectedCurrency,
    PaymentData? selectedPayment,
    List<BagProductData>? bagProducts,
  }) =>
      BagData(
        index: index ?? _index,
        shopId: shopId ?? _shopId,
        selectedUser: selectedUser,
        selectedSection: selectedSection,
        selectedTable: selectedTable,
        selectedAddress: selectedAddress,
        selectedCurrency: selectedCurrency ?? _selectedCurrency,
        selectedPayment: selectedPayment ?? _selectedPayment,
        bagProducts: bagProducts ?? _bagProducts,
      );

  int? get index => _index;

  String? get shopId => _shopId;

  KioskData? get selectedUser => _selectedUser;

  TableData? get selectedTable => _selectedTable;

  ShopSection? get selectedSection => _selectedSection;

  AddressData? get selectedAddress => _selectedAddress;

  CurrencyData? get selectedCurrency => _selectedCurrency;

  PaymentData? get selectedPayment => _selectedPayment;

  List<BagProductData>? get bagProducts => _bagProducts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['index'] = _index;
    map['shop_id'] = _shopId;
    if (_selectedUser != null) {
      map['selected_user'] = _selectedUser?.toJson();
    }
    if (_selectedTable != null) {
      map['selected_table'] = _selectedTable?.toJson();
    }
    if (_selectedSection != null) {
      map['selected_section'] = _selectedSection?.toJson();
    }
    if (_selectedAddress != null) {
      map['selected_address'] = _selectedAddress?.toJson();
    }
    if (_selectedCurrency != null) {
      map['selected_currency'] = _selectedCurrency?.toJson();
    }
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
