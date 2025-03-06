import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kibbi_kiosk/src/core/utils/utils.dart';
import 'package:kibbi_kiosk/src/repository/repository.dart';
import 'login_state.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  final AuthFacade _authRepository;

  LoginNotifier(this._authRepository)
      : super(const LoginState());

  void setPassword(String text) {
    state = state.copyWith(
      password: text.trim(),
      isLoginError: false,
      isSerialNotValid: false,
      isPasswordNotValid: false,
    );
  } 

  void setSerial(String text) {
    state = state.copyWith(
      serial: text.trim(),
      isLoginError: false,
      isSerialNotValid: false,
      isPasswordNotValid: false,
    );
  }

  void setShowPassword(bool show) {
    state = state.copyWith(showPassword: show);
  }

  Future<void> login({
    VoidCallback? checkYourNetwork,
    VoidCallback? unAuthorised,
    VoidCallback? goToMain,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true);

      final response = await _authRepository.login(
        serial: state.serial,
        password: state.password,
      );  
      response.when(  
        success: (data) async {
          // Guarda el token en local storage
          await LocalStorage.setToken(data.token ?? '');

          // Actualiza el estado y navega al main directamente
          state = state.copyWith(isLoading: false, isLoginError: false);
          if (goToMain != null) {
            goToMain.call();
          } else {
            debugPrint('==> goToMain es null');
          }
        },
        failure: (failure, status) {
          state = state.copyWith(isLoading: false, isLoginError: true);
          if (status == 401) {
            unAuthorised?.call();
          }
          debugPrint('==> login failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }
}
