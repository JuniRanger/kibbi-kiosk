import 'package:kiosk/generated/assets.dart';
import 'package:kiosk/src/core/constants/constants.dart';
import 'package:kiosk/src/core/utils/utils.dart';
import 'package:kiosk/src/models/models.dart';
import 'package:kiosk/src/presentation/components/components.dart';
import 'package:kiosk/src/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'note_dialog.dart';
import 'order_information.dart';
import 'riverpod/right_side_provider.dart';
import 'riverpod/right_side_state.dart';

class PageViewItem extends ConsumerStatefulWidget {
  final BagData bag;

  const PageViewItem({super.key, required this.bag});

  @override
  ConsumerState<PageViewItem> createState() => _PageViewItemState();
}

class _PageViewItemState extends ConsumerState<PageViewItem> {
  late TextEditingController coupon;

  @override
  void initState() {
    super.initState();
    coupon = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(rightSideProvider.notifier)
          .setInitialBagData(context, widget.bag);
    });
  }

  @override
  void dispose() {
    coupon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(rightSideProvider.notifier);
    final state = ref.watch(rightSideProvider);
    return AbsorbPointer(
      absorbing: state.isPaymentsLoading ||
          state.isBagsLoading ||
          state.isCurrenciesLoading ||
          state.isProductCalculateLoading,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Style.white,
                  ),
                  child: (state.paginateResponse?.stocks?.isNotEmpty ?? false)
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 8.r,
                                right: 24.r,
                                left: 24.r,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppHelpers.getTranslation(TrKeys.products),
                                    style: GoogleFonts.inter(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      notifier.clearBag(context);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(8.r),
                                      child: const Icon(
                                        FlutterRemix.delete_bin_line,
                                        color: Style.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  state.paginateResponse?.stocks?.length ?? 0,
                              itemBuilder: (context, index) {
                                return CartOrderItem(
                                  symbol: widget.bag.selectedCurrency?.symbol,
                                  add: () {
                                    notifier.increaseProductCount(
                                        productIndex: index);
                                  },
                                  remove: () {
                                    notifier.decreaseProductCount(
                                        productIndex: index, context: context);
                                  },
                                  cart:
                                      state.paginateResponse?.stocks?[index] ??
                                          ProductData(),
                                  delete: () {
                                    notifier.deleteProductCount(
                                        productIndex: index);
                                  },
                                );
                              },
                            ),
                            8.verticalSpace,
                            Column(
                              children: [
                                Padding(
                                  padding:
                                      REdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppHelpers.getTranslation(TrKeys.add),
                                        style: GoogleFonts.inter(
                                            color: Style.black,
                                            fontSize: 14.sp),
                                      ),
                                      const Spacer(),
                                      // InkWell(
                                      //   onTap: () {
                                      //     AppHelpers.showAlertDialog(
                                      //         context: context,
                                      //         child: const PromoCodeDialog());
                                      //   },
                                      //   child: AnimationButtonEffect(
                                      //     child: Container(
                                      //       padding: EdgeInsets.symmetric(
                                      //           vertical: 10.r,
                                      //           horizontal: 18.r),
                                      //       decoration: BoxDecoration(
                                      //           color: Style.addButtonColor,
                                      //           borderRadius:
                                      //               BorderRadius.circular(
                                      //                   10.r)),
                                      //       child: Text(
                                      //         AppHelpers.getTranslation(
                                      //             TrKeys.promoCode),
                                      //         style: GoogleFonts.inter(
                                      //             fontSize: 14.sp),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      26.horizontalSpace,
                                      InkWell(
                                        onTap: () {
                                          AppHelpers.showAlertDialog(
                                              context: context,
                                              child: const NoteDialog());
                                        },
                                        child: AnimationButtonEffect(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.r,
                                                horizontal: 18.r),
                                            decoration: BoxDecoration(
                                                color: Style.addButtonColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                            child: Text(
                                              AppHelpers.getTranslation(
                                                  TrKeys.note),
                                              style: GoogleFonts.inter(
                                                  fontSize: 14.sp),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                _price(state),
                              ],
                            ),
                            28.verticalSpace,
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            170.verticalSpace,
                            Container(
                              width: 142.r,
                              height: 142.r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Style.dontHaveAccBtnBack,
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
                              '${AppHelpers.getTranslation(TrKeys.thereAreNoItemsInThe)} ${AppHelpers.getTranslation(TrKeys.bag).toLowerCase()}',
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -14 * 0.02,
                                color: Style.black,
                              ),
                            ),
                            SizedBox(height: 170.r, width: double.infinity),
                          ],
                        ),
                ),
                15.verticalSpace,
              ],
            ),
          ),
          BlurLoadingWidget(
            isLoading: state.isPaymentsLoading ||
                state.isBagsLoading ||
                state.isCurrenciesLoading ||
                state.isProductCalculateLoading,
          ),
        ],
      ),
    );
  }

  Column _price(RightSideState state) {
    return Column(
      children: [
        8.verticalSpace,
        const Divider(),
        8.verticalSpace,
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _priceItem(
                title: TrKeys.subtotal,
                price: state.paginateResponse?.price,
                symbol: widget.bag.selectedCurrency?.symbol,
              ),
              _priceItem(
                title: TrKeys.tax,
                price: state.paginateResponse?.totalTax,
                symbol: widget.bag.selectedCurrency?.symbol,
              ),
              _priceItem(
                title: TrKeys.serviceFee,
                price: state.paginateResponse?.serviceFee,
                symbol: widget.bag.selectedCurrency?.symbol,
              ),
              _priceItem(
                title: TrKeys.discount,
                price: state.paginateResponse?.totalDiscount,
                symbol: widget.bag.selectedCurrency?.symbol,
                isDiscount: true,
              ),
              _priceItem(
                title: TrKeys.promoCode,
                price: state.paginateResponse?.couponPrice,
                symbol: widget.bag.selectedCurrency?.symbol,
                isDiscount: true,
              ),
            ],
          ),
        ),
        8.verticalSpace,
        const Divider(),
        8.verticalSpace,
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppHelpers.getTranslation(TrKeys.totalPrice),
                    style: GoogleFonts.inter(
                      color: Style.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.4,
                    ),
                  ),
                  Text(
                    NumberFormat.currency(
                      symbol: widget.bag.selectedCurrency?.symbol ??
                          LocalStorage.getSelectedCurrency().symbol,
                    ).format(state.paginateResponse?.totalPrice ?? 0),
                    style: GoogleFonts.inter(
                      color: Style.black,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.4,
                    ),
                  ),
                ],
              ),
              24.verticalSpace,
              LoginButton(
                isLoading: state.isButtonLoading,
                title: AppHelpers.getTranslation(TrKeys.order),
                titleColor: Style.black,
                onPressed: () {
                  AppHelpers.showAlertDialog(
                    context: context,
                    child: OrderInformation(),
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  _priceItem({
    required String title,
    required num? price,
    required String? symbol,
    bool isDiscount = false,
  }) {
    return (price ?? 0) != 0
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppHelpers.getTranslation(title),
                    style: GoogleFonts.inter(
                      color: isDiscount ? Style.red : Style.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.4,
                    ),
                  ),
                  Text(
                    (isDiscount ? "-" : '') +
                        AppHelpers.numberFormat(price, symbol: symbol),
                    style: GoogleFonts.inter(
                      color: isDiscount ? Style.red : Style.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.4,
                    ),
                  ),
                ],
              ),
              12.verticalSpace,
            ],
          )
        : const SizedBox.shrink();
  }
}
