import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../handlers/handlers.dart';

class OrderNumberGenerator {
  static const String _dateKeyPrefix = 'lastOrderDate_';
  static const String _orderKeyPrefix = 'currentOrderNumber_';

  /// Genera un número de orden único por kiosko, reiniciándolo cada día
  static Future<int> generateOrderNumber() async {
    final prefs = await SharedPreferences.getInstance();
    String? kioskId = await TokenManager.getRestaurantId();

    if (kioskId == null) {
      throw Exception('Error: No se encontró el ID del kiosko');
    }

    // Claves personalizadas para este kiosko
    String dateKey = '$_dateKeyPrefix$kioskId';
    String orderKey = '$_orderKeyPrefix$kioskId';

    // Obtener la fecha actual en formato YYYY-MM-DD
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Obtener la última fecha guardada y el último número de orden
    String? lastDate = prefs.getString(dateKey);
    int currentOrderNumber = prefs.getInt(orderKey) ?? 0;

    if (lastDate == today) {
      // Si es el mismo día, incrementar el número de orden
      currentOrderNumber++;
    } else {
      // Si es un nuevo día, resetear a 1 y guardar la nueva fecha
      currentOrderNumber = 1;
      await prefs.setString(dateKey, today);
    }

    // Guardar el nuevo número de orden
    await prefs.setInt(orderKey, currentOrderNumber);

    return currentOrderNumber;
  }
}
