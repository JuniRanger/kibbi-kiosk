import 'package:kiosk/src/models/data/addons_data.dart';
import 'package:kiosk/src/models/models.dart';
import 'location_data.dart';
import 'table_data.dart';

class OrderData {
  String id;
  int? userId;
  num? totalPrice;
  num? originPrice;
  num? KioskFee;
  num? rate;
  num? tax;
  num? commissionFee;
  num? couponPrice;
  num? serviceFee;
  num? deliveryFee;
  num? totalDiscount;
  num? tips;
  String? status;
  String? phone;
  String? username;
  String? note;
  OrderAddress? orderAddress;
  LocationData? location;
  String? deliveryType;
  DateTime? deliveryDate;
  String? deliveryTime;
  DateTime? deliveryDateTime;
  bool? current;
  int? split;
  bool? paidBySplit;
  DateTime? createdAt;
  DateTime? updatedAt;
  KioskData? deliveryman;
  ShopData? shop;
  CurrencyData? currency;
  KioskData? user;
  List<OrderDetail>? details;
  Transaction? transaction;
  dynamic review;
  List<dynamic>? pointHistories;
  List<dynamic>? orderRefunds;
  dynamic coupon;
  List<Galleries>? galleries;
  dynamic myAddress;
  TableData? table;

  OrderData({
    required this.id,
    this.userId,
    this.totalPrice,
    this.originPrice,
    this.KioskFee,
    this.rate,
    this.tax,
    this.tips,
    this.phone,
    this.commissionFee,
    this.serviceFee,
    this.status,
    this.orderAddress,
    this.location,
    this.deliveryType,
    this.deliveryDate,
    this.deliveryTime,
    this.deliveryDateTime,
    this.current,
    this.split,
    this.paidBySplit,
    this.createdAt,
    this.updatedAt,
    this.deliveryman,
    this.shop,
    this.currency,
    this.user,
    this.details,
    this.transaction,
    this.review,
    this.pointHistories,
    this.orderRefunds,
    this.coupon,
    this.galleries,
    this.myAddress,
    this.deliveryFee,
    this.totalDiscount,
    this.couponPrice,
    this.table,
    this.username,
    this.note,
  });

