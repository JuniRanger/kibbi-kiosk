

List<DisableDates> disableDatesFromJson(dynamic str) => List<DisableDates>.from(str.map((x) => DisableDates.fromJson(x)));


class DisableDates {
  DateTime startDate;
  DateTime endDate;

  DisableDates({
    required this.startDate,
    required this.endDate,
  });

  factory DisableDates.fromJson(Map<String, dynamic> json) => DisableDates(
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
  );

  Map<String, dynamic> toJson() => {
    "start_date": startDate.toIso8601String(),
    "end_date": endDate.toIso8601String(),
  };
}
