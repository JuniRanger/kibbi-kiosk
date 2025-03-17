import 'package:kibbi_kiosk/src/models/data/bag_data.dart';

class OrderBodyData {
  final String? notes;
  final BagData bagData;
  final String orderType; // "llevar" o "comer Aquí"
  final int numOrder; // Número de orden generado dinámicamente
  String? _paymentMethod;  // Propio de OrderBodyData, no depende de BagData

  OrderBodyData({
    this.notes,
    required this.bagData,
    required this.orderType,
    required this.numOrder,
    String? paymentMethod,  // Recibe paymentMethod, se valida en el setter
  }) {
    _paymentMethod = _validatePaymentMethod(paymentMethod ?? 'efectivo'); // Por defecto "Efectivo"
  }

  // Getter para paymentMethod
  String get paymentMethod => _paymentMethod ?? 'efectivo';

  // Setter para asegurarse de que solo se asignen valores válidos
  set paymentMethod(String? method) {
    _paymentMethod = _validatePaymentMethod(method);
  }

  // Método privado para validar el método de pago
  String _validatePaymentMethod(String? method) {
    final lowerMethod = method?.toLowerCase();
    return (lowerMethod == "tarjeta" || lowerMethod == "efectivo") ? lowerMethod! : "efectivo";
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> newMap = {};

    // Agregar información adicional
    newMap['numOrder'] = numOrder;
    newMap['orderType'] = orderType;
    newMap['paymentMethod'] = paymentMethod; // Solo el campo directo
    if (notes?.isNotEmpty ?? false) newMap["notes"] = notes;

    newMap['products'] = bagData.bagProducts?.map((stock) {
      return {
        'productId': stock.productId,
        'quantity': stock.quantity,
      };
    }).toList();

    return newMap;
  }

  // Método copyWith sin el getter y setter
  OrderBodyData copyWith({
    String? notes,
    BagData? bagData,
    String? orderType,
    int? numOrder,
    String? paymentMethod,
  }) {
    return OrderBodyData(
      notes: notes ?? this.notes,
      bagData: bagData ?? this.bagData,
      orderType: orderType ?? this.orderType,
      numOrder: numOrder ?? this.numOrder,
      paymentMethod: paymentMethod ?? this.paymentMethod,  // Solo se pasa como campo
    );
  }
}