  OrderData copyWith({
    int? id,
    int? userId,
    num? totalPrice,
    num? originPrice,
    num? KioskFee,
    num? tips,
    num? rate,
    num? tax,
    num? deliveryFee,
    num? couponPrice,
    num? totalDiscount,
    num? commissionFee,
    num? serviceFee,
    String? status,
    String? phone,
    String? note,
    String? username,
    OrderAddress? orderAddress,
    LocationData? location,
    String? deliveryType,
    DateTime? deliveryDate,
    String? deliveryTime,
    DateTime? deliveryDateTime,
    bool? current,
    int? split,
    bool? paidBySplit,
    DateTime? createdAt,
    DateTime? updatedAt,
    KioskData? deliveryman,
    ShopData? shop,
    CurrencyData? currency,
    KioskData? user,
    List<OrderDetail>? details,
    Transaction? transaction,
    dynamic review,
    List<dynamic>? pointHistories,
    List<dynamic>? orderRefunds,
    dynamic coupon,
    List<Galleries>? galleries,
    dynamic myAddress,
    TableData? table,
  }) =>
      OrderData(
        id: id.toString(),
        tips: tips ?? this.tips,
        userId: userId ?? this.userId,
        location: location ?? this.location,
        totalPrice: totalPrice ?? this.totalPrice,
        originPrice: originPrice ?? this.originPrice,
        KioskFee: KioskFee ?? this.KioskFee,
        deliveryFee: deliveryFee ?? this.deliveryFee,
        totalDiscount: totalDiscount ?? this.totalDiscount,
        rate: rate ?? this.rate,
        tax: tax ?? this.tax,
        note: note ?? this.note,
        phone: phone ?? this.phone,
        username: username ?? this.username,
        commissionFee: commissionFee ?? this.commissionFee,
        serviceFee: serviceFee ?? this.serviceFee,
        status: status ?? this.status,
        orderAddress: orderAddress ?? this.orderAddress,
        deliveryType: deliveryType ?? this.deliveryType,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        deliveryTime: deliveryTime ?? this.deliveryTime,
        deliveryDateTime: deliveryDateTime ?? this.deliveryDateTime,
        current: current ?? this.current,
        split: split ?? this.split,
        paidBySplit: paidBySplit ?? this.paidBySplit,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deliveryman: deliveryman ?? this.deliveryman,
        shop: shop ?? this.shop,
        currency: currency ?? this.currency,
        user: user ?? this.user,
        details: details ?? this.details,
        transaction: transaction ?? this.transaction,
        review: review ?? this.review,
        pointHistories: pointHistories ?? this.pointHistories,
        orderRefunds: orderRefunds ?? this.orderRefunds,
        coupon: coupon ?? this.coupon,
        galleries: galleries ?? this.galleries,
        myAddress: myAddress ?? this.myAddress,
        table: table ?? this.table,
        couponPrice: couponPrice ?? this.couponPrice,
      );

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        id: json["id"],
        userId: json["user_id"],
        note: json["note"],
        totalPrice: json["total_price"],
        originPrice: json["origin_price"],
        KioskFee: json["Kiosk_fee"],
        rate: json["rate"],
        tips: json["tips"],
        tax: json["tax"],
        phone: json["phone"],
        username: json["username"],
        commissionFee: json["commission_fee"],
        deliveryFee: json["delivery_fee"],
        totalDiscount: json["total_discount"],
        serviceFee: json["service_fee"],
        status: json["status"],
        orderAddress: json["address"] == null
            ? null
            : OrderAddress.fromJson(json["address"]),
        location: json["location"] == null
            ? null
            : LocationData.fromJson(json["location"]),
        deliveryType: json["delivery_type"],
        deliveryDate: json["delivery_date"] == null
            ? null
            : DateTime.parse(json["delivery_date"]),
        deliveryTime: json["delivery_time"],
        deliveryDateTime: json["delivery_date_time"] == null
            ? null
            : DateTime.parse(json["delivery_date_time"]),
        current: json["current"],
        split: json["split"],
        paidBySplit: json["paid_by_split"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deliveryman: json["deliveryman"] == null
            ? null
            : KioskData.fromJson(json["deliveryman"]),
        shop: json["shop"] == null ? null : ShopData.fromJson(json["shop"]),
        currency: json["currency"] == null
            ? null
            : CurrencyData.fromJson(json["currency"]),
        user: json["user"] == null ? null : KioskData.fromJson(json["user"]),
        details: json["details"] == null
            ? []
            : List<OrderDetail>.from(
                json["details"]!.map((x) => OrderDetail.fromJson(x))),
        transaction: json["transaction"] == null
            ? null
            : Transaction.fromJson(json["transaction"]),
        review: json["review"],
        pointHistories: json["point_histories"] == null
            ? []
            : List<dynamic>.from(json["point_histories"]!.map((x) => x)),
        orderRefunds: json["order_refunds"] == null
            ? []
            : List<dynamic>.from(json["order_refunds"]!.map((x) => x)),
        coupon: json["coupon"],
        galleries: json["galleries"] == null
            ? []
            : List<Galleries>.from(
                json["galleries"]!.map((x) => Galleries.fromJson(x))),
        myAddress: json["my_address"],
        couponPrice: json["coupon_price"],
        table: json["table"] == null ? null : TableData.fromJson(json["table"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "phone": phone,
        "tips": tips,
        "coupon_price": couponPrice,
        "note": note,
        "username": username,
        "total_price": totalPrice,
        "origin_price": originPrice,
        "Kiosk_fee": KioskFee,
        "delivery_fee": deliveryFee,
        "total_discount": totalDiscount,
        "rate": rate,
        "tax": tax,
        "commission_fee": commissionFee,
        "service_fee": serviceFee,
        "status": status,
        "location": location?.toJson(),
        "address": orderAddress?.toJson(),
        "delivery_type": deliveryType,
        "delivery_date":
            "${deliveryDate!.year.toString().padLeft(4, '0')}-${deliveryDate!.month.toString().padLeft(2, '0')}-${deliveryDate!.day.toString().padLeft(2, '0')}",
        "delivery_time": deliveryTime,
        "delivery_date_time": deliveryDateTime?.toIso8601String(),
        "current": current,
        "split": split,
        "paid_by_split": paidBySplit,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deliveryman": deliveryman?.toJson(),
        "shop": shop?.toJson(),
        "currency": currency?.toJson(),
        "user": user?.toJson(),
        "details": details == null
            ? []
            : List<dynamic>.from(details!.map((x) => x.toJson())),
        "transaction": transaction,
        "review": review,
        "point_histories": pointHistories == null
            ? []
            : List<dynamic>.from(pointHistories!.map((x) => x)),
        "order_refunds": orderRefunds == null
            ? []
            : List<dynamic>.from(orderRefunds!.map((x) => x)),
        "coupon": coupon,
        "galleries": galleries == null
            ? []
            : List<dynamic>.from(galleries!.map((x) => x)),
        "my_address": myAddress,
        "table": table?.toJson(),
      };
}

class OrderDetail {
  OrderDetail({
    int? id,
    int? orderId,
    int? stockId,
    num? originPrice,
    num? totalPrice,
    num? tax,
    num? discount,
    int? quantity,
    bool? bonus,
    String? createdAt,
    String? status,
    String? updatedAt,
    Stocks? stock,
    KitchenModel? kitchen,
    List<Addons>? addons,
    bool? isChecked,
  }) {
    _id = id;
    _orderId = orderId;
    _stockId = stockId;
    _status = status;
    _kitchen = kitchen;
    _originPrice = originPrice;
    _totalPrice = totalPrice;
    _tax = tax;
    _discount = discount;
    _quantity = quantity;
    _bonus = bonus;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _stock = stock;
    _addons = addons;
    _isChecked = isChecked;
  }

  OrderDetail.fromJson(dynamic json) {
    _id = json['id'];
    _status = json['status'];
    _orderId = json['order_id'];
    _stockId = json['stock_id'];
    _originPrice = json['origin_price'];
    _totalPrice = json['total_price'];
    _tax = json['tax'];
    _discount = json['discount'];
    _quantity = json['quantity'];
    _bonus =
        json['bonus'].runtimeType == int ? (json['bonus'] != 0) : json['bonus'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _stock = json['stock'] != null ? Stocks.fromJson(json['stock']) : null;
    _kitchen =
        json['kitchen'] != null ? KitchenModel.fromJson(json['kitchen']) : null;
    if (json['addons'] != null) {
      _addons = [];
      json['addons'].forEach((v) {
        _addons?.add(Addons.fromJson(v));
      });
    }
    _isChecked = false;
  }

  int? _id;
  int? _orderId;
  int? _stockId;
  num? _originPrice;
  num? _totalPrice;
  num? _tax;
  num? _discount;
  int? _quantity;
  bool? _bonus;
  String? _createdAt;
  String? _status;
  String? _updatedAt;
  Stocks? _stock;
  KitchenModel? _kitchen;
  List<Addons>? _addons;
  bool? _isChecked;

  OrderDetail copyWith({
    int? id,
    int? orderId,
    int? stockId,
    num? originPrice,
    num? totalPrice,
    num? tax,
    num? discount,
    int? quantity,
    bool? bonus,
    String? createdAt,
    String? updatedAt,
    String? status,
    Stocks? stock,
    KitchenModel? kitchen,
    List<Addons>? addons,
    bool? isChecked,
  }) =>
      OrderDetail(
        id: id ?? _id,
        orderId: orderId ?? _orderId,
        stockId: stockId ?? _stockId,
        originPrice: originPrice ?? _originPrice,
        totalPrice: totalPrice ?? _totalPrice,
        tax: tax ?? _tax,
        discount: discount ?? _discount,
        quantity: quantity ?? _quantity,
        bonus: bonus ?? _bonus,
        kitchen: kitchen ?? _kitchen,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        stock: stock ?? _stock,
        addons: addons ?? _addons,
        status: status ?? _status,
        isChecked: isChecked ?? _isChecked,
      );

  int? get id => _id;

  int? get orderId => _orderId;

  int? get stockId => _stockId;

  num? get originPrice => _originPrice;

  num? get totalPrice => _totalPrice;

  num? get tax => _tax;

  num? get discount => _discount;

  int? get quantity => _quantity;

  bool? get bonus => _bonus;

  String? get createdAt => _createdAt;

  String? get status => _status;

  String? get updatedAt => _updatedAt;

  Stocks? get stock => _stock;

  KitchenModel? get kitchen => _kitchen;

  List<Addons>? get addons => _addons;

  bool? get isChecked => _isChecked;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['order_id'] = _orderId;
    map['stock_id'] = _stockId;
    map['origin_price'] = _originPrice;
    map['total_price'] = _totalPrice;
    map['tax'] = _tax;
    map['discount'] = _discount;
    map['quantity'] = _quantity;
    map['bonus'] = _bonus;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_stock != null) {
      map['stock'] = _stock?.toJson();
    }
    if (_kitchen != null) {
      map['kitchen'] = _kitchen?.toJson();
    }
    return map;
  }
}

class Transaction {
  Transaction({
    int? id,
    int? payableId,
    num? price,
    String? paymentTrxId,
    String? note,
    dynamic performTime,
    String? status,
    String? statusDescription,
    String? createdAt,
    String? updatedAt,
    PaymentData? paymentSystem,
  }) {
    _id = id;
    _payableId = payableId;
    _price = price;
    _paymentTrxId = paymentTrxId;
    _note = note;
    _performTime = performTime;
    _status = status;
    _statusDescription = statusDescription;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _paymentSystem = paymentSystem;
  }

