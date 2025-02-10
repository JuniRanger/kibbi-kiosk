class Meta {
  Meta({num? total}) {
    _total = total;
  }

  Meta.fromJson(dynamic json) {
    _total = json['total'];
  }

  num? _total;

  Meta copyWith({num? total}) => Meta(total: total ?? _total);

  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    return map;
  }
}
