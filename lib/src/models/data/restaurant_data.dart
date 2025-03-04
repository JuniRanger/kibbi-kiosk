import 'dart:convert';
import 'package:kiosk/src/core/utils/utils.dart';

import '../models.dart';
import 'bonus_data.dart';
import 'location_data.dart';

RestaurantData restaurantDataFromJson(String str) =>
    RestaurantData.fromJson(json.decode(str));

String restaurantDataToJson(RestaurantData data) => json.encode(data.toJson());

class RestaurantData {
  RestaurantData({
    this.id,
    this.name,
    this.percentage,
    this.phone,
    this.visibility,
    this.openTime,
    this.open,
    this.verify,
    this.closeTime,
    this.backgroundImg,
    this.logoImg,
    this.minAmount,
    this.status,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.location,
    this.productsCount,
    this.translation,
    this.locales,
    this.bonus,
    this.avgRate,
    this.rateCount,
    this.shopWorkingDays,
    this.isRecommend,
    this.tags,
    this.shopClosedDate,
    this.shopPayments,
  });

  String? id;
  String? name;
  num? percentage;
  String? avgRate;
  String? rateCount;
  String? phone;
  bool? visibility;
  bool? isRecommend;

  bool? open;
  bool? verify;
  String? openTime;
  String? closeTime;
  String? backgroundImg;
  String? logoImg;
  num? minAmount;
  String? status;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  LocationData? location;
  num? productsCount;
  Translation? translation;
  List<String>? locales;
  List<TagsModel>? tags;
  // Seller? seller;
  BonusModel? bonus;
  List<ShopWorkingDay>? shopWorkingDays;
  List<ShopClosedDate>? shopClosedDate;
  List<ShopPayment?>? shopPayments;

  factory RestaurantData.fromJson(Map<String, dynamic> json) {
    return RestaurantData(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      // uuid: json["uuid"] ?? 0,
      percentage: json["percentage"] ?? 0,
      phone: json["phone"]?.toString(),
      visibility: json["visibility"].toString().toBool(),
      open: (json["open"].runtimeType == int
              ? (json["open"] == 1)
              : json["open"]) ??
          true,
      verify: (json["verify"].runtimeType == int
              ? (json["verify"] == 1)
              : json["verify"]) ??
          false,
      openTime: json["open_time"] ?? "00:00",
      closeTime: json["close_time"] ?? "00:00",
      backgroundImg: json["background_img"] ?? "",
      logoImg: json["logo_img"] ?? "",
      minAmount: json["min_amount"] ?? 0,
      status: json["status"] ?? "",
      type: json["type"].runtimeType == int
          ? (json["type"] == 1 ? "shop" : "restaurant")
          : json["type"],
      isRecommend: json["is_recommended"] ?? false,
      createdAt: json["created_at"] == null
          ? null
          : DateTime.tryParse(json["created_at"])?.toLocal(),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.tryParse(json["updated_at"])?.toLocal(),
      location: json["location"] == null
          ? null
          : LocationData.fromJson(json["location"]),
      productsCount: json["products_count"] ?? 0,
      translation: json["translation"] == null
          ? null
          : Translation.fromJson(json["translation"]),
      tags: json["tags"] == null
          ? null
          : List<TagsModel>.from(
              json["tags"].map((x) => TagsModel.fromJson(x))),

      avgRate: (double.tryParse(json["rating_avg"].toString()) ?? 0.0)
          .toStringAsFixed(1),
      rateCount: (double.tryParse(json["reviews_count"].toString()) ?? 0.0)
          .toStringAsFixed(0),
      bonus: json["bonus"] != null ? BonusModel.fromJson(json["bonus"]) : null,
      shopWorkingDays: json["shop_working_days"] != null
          ? List<ShopWorkingDay>.from(
              json["shop_working_days"].map((x) => ShopWorkingDay.fromJson(x)))
          : [],
      shopClosedDate: json["shop_closed_date"] != null
          ? List<ShopClosedDate>.from(
              json["shop_closed_date"].map((x) => ShopClosedDate.fromJson(x)))
          : [],
      shopPayments: json["shop_payments"] == null
          ? []
          : List<ShopPayment?>.from(json["shop_payments"]!.map((x) {
              if (x["payment"]["active"]) {
                return ShopPayment.fromJson(x);
              }
            })),
    );
  }