  Transaction.fromJson(dynamic json) {
    _id = json['id'];
    _payableId = json['payable_id'];
    _price = json['price'];
    _paymentTrxId = json['payment_trx_id'];
    _note = json['note'];
    _performTime = json['perform_time'];
    _status = json['status'];
    _statusDescription = json['status_description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _paymentSystem = json['payment_system'] != null
        ? PaymentData.fromJson(json['payment_system'])
        : null;
  }

  int? _id;
  int? _payableId;
  num? _price;
  String? _paymentTrxId;
  String? _note;
  dynamic _performTime;
  String? _status;
  String? _statusDescription;
  String? _createdAt;
  String? _updatedAt;
  PaymentData? _paymentSystem;

  Transaction copyWith({
    int? id,
    int? payableId,
    num? price,
    String? paymentTrxId,
    String? note,
    dynamic performTime,
    String? status,
    String? statusDescription,
    String? createdAt,
    String? updatedAt,
    PaymentData? paymentSystem,
  }) =>
      Transaction(
        id: id ?? _id,
        payableId: payableId ?? _payableId,
        price: price ?? _price,
        paymentTrxId: paymentTrxId ?? _paymentTrxId,
        note: note ?? _note,
        performTime: performTime ?? _performTime,
        status: status ?? _status,
        statusDescription: statusDescription ?? _statusDescription,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        paymentSystem: paymentSystem ?? _paymentSystem,
      );

  int? get id => _id;

  int? get payableId => _payableId;

  num? get price => _price;

  String? get paymentTrxId => _paymentTrxId;

  String? get note => _note;

  dynamic get performTime => _performTime;

  String? get status => _status;

  String? get statusDescription => _statusDescription;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  PaymentData? get paymentSystem => _paymentSystem;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['payable_id'] = _payableId;
    map['price'] = _price;
    map['payment_trx_id'] = _paymentTrxId;
    map['note'] = _note;
    map['perform_time'] = _performTime;
    map['status'] = _status;
    map['status_description'] = _statusDescription;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_paymentSystem != null) {
      map['payment_system'] = _paymentSystem?.toJson();
    }
    return map;
  }
}

