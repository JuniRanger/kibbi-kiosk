// ignore_for_file: prefer_null_aware_operators

import 'dart:async';
import 'package:kiosk/src/core/di/dependency_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/utils.dart';
import '../../../../models/models.dart';
import 'main_state.dart';

class MainNotifier extends StateNotifier<MainState> {
  Timer? _searchShopsTimer;

  MainNotifier() : super(const MainState());

  // Esta función solo cambiará el índice de la vista a 1 para la vista interna del restaurante
  changeIndex(int index) {
    state = state.copyWith(selectIndex: 1); // Forzar la vista interna para el restaurante
  }

  // Eliminar la función fetchShops ya que no la necesitas para esta lógica
  void setQuery(BuildContext context, String query) {
    if (state.query == query) {
      return;
    }
    state = state.copyWith(query: query.trim());
    if (state.query.isNotEmpty) {
      if (_searchShopsTimer?.isActive ?? false) {
        _searchShopsTimer?.cancel();
      }
      _searchShopsTimer = Timer(
        const Duration(milliseconds: 500),
        () {
          state = state.copyWith(hasMore: true, shops: []); // No más lógica de tiendas
          // Aquí ya no necesitas hacer fetch de tiendas, solo trabajas con la interfaz interna
        },
      );
    } else {
      if (_searchShopsTimer?.isActive ?? false) {
        _searchShopsTimer?.cancel();
      }
      _searchShopsTimer = Timer(
        const Duration(milliseconds: 500),
        () {
          state = state.copyWith(hasMore: true, shops: []); // Limpiar cualquier resultado
          // Solo trabajas con la interfaz interna del restaurante
        },
      );
    }
  }
}
