import 'package:kibbi_kiosk/generated/assets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../components/components.dart';
import '../../../../theme/theme.dart';
// import 'add_product/add_product_dialog.dart';
import 'riverpod/shop_provider.dart';

class ProductsList extends ConsumerWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(shopProvider);
    final notifier = ref.read(shopProvider.notifier);
    
    return state.isProductsLoading
        ? const ProductGridListShimmer()
        : state.products.isNotEmpty
            ? ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad,
                }),
                child: ListView(
                  shrinkWrap: false,
                  children: [
                    AnimationLimiter(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: state.products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 200 / 300,
                          mainAxisSpacing: 10.r,
                          crossAxisSpacing: 10.r,
                          crossAxisCount: 4,
                        ),
                        padding: REdgeInsets.only(top: 8, bottom: 10),
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return AnimationConfiguration.staggeredGrid(
                            columnCount: state.products.length,
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: ScaleAnimation(
                              scale: 0.5,
                              child: FadeInAnimation(
                                child: ProductGridItem(
                                  product: product,
                                  onTap: () {
                                    // Aquí podrías mostrar más detalles del producto si lo deseas.
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    15.verticalSpace,
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.only(left: 64.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    170.verticalSpace,
                    Container(
                      width: 142.r,
                      height: 142.r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Style.white,
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        Assets.pngNoProducts,
                        width: 87.r,
                        height: 60.r,
                        fit: BoxFit.cover,
                      ),
                    ),
                    14.verticalSpace,
                    Text(
                      'No hay productos disponibles',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -14 * 0.02,
                        color: Style.black,
                      ),
                    ),
                  ],
                ),
              );
  }
}