class OrderResponse {
  final Order order;
  final String? paymentUrl; // Hacer paymentUrl opcional

  OrderResponse({
    required this.order,
    this.paymentUrl, // Ahora es opcional
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      order: Order.fromJson(json['order']),
      paymentUrl: json['paymentUrl'], // Si no está presente, será null
    );
  }
}

class Order {
  final String numOrder;
  final List<Product> products;
  final num totalCost; // Cambiado a num
  final num totalSale; // Cambiado a num
  final String status;
  final String? notes; // Hacer notes opcional
  final String createdById;
  final String createdByName;
  final String createdByType;
  final String restaurantId;
  final String restaurantName;
  final String customerName;
  final String paymentMethod;
  final String currency;
  final String orderType;
  final String? paymentStatus; // Hacer paymentStatus opcional
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String? stripePaymentUrl; // Hacer stripePaymentUrl opcional
  final String? coupon; // Puede ser null
  final String? couponId; // Puede ser null
  final num? discount; // Puede ser null
  final num? subtotal; // Puede ser null

  Order({
    required this.numOrder,
    required this.products,
    required this.totalCost,
    required this.totalSale,
    required this.status,
    this.notes, // Ahora es opcional
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
    this.coupon, // Puede ser null
    this.couponId, // Puede ser null
    this.discount, // Puede ser null
    this.subtotal, // Puede ser null
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      numOrder: json['numOrder'].toString(), // Convertir a String si es necesario
      products: json['products'] != null
          ? List<Product>.from(json['products'].map((x) => Product.fromJson(x)))
          : [], // Si es null, usa una lista vacía
      totalCost: json['totalCost'], // Mantener como num
      totalSale: json['totalSale'], // Mantener como num
      status: json['status'],
      notes: json['notes'], // Puede ser null
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
      coupon: json['coupon'], // Puede ser null
      couponId: json['couponId'], // Puede ser null
      discount: json['discount'], // Puede ser null
      subtotal: json['subtotal'], // Puede ser null
    );
  }
}

class Product {
  final String productId;
  final String name;
  final int quantity;
  final num costPrice; // Cambiado a num
  final num salePrice; // Cambiado a num
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
      costPrice: json['costPrice'], // Mantener como num
      salePrice: json['salePrice'], // Mantener como num
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
