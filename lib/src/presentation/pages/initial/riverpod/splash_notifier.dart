import 'package:kiosk/src/core/constants/constants.dart';
import 'package:kiosk/src/core/routes/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/utils.dart';
import 'package:kiosk/src/repository/repository.dart';
import 'splash_state.dart';

class SplashNotifier extends StateNotifier<SplashState> {
  final SettingsFacade _settingsRepository;

  SplashNotifier(this._settingsRepository) : super(const SplashState());

  Future<void> fetchGlobalSettings(BuildContext context) async {
    if (LocalStorage.getLanguage()?.locale?.isEmpty ?? true) {
      final connect = await AppConnectivity.connectivity();
      if (connect) {
        final response = await _settingsRepository.getGlobalSettings();
        response.when(
          success: (data) async {
            await LocalStorage.setActiveLocale(AppHelpers.getInitialLocale());
            getTranslations(
              goLogin: () {
                context.replaceRoute(const LoginRoute());
              },
              goMain: () {
                context.replaceRoute(const LanguagesRoute());
              },
            );
          },
          failure: (failure, status) {
            debugPrint('==> error with settings fetched');
            getTranslations(
              goLogin: () {
                context.replaceRoute(const LoginRoute());
              },
              goMain: () {
                context.replaceRoute(const LanguagesRoute());
              },
            );
          },
        );
      } else {
        debugPrint('==> get active languages no connection');
        if (context.mounted) {
          AppHelpers.showSnackBar(context, TrKeys.checkYourNetworkConnection);
        }
      }
    } else {
      getTranslations(
        goLogin: () {
          context.replaceRoute(const LoginRoute());
        },
        goMain: () {
          context.replaceRoute(const LanguagesRoute());
        },
      );
    }
  }

  Future<void> getTranslations({
    VoidCallback? goMain,
    VoidCallback? goLogin,
  }) async {
    final response = await _settingsRepository.getTranslations();
    response.when(
      success: (data) async {
        await LocalStorage.setTranslations(data.data);
        if (LocalStorage.getToken().isEmpty) {
          goLogin?.call();
        } else {
          goMain?.call();
        }
      },
      failure: (failure, status) {
        debugPrint('==> error with fetching translations $failure');
        if (LocalStorage.getToken().isEmpty) {
          goLogin?.call();
        } else {
          goMain?.call();
        }
      },
    );
  }
}
