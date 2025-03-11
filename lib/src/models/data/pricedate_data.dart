import 'product_data.dart';

class PriceDate {
  PriceDate({
    this.stocks,
    this.totalTax,
    this.price,
    this.totalShopTax,
    this.totalPrice,
    this.totalDiscount,
    this.deliveryFee,
    this.serviceFee,
    this.rate,
    this.couponPrice,
    this.km,
  });

  List<ProductData>? stocks;
  num? totalTax;
  num? price;
  num? totalShopTax;
  num? totalPrice;
  num? totalDiscount;
  num? serviceFee;
  num? deliveryFee;
  num? rate;
  num? couponPrice;
  double? km;

  PriceDate copyWith({
    List<ProductData>? stocks,
    num? totalTax,
    num? price,
    num? totalShopTax,
    num? totalPrice,
    num? totalDiscount,
    num? deliveryFee,
    num? serviceFee,
    num? rate,
    num? couponPrice,
    double? km,
  }) =>
      PriceDate(
        stocks: stocks ?? this.stocks,
        totalTax: totalTax ?? this.totalTax,
        price: price ?? this.price,
        totalShopTax: totalShopTax ?? this.totalShopTax,
        totalPrice: totalPrice ?? this.totalPrice,
        totalDiscount: totalDiscount ?? this.totalDiscount,
        deliveryFee: deliveryFee ?? this.deliveryFee,
        serviceFee: serviceFee ?? this.serviceFee,
        rate: rate ?? this.rate,
        couponPrice: couponPrice ?? this.couponPrice,
        km: km ?? this.km,
      );

  factory PriceDate.fromJson(Map<String, dynamic> json) {
    return PriceDate(
      stocks: json["stocks"] == null
          ? []
          : List<ProductData>.from(
              json["stocks"]!.map((x) => ProductData.fromJson(x))),
      totalTax: json["total_tax"]?.toDouble(),
      price: json["price"],
      totalShopTax: json["total_shop_tax"]?.toDouble(),
      totalPrice: json["total_price"]?.toDouble(),
      totalDiscount: json["total_discount"],
      deliveryFee: json["delivery_fee"],
      serviceFee: json["service_fee"],
      rate: json["rate"],
      couponPrice: json["coupon_price"],
      km: json["km"]?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        "stocks": stocks == null
            ? []
            : List<dynamic>.from(stocks!.map((x) => x.toJson())),
        "total_tax": totalTax,
        "price": price,
        "total_shop_tax": totalShopTax,
        "total_price": totalPrice,
        "total_discount": totalDiscount,
        "service_fee": serviceFee,
        "delivery_fee": deliveryFee,
        "rate": rate,
        "coupon_price": couponPrice,
        "km": km,
      };
}