import 'dart:convert';
import 'package:flutter/material.dart';
import '../utils/utils.dart';

class TokenManager {
  /// Decodifica el token y extrae el `restaurantId`
  static Future<String?> getRestaurantId() async {
    final String? token = await LocalStorage.getToken();
    if (token == null) {
      debugPrint('❌ No se encontró ningún token.');
      return null;
    }

    try {
      // Extraer el payload del JWT (sin validar la firma)
      final parts = token.split('.');
      if (parts.length != 3) {
        debugPrint('❌ Token inválido.');
        return null;
      }

      // Decodificar el payload del JWT (base64Url → JSON)
      final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
      final Map<String, dynamic> decodedToken = json.decode(payload);

      // Extraer el ID del restaurante
      final String? restaurantId = decodedToken['restaurant'];
      debugPrint('🔍 ID del restaurante obtenido del token: $restaurantId');
      
      return restaurantId;
    } catch (e) {
      debugPrint('❌ Error al decodificar el token: $e');
      return null;
    }
  }
}
