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
  int _page = 0;

  MainNotifier() : super(const MainState());

  changeIndex(int index) {
    state = state.copyWith(selectIndex: 1); //forzar la vista interna para que siempre sea el apartado de tiendas
  }

  Future<void> fetchShops({
    required BuildContext context,
    bool? isRefresh,
  }) async {
    if (isRefresh ?? false) {
      _page = 0;
    } else if (!state.hasMore) {
      return;
    }
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (_page == 0) {
        state = state.copyWith(isShopsLoading: true, shops: []);
        final response = await shopsRepository.getAllShops(
          page: ++_page,
          query: state.query.isEmpty ? null : state.query,
          isOpen: true,
        );
        response.when(
          success: (data) {
            state = state.copyWith(
              shops: data.data ?? [],
              isShopsLoading: false,
            );
            if ((data.data?.length ?? 0) < 12) {
              state = state.copyWith(hasMore: false);
            }
          },
          failure: (failure, status) {
            state = state.copyWith(isShopsLoading: false);
            debugPrint('==> get shops failure: $failure');
          },
        );
      } else {
        state = state.copyWith(isMoreShopsLoading: true);
        final response = await shopsRepository.getAllShops(
          page: ++_page,
          query: state.query.isEmpty ? null : state.query,
          isOpen: true,
        );
        response.when(
          success: (data) async {
            final List<RestaurantData> newList = List.from(state.shops);
            newList.addAll(data.data ?? []);
            state = state.copyWith(
              shops: newList,
              isMoreShopsLoading: false,
            );
            if ((data.data?.length ?? 0) < 12) {
              state = state.copyWith(hasMore: false);
            }
          },
          failure: (failure, status) {
            state = state.copyWith(isMoreShopsLoading: false);
            debugPrint('==> get Shops more failure: $failure');
          },
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      AppHelpers.showNoConnectionSnackBar(context);
    }
  }

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
          state = state.copyWith(hasMore: true, shops: []);
          _page = 0;
          fetchShops(context: context);
        },
      );
    } else {
      if (_searchShopsTimer?.isActive ?? false) {
        _searchShopsTimer?.cancel();
      }
      _searchShopsTimer = Timer(
        const Duration(milliseconds: 500),
        () {
          state = state.copyWith(hasMore: true, shops: []);
          _page = 0;
          fetchShops(context: context);
        },
      );
    }
  }
}
