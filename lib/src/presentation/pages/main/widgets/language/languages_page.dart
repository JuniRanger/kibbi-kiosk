import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kiosk/generated/assets.dart';
import 'package:kiosk/src/core/constants/constants.dart';
import 'package:kiosk/src/core/routes/app_router.dart';
import 'package:kiosk/src/core/utils/app_helpers.dart';
import 'package:kiosk/src/core/utils/utils.dart';
import 'package:kiosk/src/presentation/components/components.dart';
import 'package:kiosk/src/presentation/theme/theme.dart';
import 'package:kiosk/src/presentation/theme/theme/theme_warpper.dart';

import 'riverpod/provider/languages_provider.dart';
import 'widgets/language_item.dart';

@RoutePage()
class LanguagesPage extends ConsumerStatefulWidget {
  const LanguagesPage({super.key});

  @override
  ConsumerState<LanguagesPage> createState() => _LanguagesPageState();
}

class _LanguagesPageState extends ConsumerState<LanguagesPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(languagesProvider.notifier).getLanguages(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(languagesProvider.notifier);
    final state = ref.watch(languagesProvider);
    return ThemeWrapper(builder: (colors, controller) {
      return Scaffold(
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
                              child: AutoSizeText(
                                AppHelpers.getAppName() ?? "foodyman",
                                style: GoogleFonts.inter(
                                    fontSize: 32.sp,
                                    color: Style.black,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                minFontSize: 24,
                              ),
                            ),
                          ],
                        ),
                        56.verticalSpace,
                        Text(
                          AppHelpers.getTranslation(TrKeys.startSelectLanguage),
                          style: GoogleFonts.inter(
                              fontSize: 28.sp,
                              color: Style.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        36.verticalSpace,
                        state.languages.isEmpty && state.isLoading
                            ? const Padding(
                                padding: EdgeInsets.symmetric(vertical: 24),
                                child: Loading(),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                padding: REdgeInsets.only(top: 24, bottom: 24),
                                itemCount: state.languages.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      state.languages.length > 6 ? 2 : 1,
                                  mainAxisSpacing: 12.r,
                                  crossAxisSpacing: 16.r,
                                  mainAxisExtent: 64.r,
                                ),
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return LanguageItem(
                                    onTap: () {
                                      notifier.change(index, afterUpdate: () {
                                        controller.toggle();
                                        controller.toggle();
                                      });
                                    },
                                    lang: state.languages[index],
                                  );
                                },
                              ),
                        const Spacer(),
                        state.languages.isEmpty && state.isLoading
                            ? const SizedBox.shrink()
                            : LoginButton(
                                title: AppHelpers.getTranslation(TrKeys.next),
                                onPressed: () {
                                  context.pushRoute(const MainRoute());
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
      );
    });
  }
}
