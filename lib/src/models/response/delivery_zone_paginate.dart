class DeliveryZonePaginate {
  DeliveryZonePaginate({DeliveryZoneData? data}) {
    _data = data;
  }

  DeliveryZonePaginate.fromJson(dynamic json) {
      _data = DeliveryZoneData.fromJson(json['data']);
  }

  DeliveryZoneData? _data;

  DeliveryZonePaginate copyWith({DeliveryZoneData? data}) =>
      DeliveryZonePaginate(data: data ?? _data);

  DeliveryZoneData? get data => _data;

}

class DeliveryZoneData {
  DeliveryZoneData({
    int? id,
    List<List<double>>? address,
  }) {
    _id = id;
    _address = address;
  }

  DeliveryZoneData.fromJson(dynamic json) {
    final List<dynamic>? addresses = json['address'];
    final List<List<double>> parsedAddresses = [];
    if (addresses != null) {
      for (int i = 0; i < addresses.length; i++) {
        final List<dynamic> item = addresses[i];
        List<double> items = [];
        for (int j = 0; j < item.length; j++) {
          items.add(double.parse(item[j].toString()));
        }
        parsedAddresses.add(items);
      }
    }
    _id = json['id'];
    _address = parsedAddresses;
  }

  int? _id;
  List<List<double>>? _address;

  DeliveryZoneData copyWith({
    int? id,
    List<List<double>>? address,
  }) =>
      DeliveryZoneData(
        id: id ?? _id,
        address: address ?? _address,
      );

  int? get id => _id;

  List<List<double>>? get address => _address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['address'] = _address;
    return map;
  }
}
