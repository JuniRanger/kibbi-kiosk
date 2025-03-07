import 'addons_data.dart';

class ProductData {
  final String? id;
  final String name;
  final String description;
  final num costPrice; // Cambié a num
  final num salePrice; // Cambié a num
  final String currency;
  final bool availability;
  final String restaurantId;
  final List<String> ingredients;
  final String category;
  final String imageUrl;
  final String createdAt;
  final String updatedAt;

  ProductData({
    this.id,
    required this.name,
    required this.description,
    required this.costPrice,
    required this.salePrice,
    required this.currency,
    required this.availability,
    required this.restaurantId,
    required this.ingredients,
    required this.category,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      costPrice: json['costPrice'], // Ahora se maneja directamente como num
      salePrice: json['salePrice'], // Ahora se maneja directamente como num
      currency: json['currency'],
      availability: json['availability'],
      restaurantId: json['restaurantId'],
      ingredients: List<String>.from(json['ingredients'] ?? []),
      category: json['category'],
      imageUrl: json['image'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
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
    };
  }

  String? get getId => id;
  String get getName => name;
  String get getDescription => description;
  num get getCostPrice => costPrice; // Se mantiene como num
  num get getSalePrice => salePrice; // Se mantiene como num
  String get getCurrency => currency;
  bool get getAvailability => availability;
  String get getRestaurantId => restaurantId;
  List<String> get getIngredients => ingredients;
  String get getCategory => category;
  String get getImageUrl => imageUrl;
  String get getCreatedAt => createdAt;
  String get getUpdatedAt => updatedAt;
}

// Nueva clase para manejar productos en la orden
class OrderProduct {
  final ProductData product;
  int quantity;
  final num unitPrice; // Se mantiene como num

  OrderProduct({
    required this.product,
    this.quantity = 1,
    required this.unitPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': product.id,
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }
}


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






