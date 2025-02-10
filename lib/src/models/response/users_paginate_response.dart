import '../models.dart';

class UsersPaginateResponse {
  UsersPaginateResponse({List<UserData>? users, Meta? meta}) {
    _users = users;
    _meta = meta;
  }

  UsersPaginateResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _users = [];
      json['data'].forEach((v) {
        _users?.add(UserData.fromJson(v));
      });
    }
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;

  }

  List<UserData>? _users;
  Meta? _meta;

  UsersPaginateResponse copyWith({List<UserData>? users, Meta? meta}) =>
      UsersPaginateResponse(users: users ?? _users, meta: meta ?? _meta);

  List<UserData>? get users => _users;
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
