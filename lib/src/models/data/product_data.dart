import 'addons_data.dart';

class ProductData {
  ProductData({
    String? id,
    String? categoryId,
    String? title,
    String? keywords,
    num? tax,
    num? totalPrice,
    num? discount,
    int? quantity,
    int? minQty,
    int? maxQty,
    int? interval,
    bool? active,
    bool? bonus,
    String? img,
    String? createdAt,
    String? updatedAt,
    num? ratingAvg,
    dynamic ordersCount,
    List<Properties>? properties,
    List<Stocks>? stocks,
    List<Addons>? addons,
    Stocks? stock,
    Category? category,
    Brand? brand,
    Unit? unit,
    int? count,
  }) {
    _id = id;
    _categoryId = categoryId;
    _title = title;
    _keywords = keywords;
    _interval = interval;
    _tax = tax;
    _totalPrice = totalPrice;
    _discount = discount;
    _quantity = quantity;
    _tax = tax;
    _minQty = minQty;
    _maxQty = maxQty;
    _active = active;
    _bonus = bonus;
    _img = img;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _ratingAvg = ratingAvg;
    _ordersCount = ordersCount;
    _properties = properties;
    _stocks = stocks;
    _addons = addons;
    _stock = stock;
    _category = category;
    _brand = brand;
    _unit = unit;
    _count = count;
  }

  ProductData.fromJson(dynamic json) {
    _id = json['id'];
    _interval = json['interval'];
    _active = json['active'];
    _bonus = json['bonus'];
    _categoryId = json['category_id'];
    _title = json['title'];
    _keywords = json['keywords'];
    _tax = json['tax'];
    _quantity = json['quantity'];
    _discount = json['discount'];
    _totalPrice = json['total_price'];
    _minQty = json['min_qty'];
    _maxQty = json['max_qty'];
    _img = json['img'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _ratingAvg = json['rating_avg'];
    _ordersCount = json['orders_count'];
    _count = 0;
    _stock = json['stock'] != null ? Stocks.fromJson(json['stock']) : null;
    if (json['properties'] != null) {
      _properties = [];
      json['properties'].forEach((v) {
        _properties?.add(Properties.fromJson(v));
      });
    }
    if (json['stocks'] != null) {
      _stocks = [];
      json['stocks'].forEach((v) {
        _stocks?.add(Stocks.fromJson(v));
      });
    }
    if (json['addons'] != null) {
      _addons = [];
      json['addons'].forEach((v) {
        _addons?.add(Addons.fromJson(v));
      });
    }
    _category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    _brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    _unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
  }

  String? _id;
  int? _interval;
  String? _categoryId;
  String? _title;
  String? _keywords;
  num? _tax;
  int? _quantity;
  num? _totalPrice;
  num? _discount;
  int? _minQty;
  int? _maxQty;
  bool? _active;
  bool? _bonus;
  String? _img;
  String? _createdAt;
  String? _updatedAt;
  num? _ratingAvg;
  dynamic _ordersCount;
  List<Properties>? _properties;
  List<Stocks>? _stocks;
  List<Addons>? _addons;
  Stocks? _stock;
  Category? _category;
  Brand? _brand;
  Unit? _unit;
  int? _count;

  ProductData copyWith({
    String? id,
    String? categoryId,
    String? keywords,
    num? tax,
    int? quantity,
    num? totalPrice,
    num? discount,
    int? minQty,
    int? maxQty,
    int? interval,
    bool? active,
    bool? bonus,
    String? img,
    String? createdAt,
    String? updatedAt,
    num? ratingAvg,
    dynamic ordersCount,
    List<Properties>? properties,
    List<Stocks>? stocks,
    Stocks? stock,
    List<Addons>? addons,
    Category? category,
    Brand? brand,
    Unit? unit,
  }) {
    return ProductData(
      id: id ?? _id,
      interval: interval ?? _interval,
      categoryId: categoryId ?? _categoryId,
      keywords: keywords ?? _keywords,
      tax: tax ?? _tax,
      quantity: quantity ?? _quantity,
      totalPrice: totalPrice ?? _totalPrice,
      discount: discount ?? _discount,
      minQty: minQty ?? _minQty,
      maxQty: maxQty ?? _maxQty,
      active: active ?? _active,
      bonus: bonus ?? _bonus,
      img: img ?? _img,
      createdAt: createdAt ?? _createdAt,
      updatedAt: updatedAt ?? _updatedAt,
      ratingAvg: ratingAvg ?? _ratingAvg,
      ordersCount: ordersCount ?? _ordersCount,
      properties: properties ?? _properties,
      stocks: stocks ?? _stocks,
      stock: stock ?? _stock,
      addons: addons ?? _addons,
      category: category ?? _category,
      brand: brand ?? _brand,
      unit: unit ?? _unit,
    );
  }

  String? get id => _id;

  int? get interval => _interval;

  String? get title => _title;

  String? get categoryId => _categoryId;

  String? get keywords => _keywords;

  num? get tax => _tax;

  int? get quantity => _quantity;

  num? get totalPrice => _totalPrice;

  num? get discount => _discount;

  int? get minQty => _minQty;

  int? get maxQty => _maxQty;

  bool? get active => _active;
  bool? get bonus => _bonus;

  String? get img => _img;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  num? get ratingAvg => _ratingAvg;

  dynamic get ordersCount => _ordersCount;

  Stocks? get stock => _stock;

  List<Properties>? get properties => _properties;

  List<Stocks>? get stocks => _stocks;

  List<Addons>? get addons => _addons;

  Category? get category => _category;

  Brand? get brand => _brand;

  Unit? get unit => _unit;

  int? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['bonus'] = _bonus;
    map['active'] = _active;
    map['category_id'] = _categoryId;
    map['keywords'] = _keywords;
    map['interval'] = _interval;
    map['tax'] = _tax;
    map['min_qty'] = _minQty;
    map['max_qty'] = _maxQty;
    map['active'] = _active;
    map['bonus'] = _bonus;
    map['img'] = _img;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['rating_avg'] = _ratingAvg;
    map['orders_count'] = _ordersCount;
    if (_properties != null) {
      map['properties'] = _properties?.map((v) => v.toJson()).toList();
    }
    if (_stocks != null) {
      map['stocks'] = _stocks?.map((v) => v.toJson()).toList();
    }
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    if (_brand != null) {
      map['brand'] = _brand?.toJson();
    }
    if (_unit != null) {
      map['unit'] = _unit?.toJson();
    }
    return map;
  }
}

