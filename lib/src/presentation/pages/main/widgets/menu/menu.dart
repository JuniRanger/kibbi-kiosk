import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kibbi_kiosk/src/core/constants/constants.dart';
import 'package:kibbi_kiosk/src/core/routes/app_router.dart';
import 'package:kibbi_kiosk/src/core/utils/utils.dart';
import 'package:kibbi_kiosk/src/presentation/components/components.dart';
import 'package:kibbi_kiosk/src/presentation/pages/auth/login/riverpod/login_provider.dart';
import 'package:kibbi_kiosk/src/presentation/theme/theme.dart';

import 'widgets/sections_item.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionsItem(
          title: 'Reiniciar',
          icon: FlutterRemix.history_line,
          onTap: () {
            context.replaceRoute(const SplashRoute());
          },
        ),
        SectionsItem(
          title: 'Cerrar Sesión',
          icon: FlutterRemix.logout_circle_line,
          onTap: () {
            if (AppConstants.devMode) {
              context.replaceRoute(const LoginRoute());
              LocalStorage.clearStore();
              return;
            }
            AppHelpers.showAlertDialog(
              context: context,
              child: Consumer(builder: (context, ref, child) {
                final state = ref.watch(loginProvider);
                final notifier = ref.read(loginProvider.notifier);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextField(
                      label: 'Contraseña',
                      obscure: state.showPassword,
                      onChanged: notifier.setPassword,
                      suffixIcon: IconButton(
                        splashRadius: 24.r,
                        icon: Icon(
                          state.showPassword
                              ? FlutterRemix.eye_line
                              : FlutterRemix.eye_close_line,
                          color: Style.black,
                          size: 20.r,
                        ),
                        onPressed: () =>
                            notifier.setShowPassword(!state.showPassword),
                      ),
                      isError: state.isLoginError || state.isPasswordNotValid,
                      descriptionText: state.isPasswordNotValid
                          ? 'La contraseña debe contener al menos 8 caracteres'
                          : (state.isLoginError
                              ? 'Las credenciales de inicio de sesión no son válidas'
                              : null),
                    ),
                    24.verticalSpace,
                    LoginButton(
                        title: 'Cerrar Sesión',
                        isLoading: state.isLoading,
                        onPressed: () {
                          if (state.password.isEmpty) return;
                          notifier.setSerial(LocalStorage.getKiosk()?.id ?? '');
                          notifier.login(goToMain: () {
                            context.replaceRoute(const LoginRoute());
                            LocalStorage.clearStore();
                          });
                        })
                  ],
                );
              }),
            );
            // context.replaceRoute(const LoginRoute());
            // LocalStorage.clearStore();
          },
        ),
      ],
    );
  }
}
