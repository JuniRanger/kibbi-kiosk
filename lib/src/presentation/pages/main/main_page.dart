// ignore_for_file: deprecated_member_use
import 'package:kiosk/src/core/routes/app_router.dart';
import 'package:kiosk/src/presentation/components/custom_clock/custom_clock.dart';
import 'package:kiosk/src/presentation/components/custom_scaffold.dart';
import 'riverpod/main_notifier.dart';
import 'riverpod/main_state.dart';
import 'widgets/language/languages_modal.dart';
import 'widgets/language/riverpod/provider/languages_provider.dart';
import 'widgets/menu/menu.dart';
import 'widgets/product_list/post_page.dart';
import 'widgets/product_list/right_side/riverpod/right_side_provider.dart';
import 'widgets/product_list/riverpod/shop_notifier.dart';
import 'widgets/product_list/riverpod/shop_provider.dart';
import 'package:kiosk/src/presentation/theme/theme/theme_warpper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';
import 'package:kiosk/generated/assets.dart';
import 'package:kiosk/src/core/constants/constants.dart';
import 'package:kiosk/src/core/utils/utils.dart';
import 'package:kiosk/src/presentation/components/components.dart';
import 'package:kiosk/src/presentation/theme/theme.dart';
import 'riverpod/main_provider.dart';
import 'widgets/shop_list/shop_list_page.dart';

@RoutePage()
class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage>
    with SingleTickerProviderStateMixin {
  late Widget currentPage = const PostPage(); // O la pantalla que prefieras

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Siempre mantén la vista en productos (index 1)
      ref.read(mainProvider.notifier).changeIndex(1);

      if (LocalStorage.getShop() != null) {
        ref
            .refresh(shopProvider.notifier)
            .setShop(shop: LocalStorage.getShop(), context: context);
      } else {
        ref.read(mainProvider.notifier).fetchShops(context: context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mainProvider);
    final notifier = ref.read(mainProvider.notifier);
    final shopNotifier = ref.read(shopProvider.notifier);

    return SafeArea(
      child: CustomScaffold(
        extendBody: true,
        appBar: (colors) => customAppBar(notifier, state, shopNotifier),
        backgroundColor: Style.mainBack,
        body: (c) => Directionality(
          textDirection:
              LocalStorage.getLangLtr() ? TextDirection.ltr : TextDirection.rtl,
          child: KeyboardDismisser(
            child: state.selectIndex == 0
                ? const ShopListPage()
                : const PostPage(),
          ),
        ),
      ),
    );
  }

  AppBar customAppBar(
    MainNotifier notifier,
    MainState state,
    ShopNotifier shopNotifier,
  ) {
    return AppBar(
      backgroundColor: Style.white,
      automaticallyImplyLeading: false,
      elevation: 0.5,
      title: IntrinsicHeight(
        child: ThemeWrapper(builder: (colors, controller) {
          return Row(
            children: [
              16.horizontalSpace,
              SvgPicture.asset(Assets.svgLogo),
              12.horizontalSpace,
              Text(
                AppHelpers.getAppName() ?? "Kibbi Kiosk",
                style: GoogleFonts.inter(
                    color: Style.black, fontWeight: FontWeight.bold),
              ),
              const VerticalDivider(),
              30.horizontalSpace,
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      FlutterRemix.search_2_line,
                      size: 20.r,
                      color: Style.black,
                    ),
                    17.horizontalSpace,
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        onChanged: (value) {
                          if (state.selectIndex == 0) {
                            notifier.setQuery(context, value.trim());
                          } else {
                            shopNotifier.setProductsQuery(
                                context, value.trim());
                          }
                        },
                        cursorColor: Style.black,
                        cursorWidth: 1.r,
                        decoration: InputDecoration(
                          hintText: AppHelpers.getTranslation(
                            state.selectIndex == 0
                                ? TrKeys.searchShop
                                : TrKeys.searchProducts,
                          ),
                          hintStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                            color: Style.searchHint.withOpacity(0.3),
                            letterSpacing: -14 * 0.02,
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const VerticalDivider(),
              const VerticalDivider(),
              GestureDetector(
                  onDoubleTap: () {
                    AppHelpers.showCustomDialog(
                      context: context,
                      title: TrKeys.KioskOptions,
                      child: const Menu(),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      FlutterRemix.settings_5_line,
                      color: Style.black,
                    ),
                  )),
            ],
          );
        }),
      ),
    );
  }

  Container bottomLeftNavigationBar(MainState state) {
    return Container(
      height: double.infinity,
      width: 90.w,
      color: Style.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          24.verticalSpace,
          Container(
            decoration: BoxDecoration(
                color:
                    state.selectIndex == 0 ? Style.primary : Style.transparent,
                borderRadius: BorderRadius.circular(10.r)),
            child: IconButton(
                onPressed: () {
                  ref.read(mainProvider.notifier).changeIndex(0);
                },
                icon: Icon(
                  state.selectIndex == 0
                      ? FlutterRemix.home_smile_fill
                      : FlutterRemix.home_smile_line,
                  color: state.selectIndex == 0 ? Style.white : Style.icon,
                )),
          ),
          28.verticalSpace,
          Container(
            decoration: BoxDecoration(
                color:
                    state.selectIndex == 1 ? Style.primary : Style.transparent,
                borderRadius: BorderRadius.circular(10.r)),
            child: IconButton(
              onPressed: () {
                ref.read(mainProvider.notifier).changeIndex(1);
              },
              icon: SvgPicture.asset(
                state.selectIndex == 1
                    ? Assets.svgSelectTable
                    : Assets.svgTable,
              ),
            ),
          ),
          28.verticalSpace,
        ],
      ),
    );
  }
}
