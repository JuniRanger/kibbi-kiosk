import 'shop_data.dart';

class KioskData {
  String? name;
  String? id;
  String? phone;
  ShopData? shop;

  KioskData({
    this.name,
    this.phone,
    this.shop,
    this.id,
  });

  KioskData copyWith({
    String? name,
    String? phone,
    String? id,
    ShopData? shop,
  }) =>
      KioskData(
        name: name ?? this.name,
        phone: phone ?? this.phone,
        id: id ?? this.id,
        shop: shop ?? this.shop,
      );

  factory KioskData.fromJson(Map<String, dynamic> json) => KioskData(
        name: json["name"],
        shop: json["shop"] == null ? null : ShopData.fromJson(json["shop"]),
        phone: json["phone"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "id": id,
        "shop": shop?.toJson(),
      };

  String? get kioskId => id;
  String? get restaurantId => shop?.id;
}
