import 'package:kiosk/src/core/constants/constants.dart';
import 'package:kiosk/src/core/utils/utils.dart';
import 'package:kiosk/src/models/models.dart';
import 'package:kiosk/src/presentation/components/components.dart';
import 'package:kiosk/src/presentation/theme/theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../right_side/riverpod/right_side_provider.dart';
import 'riverpod/add_product_provider.dart';
import 'widgets/extras/color_extras.dart';
import 'widgets/extras/image_extras.dart';
import 'widgets/extras/text_extras.dart';
import 'widgets/w_ingredient.dart';

class AddProductDialog extends ConsumerStatefulWidget {
  final ProductData? product;

  const AddProductDialog({super.key, required this.product});

  @override
  ConsumerState<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends ConsumerState<AddProductDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(addProductProvider.notifier).setProduct(
            widget.product,
            ref.watch(rightSideProvider).selectedBagIndex,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addProductProvider);
    final rightSideState = ref.watch(rightSideProvider);
    final notifier = ref.read(addProductProvider.notifier);
    final rightSideNotifier = ref.read(rightSideProvider.notifier);
    final List<Stocks> stocks = state.product?.stocks ?? <Stocks>[];
    if (stocks.isEmpty) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Style.white,
          ),
          constraints: BoxConstraints(
            maxHeight: 700.r,
            maxWidth: 600.r,
          ),
          padding: REdgeInsets.symmetric(horizontal: 40, vertical: 50),
          child: Text(
            '${state.product?.translation?.title ?? ''} ${AppHelpers.getTranslation(TrKeys.outOfStock).toLowerCase()}',
          ),
        ),
      );
    }
    final bool hasDiscount = (state.selectedStock?.discount != null &&
        (state.selectedStock?.discount ?? 0) > 0);
    final String price = NumberFormat.currency(
      symbol: LocalStorage.getSelectedCurrency().symbol,
    ).format(hasDiscount
        ? (state.selectedStock?.totalPrice ?? 0)
        : state.selectedStock?.price);
    final lineThroughPrice = NumberFormat.currency(
      symbol: LocalStorage.getSelectedCurrency().symbol,
    ).format(state.selectedStock?.price);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Style.white,
            ),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height / 1.2,
              maxWidth: MediaQuery.sizeOf(context).width / 1.6,
            ),
            padding: REdgeInsets.symmetric(horizontal: 32),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  36.verticalSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonImage(
                            url: widget.product?.img,
                            width: 250,
                            height: 250,
                          ),
                          24.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                border: Border.all(color: Style.icon)),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => notifier.decreaseStockCount(
                                      rightSideState.selectedBagIndex),
                                  icon: const Icon(FlutterRemix.subtract_line),
                                ),
                                13.horizontalSpace,
                                Text(
                                  '${state.stockCount}',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.sp,
                                    color: Style.black,
                                    letterSpacing: -0.4,
                                  ),
                                ),
                                12.horizontalSpace,
                                IconButton(
                                  onPressed: () => notifier.increaseStockCount(
                                      rightSideState.selectedBagIndex),
                                  icon: const Icon(FlutterRemix.add_line),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      32.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: REdgeInsets.only(right: 36),
                              child: Text(
                                widget.product?.translation?.title ?? '',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22.sp,
                                  color: Style.black,
                                  letterSpacing: -0.4,
                                ),
                              ),
                            ),
                            8.verticalSpace,
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 1.6 -
                                  370.w,
                              child: Text(
                                '${widget.product?.translation?.description}',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: Style.icon,
                                  letterSpacing: -0.4,
                                ),
                              ),
                            ),
                            8.verticalSpace,
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 1.6 -
                                  370.w,
                              child: Divider(
                                color: Style.black.withOpacity(0.2),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 1.6 -
                                  370.w,
                              child: ListView.builder(
                                physics: const CustomBouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.typedExtras.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  final TypedExtra typedExtra =
                                      state.typedExtras[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: Style.white,
                                    ),
                                    padding: REdgeInsets.symmetric(vertical: 6),
                                    margin: REdgeInsets.only(bottom: 6),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          typedExtra.title,
                                          style: GoogleFonts.inter(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Style.black,
                                            letterSpacing: -0.4,
                                          ),
                                        ),
                                        8.verticalSpace,
                                        typedExtra.type == ExtrasType.text
                                            ? TextExtras(
                                                uiExtras: typedExtra.uiExtras,
                                                groupIndex:
                                                    typedExtra.groupIndex,
                                                onUpdate: (s) {
                                                  notifier
                                                      .updateSelectedIndexes(
                                                    index:
                                                        typedExtra.groupIndex,
                                                    value: s.index,
                                                    bagIndex: rightSideState
                                                        .selectedBagIndex,
                                                  );
                                                },
                                              )
                                            : typedExtra.type ==
                                                    ExtrasType.color
                                                ? ColorExtras(
                                                    uiExtras:
                                                        typedExtra.uiExtras,
                                                    groupIndex:
                                                        typedExtra.groupIndex,
                                                  )
                                                : typedExtra.type ==
                                                        ExtrasType.image
                                                    ? ImageExtras(
                                                        uiExtras:
                                                            typedExtra.uiExtras,
                                                        groupIndex: typedExtra
                                                            .groupIndex,
                                                      )
                                                    : const SizedBox(),
                                        8.verticalSpace,
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width /
                                                      1.6 -
                                                  370.w,
                                          child: Divider(
                                            color: Style.black.withOpacity(0.2),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            8.verticalSpace,
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 1.6 -
                                  370.w,
                              child: WIngredientScreen(
                                list: state.selectedStock?.addons ?? [],
                                onChange: (int value) {
                                  notifier.updateIngredient(context, value);
                                },
                                add: (int value) {
                                  notifier.addIngredient(context, value);
                                },
                                remove: (int value) {
                                  notifier.removeIngredient(context, value);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  const Divider(),
                  10.verticalSpace,
                  Row(
                    children: [
                      SizedBox(
                        width: 120.w,
                        child: LoginButton(
                          isLoading: state.isLoading,
                          title: AppHelpers.getTranslation(TrKeys.add),
                          onPressed: () {
                            notifier.addProductToBag(
                              context,
                              rightSideState.selectedBagIndex,
                              rightSideNotifier,
                            );
                            context.popRoute();
                          },
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${AppHelpers.getTranslation(TrKeys.price)}:',
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Style.black,
                              letterSpacing: -14 * 0.02,
                            ),
                          ),
                          4.verticalSpace,
                          Row(
                            children: [
                              if (hasDiscount)
                                Row(
                                  children: [
                                    Text(
                                      lineThroughPrice,
                                      style: GoogleFonts.inter(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Style.discountText,
                                        letterSpacing: -14 * 0.02,
                                      ),
                                    ),
                                    10.horizontalSpace,
                                  ],
                                ),
                              Text(
                                price,
                                style: GoogleFonts.inter(
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Style.black,
                                  letterSpacing: -14 * 0.02,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  20.verticalSpace,
                ],
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 16,
            child: CircleIconButton(
              size: 60,
              backgroundColor: Style.transparent,
              iconData: FlutterRemix.close_circle_line,
              iconColor: Style.black,
              onTap: context.popRoute,
            ),
          ),

        ],
      ),
    );
  }
}
