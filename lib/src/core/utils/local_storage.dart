import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import '../../models/models.dart';

import '../constants/constants.dart';

abstract class LocalStorage {
  LocalStorage._();

  static SharedPreferences? _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> setToken(String? token) async {
    if (_preferences != null) {
      await _preferences!.setString(StorageKeys.keyToken, token ?? '');
      debugPrint('===> token: $token');
    }
  }

  static String getToken() =>
      _preferences?.getString(StorageKeys.keyToken) ?? '';

  static void deleteToken() => _preferences?.remove(StorageKeys.keyToken);

  static KioskData? getKiosk() {
    final savedString = _preferences?.getString(StorageKeys.keyKiosk);
    if (savedString == null) {
      return null;
    }
    final map = jsonDecode(savedString);
    if (map == null) {
      return null;
    }
    return KioskData.fromJson(map);
  }

  static Future<void> saveRestaurantId(String restaurantId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(StorageKeys.keyRestaurant, restaurantId);
  }

  static Future<String?> getRestaurantId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(StorageKeys.keyRestaurant);
  }

  

  // Devuelve siempre 'MXN', sin interactuar con SharedPreferences
  static String getSelectedCurrency() {
    return 'MXN';
  }


  static Future<void> setBag(BagData bag) async {
    if (_preferences != null) {
      final String bagString = jsonEncode(bag.toJson());
      await _preferences!.setString(StorageKeys.keyBag, bagString);
      debugPrint('===> Bag set: $bagString');
    }
  }

  static BagData? getBag() {
    final savedString = _preferences?.getString(StorageKeys.keyBag);
    if (savedString == null) {
      debugPrint('===> No bag found');
      return null;
    }
    final map = jsonDecode(savedString);
    debugPrint('===> Bag retrieved: $savedString');
    return BagData.fromJson(map);
  }

  static void deleteCartProducts() => _preferences?.remove(StorageKeys.keyBag);


  static void clearStore() {
    deleteCartProducts();
    deleteToken();
    deleteCartProducts();
    debugPrint('===> Store cleared');
  }
}