  get isDiscount => null;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "percentage": percentage,
        "phone": phone,
        "visibility": visibility,
        "open_time": openTime,
        "close_time": closeTime,
        "background_img": backgroundImg,
        "logo_img": logoImg,
        "min_amount": minAmount,
        "status": status,
        "type": type,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "location": location?.toJson(),
        "products_count": productsCount,
        "translation": translation?.toJson(),
        "locales":
            locales == null ? null : List<dynamic>.from(locales!.map((x) => x)),
        // "seller": seller?.toJson(),
        "bonus": bonus,
      };
}

// class Seller {
//   Seller({
//     this.id,
//     this.firstname,
//     this.lastname,
//     this.active,
//     this.role,
//   });

//   num? id;
//   String? firstname;
//   String? lastname;
//   bool? active;
//   String? role;

//   factory Seller.fromJson(Map<String, dynamic> json) => Seller(
//         id: json["id"],
//         firstname: json["firstname"],
//         lastname: json["lastname"],
//         active: json["active"],
//         role: json["role"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "firstname": firstname,
//         "lastname": lastname,
//         "active": active,
//         "role": role,
//       };
// }

class ShopClosedDate {
  ShopClosedDate({
    this.id,
    this.day,
    this.createdAt,
    this.updatedAt,
  });

  num? id;
  DateTime? day;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ShopClosedDate.fromJson(Map<String, dynamic>? json) => ShopClosedDate(
        id: json?["id"],
        day: DateTime.tryParse(json?["day"])?.toLocal(),
        createdAt: DateTime.tryParse(json?["created_at"])?.toLocal(),
        updatedAt: DateTime.tryParse(json?["updated_at"])?.toLocal(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day":
            "${day!.year.toString().padLeft(4, '0')}-${day!.month.toString().padLeft(2, '0')}-${day!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class ShopWorkingDay {
  ShopWorkingDay({
    this.id,
    this.day,
    this.from,
    this.to,
    this.disabled,
    this.createdAt,
    this.updatedAt,
  });

  num? id;
  String? day;
  String? from;
  bool? disabled;
  String? to;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ShopWorkingDay.fromJson(Map<String, dynamic>? json) => ShopWorkingDay(
        id: json?["id"],
        day: json?["day"],
        from: json?["from"],
        disabled: json?["disabled"],
        to: json?["to"],
        createdAt: DateTime.tryParse(json?["created_at"])?.toLocal(),
        updatedAt: DateTime.tryParse(json?["updated_at"])?.toLocal(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "from": from,
        "to": to,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class ShopPayment {
  ShopPayment({
    this.id,
    this.shopId,
    this.status,
    this.clientId,
    this.secretId,
    this.payment,
  });

  String? id;
  String? shopId;
  int? status;
  dynamic clientId;
  dynamic secretId;
  Payment? payment;

  factory ShopPayment.fromJson(Map<String, dynamic> json) {
    return ShopPayment(
      id: json["id"],
      shopId: json["shop_id"],
      status: json["status"],
      clientId: json["client_id"],
      secretId: json["secret_id"],
      payment: Payment.fromJson(json["payment"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "status": status,
        "client_id": clientId,
        "secret_id": secretId,
        "payment": payment!.toJson(),
      };
}

class Payment {
  Payment({
    this.id,
    this.tag,
    this.active,
    this.translation,
    this.locales,
  });

  String? id;
  String? tag;
  bool? active;
  dynamic translation;
  List<dynamic>? locales;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        tag: json["tag"],
        active: json["active"],
        translation: json["translation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tag": tag,
        "active": active,
        "translation": translation,
        "locales":
            locales == null ? [] : List<dynamic>.from(locales!.map((x) => x)),
      };
}

class TagsModel {
  String? id;
  String? img;
  Translation? translation;
  List<String>? locales;

  TagsModel({this.id, this.img, this.translation, this.locales});

  TagsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['img'] = img;
    if (translation != null) {
      data['translation'] = translation!.toJson();
    }
    data['locales'] = locales;
    return data;
  }
}
