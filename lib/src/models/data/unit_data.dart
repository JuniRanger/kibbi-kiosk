import 'translation.dart';

class UnitData {
  UnitData({
    int? id,
    bool? active,
    String? position,
    String? createdAt,
    String? updatedAt,
    Translation? translation,
  }) {
    _id = id;
    _active = active;
    _position = position;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _translation = translation;
  }

  UnitData.fromJson(dynamic json) {
    _id = json['id'];
    _active = json['active'].runtimeType == int
        ? json['active'] == 1
            ? true
            : false
        : json['active'];
    _position = json['position'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
  }

  int? _id;
  bool? _active;
  String? _position;
  String? _createdAt;
  String? _updatedAt;
  Translation? _translation;

  UnitData copyWith({
    int? id,
    bool? active,
    String? position,
    String? createdAt,
    String? updatedAt,
    Translation? translation,
  }) =>
      UnitData(
        id: id ?? _id,
        active: active ?? _active,
        position: position ?? _position,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        translation: translation ?? _translation,
      );

  int? get id => _id;

  bool? get active => _active;

  String? get position => _position;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Translation? get translation => _translation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['active'] = _active;
    map['position'] = _position;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    return map;
  }
}
