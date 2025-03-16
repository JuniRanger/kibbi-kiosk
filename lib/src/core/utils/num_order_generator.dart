import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class OrderNumberGenerator {
  static const String _orderKey = 'currentOrderNumber';
  static const String _dateKey = 'lastOrderDate';

  /// Genera un número de orden que se reinicia cada día
  static Future<int> generateOrderNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // Obtener la fecha actual en formato YYYY-MM-DD
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Obtener la última fecha guardada y el último número de orden
    String? lastDate = prefs.getString(_dateKey);
    int currentOrderNumber = prefs.getInt(_orderKey) ?? 0;

    if (lastDate == today) {
      // Si es el mismo día, incrementar el número de orden
      currentOrderNumber++;
    } else {
      // Si es un nuevo día, resetear a 1 y guardar la nueva fecha
      currentOrderNumber = 1;
      await prefs.setString(_dateKey, today);
    }

    // Guardar el nuevo número de orden
    await prefs.setInt(_orderKey, currentOrderNumber);

    return currentOrderNumber;
  }
}
