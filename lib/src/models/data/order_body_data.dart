// import 'package:kibbi_kiosk/src/core/utils/local_storage.dart';
import 'package:kibbi_kiosk/src/models/data/bag_data.dart';

import 'package:kibbi_kiosk/src/models/data/bag_data.dart';

class OrderBodyData {
  final String? note;
  final BagData bagData;
  final String orderType; // "llevar" o "comer Aquí"
  final int numOrder; // Número de orden generado dinámicamente
  
  OrderBodyData({
    this.note,
    required this.bagData,
    required this.orderType,
    required this.numOrder,
  });

  Map toJson() {
    Map newMap = {};

    // Agregamos la información adicional
    newMap['numOrder'] = numOrder;
    newMap['orderType'] = orderType;
    if (note?.isNotEmpty ?? false) newMap["note"] = note;
    
    // Directamente usamos los productos de bagData
    newMap['products'] = bagData.bagProducts?.map((stock) {
      return {
        'productId': stock.productId,  // productId del producto
        'quantity': stock.quantity,    // Cantidad del producto
      };
    }).toList();

    return newMap;
  }
}
