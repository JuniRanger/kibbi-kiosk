class ProductData {
  final String? id;
  final String? name;
  final String? description;
  final num? costPrice;
  final num? salePrice;
  final String? currency;
  final bool? availability;
  final String? restaurantId;
  final List<String>? ingredients;
  final String? category;
  final String? imageUrl;
  final String? createdAt;
  final String? updatedAt;
  int? quantity;
  final num? discount;
  
  // Añadimos los campos maxQty y minQty
  final int? maxQty;
  final int? minQty;

  ProductData({
    this.id,
    this.name,
    this.description,
    this.costPrice,
    this.salePrice,
    this.currency,
    this.availability,
    this.restaurantId,
    this.ingredients,
    this.category,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.quantity = 1, // Inicializa la cantidad en 1 por defecto
    this.discount,
    this.maxQty,  // Inicia maxQty
    this.minQty,  // Inicia minQty
  });

  ProductData copyWith({
    String? id,
    String? name,
    String? description,
    num? costPrice,
    num? salePrice,
    String? currency,
    bool? availability,
    String? restaurantId,
    List<String>? ingredients,
    String? category,
    String? imageUrl,
    String? createdAt,
    String? updatedAt,
    int? quantity,
    num? discount,
    int? maxQty,  // Añadimos maxQty
    int? minQty,  // Añadimos minQty
  }) {
    return ProductData(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      costPrice: costPrice ?? this.costPrice,
      salePrice: salePrice ?? this.salePrice,
      currency: currency ?? this.currency,
      availability: availability ?? this.availability,
      restaurantId: restaurantId ?? this.restaurantId,
      ingredients: ingredients ?? this.ingredients,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      quantity: quantity ?? this.quantity,
      discount: discount ?? this.discount,
      maxQty: maxQty ?? this.maxQty,  // Asignamos maxQty
      minQty: minQty ?? this.minQty,  // Asignamos minQty
    );
  }

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      costPrice: json['costPrice'],
      salePrice: json['salePrice'],
      currency: json['currency'],
      availability: json['availability'],
      restaurantId: json['restaurantId'],
      ingredients: List<String>.from(json['ingredients'] ?? []),
      category: json['category'],
      imageUrl: json['image'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      quantity: json['quantity'] ?? 1,
      discount: json['discount'],
      maxQty: json['maxQty'],  // Extraemos maxQty
      minQty: json['minQty'],  // Extraemos minQty
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'costPrice': costPrice,
      'salePrice': salePrice,
      'currency': currency,
      'availability': availability,
      'restaurantId': restaurantId,
      'ingredients': ingredients,
      'category': category,
      'image': imageUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'quantity': quantity,
      'discount': discount,
      'maxQty': maxQty,  // Añadimos maxQty al JSON
      'minQty': minQty,  // Añadimos minQty al JSON
    };
  }

  String? get getId => id;
  String? get getName => name;
  String? get getDescription => description;
  num? get getCostPrice => costPrice;
  num? get getSalePrice => salePrice;
  String? get getCurrency => currency;
  bool? get getAvailability => availability;
  String? get getRestaurantId => restaurantId;
  List<String>? get getIngredients => ingredients;
  String? get getCategory => category;
  String? get getImageUrl => imageUrl;
  String? get getCreatedAt => createdAt;
  String? get getUpdatedAt => updatedAt;
  int? get getQuantity => quantity;
  
  // Métodos para maxQty y minQty
  int? get getMaxQty => maxQty;
  int? get getMinQty => minQty;

  set setQuantity(int value) {
    quantity = value;
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
  ProductData? _product;

  Stocks copyWith({
    int? id,
    int? countableId,
    num? price,
    int? quantity,
    String? img,
    num? discount,
    num? tax,
    num? totalPrice,
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
          product: product ?? _product
          );

  int? get id => _id;

  int? get countableId => _countableId;

  num? get price => _price;

  String? get img => _img;


  int? get quantity => _quantity;

  num? get discount => _discount;

  num? get tax => _tax;

  num? get totalPrice => _totalPrice;

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
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    return map;
  }
}

