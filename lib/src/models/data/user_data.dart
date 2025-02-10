import 'package:kiosk/src/models/data/shop_data.dart';

class UserData {
  String? name;
  String? email;
  String? phone;
  ShopData? shop;

  UserData({
    this.name,
    this.phone,
    this.shop,
    this.email,
  });

  UserData copyWith({
    String? name,
    String? phone,
    String? email,
  }) =>
      UserData(
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
      );

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        name: json["name"],
        shop: json["shop"] == null ? null : ShopData.fromJson(json["shop"]),
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "shop": shop?.toJson(),
      };
}
