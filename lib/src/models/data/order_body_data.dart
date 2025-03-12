// import 'package:kibbi_kiosk/src/core/utils/local_storage.dart';
import 'package:kibbi_kiosk/src/models/data/bag_data.dart';

class OrderBodyData {
  final String? note;
  final BagData bagData;
  final String orderType; // "llevar" o "comer Aquí"
  final String paymentMethod; // "efectivo" o "tarjeta"

  OrderBodyData({
    this.note,
    required this.bagData,
    required this.orderType,
    required this.paymentMethod,
  });

  Map toJson() {
    Map newMap = {};
    List<Map<String, dynamic>> products = [];

    // Iteramos sobre los productos en la bolsa (bagProducts)
    for (BagProductData stock in bagData.bagProducts ?? []) {
      List<Map<String, dynamic>> addons = [];
      for (BagProductData stock in bagData.bagProducts ?? []) {
        // Agregamos los addons si existen
        products.add({
        'productId': stock.productId,  // productId del producto
        'quantity': stock.quantity,    // Cantidad del producto
      });
      }

      // Agregamos el producto y su cantidad
      products.add({
        'productId': stock.productId, // Utilizamos stockId como productId
        'quantity': stock.quantity,
        if (addons.isNotEmpty) 'addons': addons,
      });
    }

    // Agregamos la información adicional
    newMap['orderType'] = orderType;
    newMap['paymentMethod'] = paymentMethod;
    if (note?.isNotEmpty ?? false) newMap["note"] = note;
    newMap['products'] = products;

    return newMap;
  }
}



// class ProductOrder {
//   final int stockId;
//   final num price;
//   final int quantity;
//   final num tax;
//   final num discount;
//   final num totalPrice;

//   ProductOrder({
//     required this.stockId,
//     required this.price,
//     required this.quantity,
//     required this.tax,
//     required this.discount,
//     required this.totalPrice,
//   });

//   @override
//   String toString() {
//     return "{\"stock_id\":$stockId, \"price\":$price, \"qty\":$quantity, \"tax\":$tax, \"discount\":$discount, \"total_price\":$totalPrice}";
//   }
// }