// ¡Ahora tienes la cantidad integrada en tu modelo de producto! 🚀



// Con esto ya puedes manejar la cantidad y precio unitario en la orden 🚀

// class Unit {
//   Unit({
//     int? id,
//     bool? active,
//     String? position,
//     String? createdAt,
//     String? updatedAt,
//   }) {
//     _id = id;
//     _active = active;
//     _position = position;
//     _createdAt = createdAt;
//     _updatedAt = updatedAt;
//   }

//   Unit.fromJson(dynamic json) {
//     _id = json['id'];
//     _position = json['position'];
//     _createdAt = json['created_at'];
//     _updatedAt = json['updated_at'];
//   }

//   int? _id;
//   bool? _active;
//   String? _position;
//   String? _createdAt;
//   String? _updatedAt;

//   Unit copyWith({
//     int? id,
//     bool? active,
//     String? position,
//     String? createdAt,
//     String? updatedAt,
//   }) =>
//       Unit(
//         id: id ?? _id,
//         active: active ?? _active,
//         position: position ?? _position,
//         createdAt: createdAt ?? _createdAt,
//         updatedAt: updatedAt ?? _updatedAt,
//       );

//   int? get id => _id;

//   bool? get active => _active;

//   String? get position => _position;

//   String? get createdAt => _createdAt;

//   String? get updatedAt => _updatedAt;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['active'] = _active;
//     map['position'] = _position;
//     map['created_at'] = _createdAt;
//     map['updated_at'] = _updatedAt;
//     return map;
//   }
// }


// class Category {
//   Category({
//     int? id,
//     String? uuid,
//     int? parentId,
//   }) {
//     _id = id;
//     _uuid = uuid;
//     _parentId = parentId;
//   }

//   Category.fromJson(dynamic json) {
//     _id = json['id'];
//     _uuid = json['uuid'];
//     _parentId = json['parent_id'];
//   }

//   int? _id;
//   String? _uuid;
//   int? _parentId;

//   Category copyWith({
//     int? id,
//     String? uuid,
//     int? parentId,
//   }) =>
//       Category(
//         id: id ?? _id,
//         uuid: uuid ?? _uuid,
//         parentId: parentId ?? _parentId,
//       );

//   int? get id => _id;

//   String? get uuid => _uuid;

//   int? get parentId => _parentId;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['uuid'] = _uuid;
//     map['parent_id'] = _parentId;
//     return map;
//   }
// }



// class Extras {
//   Extras({
//     int? id,
//     int? extraGroupId,
//     String? value,
//     Group? group,
//   }) {
//     _id = id;
//     _extraGroupId = extraGroupId;
//     _value = value;
//     _active = active;
//     _group = group;
//   }

//   Extras.fromJson(dynamic json) {
//     _id = json['id'];
//     _extraGroupId = json['extra_group_id'];
//     _value = json['value'];
//     _group = json['group'] != null ? Group.fromJson(json['group']) : null;
//   }

//   int? _id;
//   int? _extraGroupId;
//   String? _value;
//   bool? _active;
//   Group? _group;

//   Extras copyWith({
//     int? id,
//     int? extraGroupId,
//     String? value,
//     bool? active,
//     Group? group,
//   }) =>
//       Extras(
//         id: id ?? _id,
//         extraGroupId: extraGroupId ?? _extraGroupId,
//         value: value ?? _value,
//         group: group ?? _group,
//       );

//   int? get id => _id;

//   int? get extraGroupId => _extraGroupId;

//   String? get value => _value;

//   bool? get active => _active;

//   Group? get group => _group;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['extra_group_id'] = _extraGroupId;
//     map['value'] = _value;
//     map['active'] = _active;
//     if (_group != null) {
//       map['group'] = _group?.toJson();
//     }
//     return map;
//   }






