import 'package:kibbi_kiosk/generated/assets.dart';
import 'package:kibbi_kiosk/src/core/constants/constants.dart';
import 'package:kibbi_kiosk/src/core/utils/utils.dart';
import 'package:kibbi_kiosk/src/presentation/components/components.dart';
import 'package:kibbi_kiosk/src/presentation/pages/main/widgets/product_list/riverpod/shop_provider.dart';
import 'package:kibbi_kiosk/src/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'page_view_item.dart';
import 'riverpod/right_side_provider.dart';

class RightSide extends ConsumerStatefulWidget {
  const RightSide({super.key});

  @override
  ConsumerState<RightSide> createState() => _RightSideState();
}

class _RightSideState extends ConsumerState<RightSide> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.read(rightSideProvider.notifier).fetchCart();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(rightSideProvider);
    final notifier = ref.read(rightSideProvider.notifier);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 56.r,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10.r),
                  onTap: () {
                    // Handle cart item tap if needed
                  },
                  child: Container(
                    height: 56.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Style.white,
                    ),
                    padding: REdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FlutterRemix.shopping_cart_fill,
                          size: 20.r,
                          color: Style.black,
                        ),
                        8.horizontalSpace,
                        Text(
                          'Carrito',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: Style.black,
                            letterSpacing: -14 * 0.02,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            9.horizontalSpace,
            InkWell(
              onTap: () {
                // notifier.resetCart();
              },
              child: AnimationButtonEffect(
                child: Container(
                  width: 52.r,
                  height: 52.r,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Style.white),
                  child: const Center(child: Icon(FlutterRemix.refresh_line)),
                ),
              ),
            ),
          ],
        ),
        6.verticalSpace,
        Expanded(
          child: Container(
            width: double.infinity,
            height: 200.r, // Adjust the height as needed
            decoration: BoxDecoration(
              color: Style.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Assets.pngNoProducts),
                  10.verticalSpace,
                  Text(
                    'No hay productos en el carrito',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Style.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
