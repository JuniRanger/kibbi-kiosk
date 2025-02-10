class BookingsData {
  int id;
  int? maxTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  BookingsData({
    required this.id,
    required this.maxTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookingsData.fromJson(Map<String, dynamic> json) => BookingsData(
    id: json["id"],
    maxTime: json["max_time"] ?? 23,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "max_time": maxTime,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}