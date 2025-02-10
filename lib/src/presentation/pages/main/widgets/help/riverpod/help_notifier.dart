import 'package:kiosk/src/core/di/dependency_manager.dart';
import 'package:kiosk/src/core/utils/app_connectivity.dart';
import 'package:kiosk/src/core/utils/app_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'help_state.dart';

class HelpNotifier extends StateNotifier<HelpState> {
  HelpNotifier() : super(const HelpState());

  Future<void> fetchHelp(BuildContext context) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true);
      final response = await settingsRepository.getFaq();
      response.when(
        success: (data) async {
          state = state.copyWith(
            isLoading: false,
            data: data,
          );
        },
        failure: (failure,status)  {
          state = state.copyWith(isLoading: false);
          AppHelpers.showSnackBar(context, failure);
        },
      );
    } else {
      if (context.mounted) {
        // AppHelpers.showNoConnectionSnackBar(context);
      }
    }
  }
}
