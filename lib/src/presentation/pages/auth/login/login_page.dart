import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kiosk/src/core/routes/app_router.dart';

import 'package:kiosk/generated/assets.dart';
import 'package:kiosk/src/core/constants/constants.dart';
import 'package:kiosk/src/core/utils/utils.dart';
import 'package:kiosk/src/presentation/components/components.dart';
import 'package:kiosk/src/presentation/theme/theme.dart';
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
                                  AppHelpers.getAppName() ?? "Kibbi Kiosk",
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
                            AppHelpers.getTranslation(TrKeys.login),
                            style: GoogleFonts.inter(
                                fontSize: 32.sp,
                                color: Style.black,
                                fontWeight: FontWeight.bold),
                          ),
                          36.verticalSpace,
                          Text(
                            AppHelpers.getTranslation(TrKeys.serial),
                            style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                color: Style.black,
                                fontWeight: FontWeight.w500),
                          ),
                          CustomTextField(
                            hintText:
                                AppHelpers.getTranslation(TrKeys.typeSomething),
                            onChanged: notifier.setSerial,
                            textController: login,
                            textCapitalization: TextCapitalization.none,
                            isError: state.isLoginError || state.isSerialNotValid,
                            descriptionText: state.isSerialNotValid
                                ? AppHelpers.getTranslation(TrKeys.serialIsNotValid)
                                : (state.isLoginError
                                    ? AppHelpers.getTranslation(
                                        TrKeys.loginCredentialsAreNotValid)
                                    : null),
                            onFieldSubmitted: (value) => notifier.login(
                              checkYourNetwork: () {
                                AppHelpers.showSnackBar(
                                  context,
                                  AppHelpers.getTranslation(
                                      TrKeys.checkYourNetworkConnection),
                                );
                              },
                              unAuthorised: () {
                                AppHelpers.showSnackBar(
                                  context,
                                  AppHelpers.getTranslation(
                                      TrKeys.emailNotVerifiedYet),
                                );
                              },
                              goToMain: () {
                                context.replaceRoute(const MainRoute());
                              },
                            ),
                          ),
                          50.verticalSpace,
                          Text(
                            AppHelpers.getTranslation(TrKeys.password),
                            style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                color: Style.black,
                                fontWeight: FontWeight.w500),
                          ),
                          CustomTextField(
                            textController: password,
                            hintText:
                                AppHelpers.getTranslation(TrKeys.typeSomething),
                            obscure: state.showPassword,
                            // label: AppHelpers.getTranslation(TrKeys.password),
                            onChanged: notifier.setPassword,
                            textCapitalization: TextCapitalization.none,
                            isError:
                                state.isLoginError || state.isPasswordNotValid,
                            descriptionText: state.isPasswordNotValid
                                ? AppHelpers.getTranslation(TrKeys
                                    .passwordShouldContainMinimum8Characters)
                                : (state.isLoginError
                                    ? AppHelpers.getTranslation(
                                        TrKeys.loginCredentialsAreNotValid)
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
                                  AppHelpers.getTranslation(
                                      TrKeys.checkYourNetworkConnection),
                                );
                              },
                              unAuthorised: () {
                                AppHelpers.showSnackBar(
                                  context,
                                  AppHelpers.getTranslation(
                                      TrKeys.emailNotVerifiedYet),
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
                            title: TrKeys.login,
                            onPressed: () => notifier.login(
                              checkYourNetwork: () {
                                AppHelpers.showSnackBar(
                                  context,
                                  AppHelpers.getTranslation(
                                      TrKeys.checkYourNetworkConnection),
                                );
                              },
                              unAuthorised: () {
                                AppHelpers.showSnackBar(
                                  context,
                                  AppHelpers.getTranslation(
                                      TrKeys.emailNotVerifiedYet),
                                );
                              },
                              goToMain: () {
                                debugPrint('==> Navigate to main');
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
