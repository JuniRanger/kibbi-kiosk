class LoginResponse {
  LoginResponse({
    String? message,
    String? token,
    String? kioskId,
    String? restaurantId,  // Cambié data por kiosk
  }) {
    _message = message;
    _token = token;
    _kioskId = kioskId;
    _restaurantId = restaurantId;
  }

  LoginResponse.fromJson(Map<String, dynamic> json) {
    _message = json['message'];
    _token = json['token'];
    _kioskId = json['kioskId'];
    _restaurantId = json['restaurantId'];  // Cambié data por kiosk
  }

  String? _message;
  String? _token;
  String? _kioskId;
  String? _restaurantId;

  LoginResponse copyWith({
    String? message,
    String? token,
    String? kioskId,
    String? restaurantId,
  }) =>
      LoginResponse(
        message: message ?? _message,
        token: token ?? _token,
        kioskId: kioskId ?? _kioskId,
        restaurantId: restaurantId ?? _restaurantId,
      );

  String? get message => _message;
  String? get token => _token;
  String? get kioskId => _kioskId;
  String? get restaurantId => _restaurantId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['token'] = _token;
    map['kioskId'] = _kioskId;
    map['restaurantId'] = _restaurantId;
    return map;
  }
}