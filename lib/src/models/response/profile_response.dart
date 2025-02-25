import '../data/kiosk_data.dart';

class ProfileResponse {
  ProfileResponse({KioskData? data}) {
    _data = data;
  }

  ProfileResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? KioskData.fromJson(json['data']) : null;
  }

  KioskData? _data;

  ProfileResponse copyWith({KioskData? data}) =>
      ProfileResponse(data: data ?? _data);

  KioskData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}
