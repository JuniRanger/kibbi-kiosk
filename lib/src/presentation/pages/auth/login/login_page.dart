import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kibbi_kiosk/src/core/routes/app_router.dart';

import 'package:kibbi_kiosk/generated/assets.dart';
import 'package:kibbi_kiosk/src/core/constants/constants.dart';
import 'package:kibbi_kiosk/src/core/utils/utils.dart';
import 'package:kibbi_kiosk/src/presentation/components/components.dart';
import 'package:kibbi_kiosk/src/presentation/theme/theme.dart';
import 'riverpod/login_provider.dart';
import 'widgets/custom_passwords.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController login = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(loginProvider.notifier);
    final state = ref.watch(loginProvider);
    return KeyboardDismisser(
      child: AbsorbPointer(
        absorbing: state.isLoading,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Style.mainBack,
          body: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              children: [
                SafeArea(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 500.r),
                    child: Padding(
                      padding: EdgeInsets.only(left: 50.r, right: 50.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          42.verticalSpace,
                          Row(
                            children: [
                              SvgPicture.asset(
                                Assets.svgLogo,
                                height: 40,
                                width: 40,
                              ),
                              12.horizontalSpace,
                              Expanded(
                                child: Text(
                                  "Kibbi Kiosk",
                                  style: GoogleFonts.inter(
                                      fontSize: 32.sp,
                                      color: Style.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          56.verticalSpace,
                          Text(
                            'Iniciar sesión',
                            style: GoogleFonts.inter(
                                fontSize: 32.sp,
                                color: Style.black,
                                fontWeight: FontWeight.bold),
                          ),
                          36.verticalSpace,
                          Text(
                            'Serial',
                            style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                color: Style.black,
                                fontWeight: FontWeight.w500),
                          ),
                          CustomTextField(
                            hintText: 'Ingresa Serial',
                            onChanged: notifier.setSerial,
                            textController: login,
                            textCapitalization: TextCapitalization.none,
                            isError:
                                state.isLoginError || state.isSerialNotValid,
                            descriptionText: state.isSerialNotValid
                                ? 'Credenciales no válidas'
                                : (state.isLoginError
                                    ? 'Credenciales no válidas'
                                    : null),
                            onFieldSubmitted: (value) => notifier.login(
                              checkYourNetwork: () {
                                AppHelpers.showSnackBar(
                                  context,
                                  'Verifica tu conexión de red',
                                );
                              },
                              unAuthorised: () {
                                AppHelpers.showSnackBar(
                                  context,
                                  'Unautorizado',
                                );
                              },
                              goToMain: () {
                                context.replaceRoute(const MainRoute());
                              },
                            ),
                          ),
                          50.verticalSpace,
                          Text(
                            'Contraseña',
                            style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                color: Style.black,
                                fontWeight: FontWeight.w500),
                          ),
                          CustomTextField(
                            textController: password,
                            hintText: 'Ingresa contraseña',
                            obscure: state.showPassword,
                            onChanged: notifier.setPassword,
                            textCapitalization: TextCapitalization.none,
                            isError:
                                state.isLoginError || state.isPasswordNotValid,
                            descriptionText: state.isPasswordNotValid
                                ? 'La contraseña debe contener al menos 8 caracteres'
                                : (state.isLoginError
                                    ? 'Credenciales no validas'
                                    : null),
                            suffixIcon: IconButton(
                              splashRadius: 25.r,
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
                            onFieldSubmitted: (value) => notifier.login(
                              checkYourNetwork: () {
                                AppHelpers.showSnackBar(
                                  context,
                                  'Verifica tu conexión de red',
                                );
                              },
                              unAuthorised: () {
                                AppHelpers.showSnackBar(
                                  context,
                                  'Correo electrónico no verificado aún',
                                );
                              },
                              goToMain: () {
                                context.replaceRoute(const MainRoute());
                              },
                            ),
                          ),
                          100.verticalSpace,
                          LoginButton(
                            isLoading: state.isLoading,
                            title: 'Iniciar sesión',
                            titleColor: Style.white,
                            onPressed: () => notifier.login(
                              checkYourNetwork: () {
                                AppHelpers.showSnackBar(
                                  context,
                                  'Verifica tu conexión de red',
                                );
                              },
                              unAuthorised: () {
                                AppHelpers.showSnackBar(
                                  context,
                                  'Correo electrónico no verificado aún',
                                );
                              },
                              goToMain: () {
                                debugPrint('==> Navegar a la página principal');
                                context.replaceRoute(const MainRoute());
                              },
                            ),
                          ),
                          const Spacer(),
                          CustomPasswords(
                            onTap: () {
                              login.text = AppConstants.demoKioskLogin;
                              password.text = AppConstants.demoKioskPassword;
                              notifier.setSerial(AppConstants.demoKioskLogin);
                              notifier
                                  .setPassword(AppConstants.demoKioskPassword);
                            },
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Image.asset(
                  Assets.pngManImage,
                  height: double.infinity,
                  fit: BoxFit.cover,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
