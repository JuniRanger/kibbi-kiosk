class CategoryData {
  CategoryData({
    String? id,
    String? name,
    String? description,
    String? restaurantId,
    int? v,
  }) {
    _id = id;
    _name = name;
    _description = description;
    _restaurantId = restaurantId;
    _v = v;
  }

  CategoryData.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _description = json['description'];
    _restaurantId = json['restaurantId'];
    _v = json['__v'];
  }

  String? _id;
  String? _name;
  String? _description;
  String? _restaurantId;
  int? _v;

  CategoryData copyWith({
    String? id,
    String? name,
    String? description,
    String? restaurantId,
    int? v,
  }) =>
      CategoryData(
        id: id ?? _id,
        name: name ?? _name,
        description: description ?? _description,
        restaurantId: restaurantId ?? _restaurantId,
        v: v ?? _v,
      );

  String? get id => _id;

  String? get name => _name;

  String? get description => _description;

  String? get restaurantId => _restaurantId;

  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['restaurantId'] = _restaurantId;
    map['__v'] = _v;
    return map;
  }
}
