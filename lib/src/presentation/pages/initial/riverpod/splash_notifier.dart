import 'package:kibbi_kiosk/src/core/routes/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kibbi_kiosk/src/presentation/pages/initial/riverpod/splash_state.dart';
import '../../../../core/utils/utils.dart';

class SplashNotifier extends StateNotifier<SplashState> {
  SplashNotifier() : super(const SplashState());

  Future<void> checkConnectivity(BuildContext context) async {
    // Verificamos la conectividad a internet
    final connect = await AppConnectivity.connectivity();
    if (connect) {
      // Si hay conexión, navegamos dependiendo del estado del token
      if (context.mounted) {
        if (LocalStorage.getToken().isEmpty) {
          context.replaceRoute(const LoginRoute());  // Redirige al login si no hay token
        } else {
          context.replaceRoute(const MainRoute());  // Redirige a la pantalla principal si hay token
        }
      }
    } else {
      debugPrint('==> No hay conexión a la red');
      if (context.mounted) {
        AppHelpers.showSnackBar(context, 'Revisa tu conexión a la red');
      }
    }
  }
}
