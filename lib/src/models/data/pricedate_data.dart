import 'product_data.dart';

class PriceDate {
  PriceDate({
    this.totalPrice,
    this.stocks,
  });

  num? totalPrice; // Solo conservamos el campo que necesitas
  List<ProductData>? stocks; // Si necesitas los productos, lo dejamos

  PriceDate copyWith({
    num? totalPrice,
    List<ProductData>? stocks,
  }) =>
      PriceDate(
        totalPrice: totalPrice ?? this.totalPrice,
        stocks: stocks ?? this.stocks,
      );

  factory PriceDate.fromJson(Map<String, dynamic> json) {
    return PriceDate(
      totalPrice: json["total_price"]?.toDouble(),
      stocks: json["stocks"] == null
          ? []
          : List<ProductData>.from(
              json["stocks"]!.map((x) => ProductData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "total_price": totalPrice,
        "stocks": stocks == null
            ? []
            : List<dynamic>.from(stocks!.map((x) => x.toJson())),
      };
}