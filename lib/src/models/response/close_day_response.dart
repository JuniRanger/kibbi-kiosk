class CloseDayResponse {
  Data? data;

  CloseDayResponse({
    this.data,
  });

  CloseDayResponse copyWith({
    Data? data,
  }) =>
      CloseDayResponse(
        data: data ?? this.data,
      );

  factory CloseDayResponse.fromJson(Map<String, dynamic> json) =>
      CloseDayResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  List<BookingShopClosedDate>? bookingShopClosedDate;

  Data({
    this.bookingShopClosedDate,
  });

  Data copyWith({
    List<BookingShopClosedDate>? bookingShopClosedDate,
  }) =>
      Data(
        bookingShopClosedDate:
            bookingShopClosedDate ?? this.bookingShopClosedDate,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookingShopClosedDate: json["booking_shop_closed_date"] == null
            ? []
            : List<BookingShopClosedDate>.from(json["booking_shop_closed_date"]!
                .map((x) => BookingShopClosedDate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "booking_shop_closed_date": bookingShopClosedDate == null
            ? []
            : List<dynamic>.from(bookingShopClosedDate!.map((x) => x.toJson())),
      };
}

class BookingShopClosedDate {
  int? id;
  DateTime? day;

  BookingShopClosedDate({
    this.id,
    this.day,
  });

  BookingShopClosedDate copyWith({
    int? id,
    DateTime? day,
  }) =>
      BookingShopClosedDate(
        id: id ?? this.id,
        day: day ?? this.day,
      );

  factory BookingShopClosedDate.fromJson(Map<String, dynamic> json) =>
      BookingShopClosedDate(
        id: json["id"],
        day: json["day"] == null ? null : DateTime.tryParse(json["day"])?.toLocal(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day":
            "${day!.year.toString().padLeft(4, '0')}-${day!.month.toString().padLeft(2, '0')}-${day!.day.toString().padLeft(2, '0')}",
      };
}