class Unit {
  Unit({
    int? id,
    bool? active,
    String? position,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _active = active;
    _position = position;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Unit.fromJson(dynamic json) {
    _id = json['id'];
    _position = json['position'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  bool? _active;
  String? _position;
  String? _createdAt;
  String? _updatedAt;

  Unit copyWith({
    int? id,
    bool? active,
    String? position,
    String? createdAt,
    String? updatedAt,
  }) =>
      Unit(
        id: id ?? _id,
        active: active ?? _active,
        position: position ?? _position,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  int? get id => _id;

  bool? get active => _active;

  String? get position => _position;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['active'] = _active;
    map['position'] = _position;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Brand {
  Brand({
    int? id,
    String? uuid,
    String? title,
  }) {
    _id = id;
    _uuid = uuid;
    _title = title;
  }

  Brand.fromJson(dynamic json) {
    _id = json['id'];
    _uuid = json['uuid'];
    _title = json['title'];
  }

  int? _id;
  String? _uuid;
  String? _title;

  Brand copyWith({
    int? id,
    String? uuid,
    String? title,
  }) =>
      Brand(
        id: id ?? _id,
        uuid: uuid ?? _uuid,
        title: title ?? _title,
      );

  int? get id => _id;

  String? get uuid => _uuid;

  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['uuid'] = _uuid;
    map['title'] = _title;
    return map;
  }
}

class Category {
  Category({
    int? id,
    String? uuid,
    int? parentId,
  }) {
    _id = id;
    _uuid = uuid;
    _parentId = parentId;
  }

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _uuid = json['uuid'];
    _parentId = json['parent_id'];
  }

  int? _id;
  String? _uuid;
  int? _parentId;

  Category copyWith({
    int? id,
    String? uuid,
    int? parentId,
  }) =>
      Category(
        id: id ?? _id,
        uuid: uuid ?? _uuid,
        parentId: parentId ?? _parentId,
      );

  int? get id => _id;

  String? get uuid => _uuid;

  int? get parentId => _parentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['uuid'] = _uuid;
    map['parent_id'] = _parentId;
    return map;
  }
}

class Stocks {
  Stocks({
    int? id,
    int? countableId,
    num? price,
    int? quantity,
    num? discount,
    num? tax,
    num? totalPrice,
    String? img,
    List<Extras>? extras,
    List<Addons>? addons,
    ProductData? product,
  }) {
    _id = id;
    _countableId = countableId;
    _price = price;
    _quantity = quantity;
    _discount = discount;
    _img = img;
    _tax = tax;
    _totalPrice = totalPrice;
    _extras = extras;
    _addons = addons;
    _product = product;
  }

  Stocks.fromJson(dynamic json) {
    _id = json?['id'];
    _countableId = json?['countable_id'];
    _price = json?['price'];
    _img = json?["product"]?["img"];
    _quantity = json?['quantity'];
    _discount = json?['discount'];
    _tax = json?['tax'];
    _totalPrice = json?['total_price'];
    if (json?['extras'] != null) {
      _extras = [];
      if (json?['extras'].runtimeType != bool) {
        json?['extras'].forEach((v) {
          _extras?.add(Extras.fromJson(v));
        });
      }
    }
    if (json?['stock_extras'] != null) {
      _extras = [];
      if (json?['stock_extras'].runtimeType != bool) {
        json?['stock_extras'].forEach((v) {
          _extras?.add(Extras.fromJson(v));
        });
      }
    }
    if (json?['addons'] != null) {
      _addons = [];
      json?['addons'].forEach((v) {
        if (v["product"] != null || v["stock"] != null) {
          _addons?.add(Addons.fromJson(v));
        }
      });
    }
    _product = (json?['product'] != null
        ? ProductData.fromJson(json['product'])
        : (json?['countable'] != null
            ? ProductData.fromJson(json["countable"])
            : null));
  }

  int? _id;
  int? _countableId;
  num? _price;
  int? _quantity;
  num? _discount;
  String? _img;
  num? _tax;
  num? _totalPrice;
  List<Extras>? _extras;
  ProductData? _product;
  List<Addons>? _addons;

  Stocks copyWith({
    int? id,
    int? countableId,
    num? price,
    int? quantity,
    String? img,
    num? discount,
    num? tax,
    num? totalPrice,
    List<Extras>? extras,
    List<Addons>? addons,
    ProductData? product,
  }) =>
      Stocks(
          id: id ?? _id,
          countableId: countableId ?? _countableId,
          price: price ?? _price,
          img: img ?? _img,
          quantity: quantity ?? _quantity,
          discount: discount ?? _discount,
          tax: tax ?? _tax,
          totalPrice: totalPrice ?? _totalPrice,
          extras: extras ?? _extras,
          product: product ?? _product,
          addons: addons ?? _addons);

  int? get id => _id;

  int? get countableId => _countableId;

  num? get price => _price;

  String? get img => _img;

  int? get quantity => _quantity;

  num? get discount => _discount;

  num? get tax => _tax;

  num? get totalPrice => _totalPrice;

  List<Addons>? get addons => _addons;

  List<Extras>? get extras => _extras;

  ProductData? get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['countable_id'] = _countableId;
    map['price'] = _price;
    map['quantity'] = _quantity;
    map['discount'] = _discount;
    map['tax'] = _tax;
    map['total_price'] = _totalPrice;
    if (_extras != null) {
      map['extras'] = _extras?.map((v) => v.toJson()).toList();
    }
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    return map;
  }
}

class Extras {
  Extras({
    int? id,
    int? extraGroupId,
    String? value,
    Group? group,
  }) {
    _id = id;
    _extraGroupId = extraGroupId;
    _value = value;
    _active = active;
    _group = group;
  }

  Extras.fromJson(dynamic json) {
    _id = json['id'];
    _extraGroupId = json['extra_group_id'];
    _value = json['value'];
    _group = json['group'] != null ? Group.fromJson(json['group']) : null;
  }

  int? _id;
  int? _extraGroupId;
  String? _value;
  bool? _active;
  Group? _group;

  Extras copyWith({
    int? id,
    int? extraGroupId,
    String? value,
    bool? active,
    Group? group,
  }) =>
      Extras(
        id: id ?? _id,
        extraGroupId: extraGroupId ?? _extraGroupId,
        value: value ?? _value,
        group: group ?? _group,
      );

  int? get id => _id;

  int? get extraGroupId => _extraGroupId;

  String? get value => _value;

  bool? get active => _active;

  Group? get group => _group;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['extra_group_id'] = _extraGroupId;
    map['value'] = _value;
    map['active'] = _active;
    if (_group != null) {
      map['group'] = _group?.toJson();
    }
    return map;
  }
}

class Group {
  Group({
    int? id,
    String? type,
    bool? active,
  }) {
    _id = id;
    _type = type;
    _active = active;
  }

  Group.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
  }

  int? _id;
  String? _type;
  bool? _active;

  Group copyWith({
    int? id,
    String? type,
    bool? active,
  }) =>
      Group(
        id: id ?? _id,
        type: type ?? _type,
        active: active ?? _active,
      );

  int? get id => _id;

  String? get type => _type;

  bool? get active => _active;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['active'] = _active;
    return map;
  }
}

class Properties {
  Properties({
    String? locale,
    String? key,
    String? value,
  }) {
    _locale = locale;
    _key = key;
    _value = value;
  }

  Properties.fromJson(dynamic json) {
    _locale = json['locale'];
    _key = json['key'];
    _value = json['value'];
  }

  String? _locale;
  String? _key;
  String? _value;

  Properties copyWith({
    String? locale,
    String? key,
    String? value,
  }) =>
      Properties(
        locale: locale ?? _locale,
        key: key ?? _key,
        value: value ?? _value,
      );

  String? get locale => _locale;

  String? get key => _key;

  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['locale'] = _locale;
    map['key'] = _key;
    map['value'] = _value;
    return map;
  }
}
