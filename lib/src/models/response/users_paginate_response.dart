import '../models.dart';

class UsersPaginateResponse {
  UsersPaginateResponse({List<KioskData>? users, Meta? meta}) {
    _users = users;
    _meta = meta;
  }

  UsersPaginateResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _users = [];
      json['data'].forEach((v) {
        _users?.add(KioskData.fromJson(v));
      });
    }
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;

  }

  List<KioskData>? _users;
  Meta? _meta;

  UsersPaginateResponse copyWith({List<KioskData>? users, Meta? meta}) =>
      UsersPaginateResponse(users: users ?? _users, meta: meta ?? _meta);

  List<KioskData>? get users => _users;
  Meta? get meta => _meta;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_users != null) {
      map['data'] = _users?.map((v) => v.toJson()).toList();
    }
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }
}
