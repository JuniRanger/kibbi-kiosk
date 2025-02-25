import 'package:kiosk/src/models/data/shop_data.dart';

class KioskData {
  String? name;
  String? serial;
  String? phone;
  ShopData? shop;

  KioskData({
    this.name,
    this.phone,
    this.shop,
    this.serial,
  });

  KioskData copyWith({
    String? name,
    String? phone,
    String? serial,
  }) =>
      KioskData(
        name: name ?? this.name,
        phone: phone ?? this.phone,
        serial: serial ?? this.serial,
      );

  factory KioskData.fromJson(Map<String, dynamic> json) => KioskData(
        name: json["name"],
        shop: json["shop"] == null ? null : ShopData.fromJson(json["shop"]),
        phone: json["phone"],
        serial: json["serial"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "serial": serial,
        "shop": shop?.toJson(),
      };
}