class OrderAddress {
  OrderAddress({
    String? address,
    String? office,
    String? house,
    String? floor,
  }) {
    _address = address;
    _office = office;
    _house = house;
    _floor = floor;
  }

  OrderAddress.fromJson(dynamic json) {
    _address = json['address'];
    _office = json['office'];
    _house = json['house'];
    _floor = json['floor'];
  }

  String? _address;
  String? _office;
  String? _house;
  String? _floor;

  OrderAddress copyWith({
    String? address,
    String? office,
    String? house,
    String? floor,
  }) =>
      OrderAddress(
        address: address ?? _address,
        office: office ?? _office,
        house: house ?? _house,
        floor: floor ?? _floor,
      );

  String? get address => _address;

  String? get office => _office;

  String? get house => _house;

  String? get floor => _floor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = _address;
    map['office'] = _office;
    map['house'] = _house;
    map['floor'] = _floor;
    return map;
  }
}

class KitchenModel {
  String? id;
  int? active;
  String? shopId;
  Translation? translation;

  KitchenModel({
    this.id,
    this.active,
    this.shopId,
    this.translation,
  });

  KitchenModel copyWith({
    int? id,
    int? active,
    String? shopId,
    Translation? translation,
  }) =>
      KitchenModel(
        id: id.toString(),
        active: active ?? this.active,
        shopId: shopId ?? this.shopId,
        translation: translation ?? this.translation,
      );

  factory KitchenModel.fromJson(Map<String, dynamic> json) => KitchenModel(
        id: json["id"],
        active: json["active"],
        shopId: json["shop_id"],
        translation: json["translation"] == null
            ? null
            : Translation.fromJson(json["translation"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "active": active,
        "shop_id": shopId,
        "translation": translation?.toJson(),
      };
}
