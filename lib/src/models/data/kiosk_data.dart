  class KioskData {
    String? name;
    String? id;
    String? phone;

    KioskData({
      this.name,
      this.phone,
      this.id,
    });

    KioskData copyWith({
      String? name,
      String? phone,
      String? id,
    }) =>
        KioskData(
          name: name ?? this.name,
          phone: phone ?? this.phone,
          id: id.toString(),
        );

    factory KioskData.fromJson(Map<String, dynamic> json) => KioskData(
          name: json["name"],
          phone: json["phone"],
          id: json["id"],
        );

    Map<String, dynamic> toJson() => {
          "name": name,
          "phone": phone,
          "id": id,
        };

    String? get kioskId => id;
  }
