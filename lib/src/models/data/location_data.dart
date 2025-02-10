class LocationData {
  double? latitude;
  double? longitude;
  String? address;

  LocationData({
    this.latitude,
    this.longitude,
    this.address,
  });

  LocationData copyWith({
    double? latitude,
    double? longitude,
    String? address,
  }) =>
      LocationData(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        address: address ?? this.address,
      );

  factory LocationData.fromJson(dynamic json) {
    return LocationData(
      latitude: double.tryParse(json["latitude"].toString()),
      longitude: double.tryParse(json["longitude"].toString()),
      address: json["address"],
    );
  }

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    if (address != null) "address": address,
  };
}
