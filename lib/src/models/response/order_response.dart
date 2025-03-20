class OrderResponse {
  final String numOrder;
  final List<Product> products;
  final double totalCost;
  final double totalSale;
  final String status;
  final String? notes;
  final String createdById;
  final String createdByName;
  final String createdByType;
  final String restaurantId;
  final String restaurantName;
  final String customerName;
  final String paymentMethod;
  final String currency;
  final String orderType;
  final String? paymentStatus; // Hacerlo opcional
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String? stripePaymentUrl; // Descomentado y ahora puede ser nulo

  OrderResponse({
    required this.numOrder,
    required this.products,
    required this.totalCost,
    required this.totalSale,
    required this.status,
    this.notes,
    required this.createdById,
    required this.createdByName,
    required this.createdByType,
    required this.restaurantId,
    required this.restaurantName,
    required this.customerName,
    required this.paymentMethod,
    required this.currency,
    required this.orderType,
    this.paymentStatus, // Ahora es opcional
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.stripePaymentUrl, // Ahora es opcional
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      numOrder: json['numOrder'].toString(), // Convertir a String si es necesario
      products: List<Product>.from(
          json['products'].map((x) => Product.fromJson(x))),
      totalCost: (json['totalCost'] as num).toDouble(),
      totalSale: (json['totalSale'] as num).toDouble(),
      status: json['status'],
      notes: json['notes'],
      createdById: json['createdById'],
      createdByName: json['createdByName'],
      createdByType: json['createdByType'],
      restaurantId: json['restaurantId'],
      restaurantName: json['restaurantName'],
      customerName: json['customerName'],
      paymentMethod: json['paymentMethod'],
      currency: json['currency'],
      orderType: json['orderType'],
      paymentStatus: json['paymentStatus'], // Puede ser null
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
      stripePaymentUrl: json['stripePaymentUrl'], // Puede ser null
    );
  }
}

class Product {
  final String productId;
  final String name;
  final int quantity;
  final double costPrice;
  final double salePrice;
  final Category category;
  final String id;

  Product({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.costPrice,
    required this.salePrice,
    required this.category,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      name: json['name'],
      quantity: json['quantity'],
      costPrice: (json['costPrice'] as num).toDouble(),
      salePrice: (json['salePrice'] as num).toDouble(),
      category: Category.fromJson(json['category']),
      id: json['_id'],
    );
  }
}

class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}
