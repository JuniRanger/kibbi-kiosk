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

    static void deleteCartProducts() => _preferences?.remove(StorageKeys.keyCart);


  static Future<void> setBags(List<BagData> bags) async {
    if (_preferences != null) {
      final List<String> strings =
          bags.map((bag) => jsonEncode(bag.toJson())).toList();
      await _preferences!.setStringList(StorageKeys.keyBags, strings);
    }
  }

    static List<BagData> getBags() {
    final List<String> bags =
        _preferences?.getStringList(StorageKeys.keyBags) ?? [];
    final List<BagData> localBags = bags
        .map(
          (bag) => BagData.fromJson(jsonDecode(bag)),
        )
        .toList(growable: true);
    return localBags;
  }

      static void clearStore() {
      deleteCartProducts();
      deleteToken();
      deleteCartProducts();
  }
}
