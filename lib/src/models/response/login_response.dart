import '../data/kiosk_data.dart';

class LoginResponse {
  LoginResponse({
    String? message,
    String? token,
    String? kioskId,
    String? restaurantId,
    KioskData? kiosk,  // Cambié data por kiosk
  }) {
    _message = message;
    _token = token;
    _kioskId = kioskId;
    _restaurantId = restaurantId;
    _kiosk = kiosk;
  }

  LoginResponse.fromJson(Map<String, dynamic> json) {
    _message = json['message'];
    _token = json['token'];
    _kioskId = json['kioskId'];
    _restaurantId = json['restaurantId'];
    _kiosk = json['kiosk'] != null ? KioskData.fromJson(json['kiosk']) : null;  // Cambié data por kiosk
  }

  String? _message;
  String? _token;
  String? _kioskId;
  String? _restaurantId;
  KioskData? _kiosk;  // Cambié data por kiosk

  LoginResponse copyWith({
    String? message,
    String? token,
    String? kioskId,
    String? restaurantId,
    KioskData? kiosk,  // Cambié data por kiosk
  }) =>
      LoginResponse(
        message: message ?? _message,
        token: token ?? _token,
        kioskId: kioskId ?? _kioskId,
        restaurantId: restaurantId ?? _restaurantId,
        kiosk: kiosk ?? _kiosk,  // Cambié data por kiosk
      );

  String? get message => _message;
  String? get token => _token;
  String? get kioskId => _kioskId;
  String? get restaurantId => _restaurantId;
  KioskData? get kiosk => _kiosk;  // Cambié data por kiosk

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['token'] = _token;
    map['kioskId'] = _kioskId;
    map['restaurantId'] = _restaurantId;
    if (_kiosk != null) {  // Cambié data por kiosk
      map['kiosk'] = _kiosk?.toJson();  // Cambié data por kiosk
    }
    return map;
  }
}
