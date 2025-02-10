// To parse this JSON data, do
//
//     final bookingResponse = bookingResponseFromJson(jsonString);

import 'dart:convert';

import '../data/bookings_data.dart';

BookingsResponse bookingResponseFromJson(String str) =>
    BookingsResponse.fromJson(json.decode(str));


class BookingsResponse {
  BookingsData? data;

  BookingsResponse({required this.data});

  factory BookingsResponse.fromJson(Map<String, dynamic> json) =>
      BookingsResponse(data: json["data"]== null?null: BookingsData.fromJson(json["data"]));

}
