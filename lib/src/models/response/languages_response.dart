import 'package:kiosk/src/core/utils/utils.dart';
class LanguagesResponse {
  LanguagesResponse({
    String? timestamp,
    bool? status,
    String? message,
    List<LanguageData>? data, // Agregamos el campo 'data'
  }) {
    _timestamp = timestamp;
    _status = status;
    _message = message;
    _data = data ?? []; // Si no se pasa, se asigna una lista vacía
  }

  LanguagesResponse.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = (json['data'] as List).map((e) => LanguageData.fromJson(e)).toList();
    }
  }

  String? _timestamp;
  bool? _status;
  String? _message;
  List<LanguageData> _data = []; // Lista de LanguageData

  List<LanguageData> get data => _data; // Getter para acceder a la lista de idiomas

  LanguagesResponse copyWith({
    String? timestamp,
    bool? status,
    String? message,
    List<LanguageData>? data,
  }) =>
      LanguagesResponse(
        timestamp: timestamp ?? _timestamp,
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  String? get timestamp => _timestamp;

  bool? get status => _status;

  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['timestamp'] = _timestamp;
    map['status'] = _status;
    map['message'] = _message;
    map['data'] = _data.map((e) => e.toJson()).toList(); // Convertimos los objetos LanguageData a JSON
    return map;
  }
}


 class LanguageData {
  LanguageData({
    int? id,
    String? title,
    String? locale,
    bool? backward,
    bool? isDefault,
    bool? active,
    String? img,
  }) {
    _id = id;
    _title = title;
    _locale = locale ?? 'en'; // El idioma por defecto será 'en'
    _backward = backward;
    _default = isDefault ?? true; // Forzar que el idioma por defecto sea inglés
    _active = active ?? true; // El idioma debe estar activo
    _img = img;
  }

  LanguageData.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _locale = json['locale'] ?? 'en'; // Si no se especifica, es inglés
    _backward = json['backward']?.toString().toBool();
    _default = json['default']?.toString().toBool() ?? true;
    _active = json['active']?.toString().toBool() ?? true;
    _img = json['img'];
  }

  int? _id;
  String? _title;
  String? _locale;
  bool? _backward;
  bool? _default;
  bool? _active;
  String? _img;

  LanguageData copyWith({
    int? id,
    String? title,
    String? locale,
    bool? backward,
    bool? isDefault,
    bool? active,
    String? img,
  }) =>
      LanguageData(
        id: id ?? _id,
        title: title ?? _title,
        locale: locale ?? 'en', // El idioma siempre será inglés
        backward: backward ?? _backward,
        isDefault: isDefault ?? _default,
        active: active ?? _active,
        img: img ?? _img,
      );

  int? get id => _id;

  String? get title => _title;

  String? get locale => _locale;

  bool? get backward => _backward;

  bool? get isDefault => _default;

  bool? get active => _active;

  String? get img => _img;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['locale'] = _locale;
    map['backward'] = _backward;
    map['default'] = _default;
    map['active'] = _active;
    map['img'] = _img;
    return map;
  }
}
