import '../data/table_data.dart';

class ShopSectionResponse {
  List<ShopSection>? data;

  ShopSectionResponse({this.data});

  ShopSectionResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ShopSection>[];
      json['data'].forEach((v) {
        data!.add(ShopSection.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}