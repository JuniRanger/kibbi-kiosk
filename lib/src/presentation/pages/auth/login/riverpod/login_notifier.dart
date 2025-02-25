import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiosk/src/core/utils/utils.dart';
import 'package:kiosk/src/repository/repository.dart';
import 'login_state.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  final AuthFacade _authRepository;
  final UsersRepository _usersRepository;

  LoginNotifier(this._authRepository, this._usersRepository)
      : super(const LoginState());

  void setPassword(String text) {
    state = state.copyWith(
      password: text.trim(),
      isLoginError: false,
      isEmailNotValid: false,
      isPasswordNotValid: false,
    );
  }

  void setSerial(String text) {
    state = state.copyWith(
      serial: text.trim(),
      isLoginError: false,
      isEmailNotValid: false,
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
      // if (!AppValidators.isValidEmail(state.serial)) {
      //   state = state.copyWith(isEmailNotValid: true);
      //   return;
      // }
      state = state.copyWith(isLoading: true);
      final response = await _authRepository.login(
        serial: state.serial,
        password: state.password,
      );
      response.when(
        success: (data) async {
          await LocalStorage.setToken(data.data?.accessToken ?? '');
          LocalStorage.setUser(data.data?.user);

          final res = await _usersRepository.getProfileDetails();
          res.when(
              success: (s) async {
                state = state.copyWith(isLoading: false, isLoginError: false);
                goToMain?.call();
                // if (Platform.isAndroid || Platform.isIOS) {
                //   String? fcmToken;
                //   try {
                //     fcmToken = await FirebaseMessaging.instance.getToken();
                //   } catch (e) {
                //     debugPrint('===> error with getting firebase token $e');
                //   }
                //   _authRepository.updateFirebaseToken(fcmToken);
                // }
              },
              failure: (failure, status) {});
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
