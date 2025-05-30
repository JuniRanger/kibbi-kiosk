import 'package:kibbi_kiosk/generated/assets.dart';
import 'package:kibbi_kiosk/src/core/constants/constants.dart';
import 'package:kibbi_kiosk/src/core/utils/product_service.dart';
import 'package:kibbi_kiosk/src/models/models.dart';
import 'package:kibbi_kiosk/src/presentation/components/components.dart';
import 'package:kibbi_kiosk/src/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kibbi_kiosk/src/core/utils/app_helpers.dart';

import 'note_dialog.dart';
import 'order_information.dart';
import 'riverpod/right_side_provider.dart';
import 'riverpod/right_side_state.dart';
import 'package:kibbi_kiosk/src/presentation/pages/main/widgets/product_list/riverpod/shop_provider.dart';

class PageViewItem extends ConsumerStatefulWidget {
  final BagData? bag;

  const PageViewItem({super.key, required this.bag});

  @override
  ConsumerState<PageViewItem> createState() => _PageViewItemState();
}

class _PageViewItemState extends ConsumerState<PageViewItem> {
  late TextEditingController coupon;

  static const int maxCartProducts = 30; // Maximum allowed products in the cart
  static const int maxProductQuantity =
      30; // Maximum allowed quantity per product

  @override
  void initState() {
    super.initState();
    coupon = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(rightSideProvider.notifier)
          .setInitialBagData(context, widget.bag ?? BagData());
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
    final shopState = ref.watch(shopProvider);
    final productsService = ProductService(shopState);

    final hasBagProducts =
        state.bag?.bagProducts != null && state.bag!.bagProducts!.isNotEmpty;

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
                  height: MediaQuery.of(context).size.height * 0.75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Style.white,
                  ),
                  child: hasBagProducts
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
                                    'Productos',
                                    style: GoogleFonts.inter(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      notifier.clearBag();
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
                            Expanded(
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: state.bag?.bagProducts?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final bagProduct =
                                      state.bag?.bagProducts?[index];
                                  final productName =
                                      productsService.getProductName(
                                          bagProduct?.productId ?? '');
                                  final productSalePrice =
                                      productsService.getProductSalePrice(
                                          bagProduct?.productId ?? '');

                                  final product = ProductData(
                                    id: bagProduct?.productId,
                                    quantity: bagProduct?.quantity,
                                    name: productName,
                                    salePrice: productSalePrice,
                                  );

                                  return CartOrderItem(
                                    symbol: '\$',
                                    add: () {
                                      final totalQuantity =
                                          state.bag?.bagProducts?.fold<int>(
                                                  0,
                                                  (sum, product) =>
                                                      sum +
                                                      (product.quantity ??
                                                          0)) ??
                                              0;

                                      if (totalQuantity >= maxCartProducts) {
                                        AppHelpers.showAlertDialog(
                                          context: context,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text(
                                                'Límite alcanzado',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(height: 10),
                                              const Text(
                                                  'Solo puedes tener 30 productos en el carrito.'),
                                              const SizedBox(height: 20),
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: const Text('Aceptar'),
                                              ),
                                            ],
                                          ),
                                        );

                                        return;
                                      }

                                      if ((bagProduct?.quantity ?? 0) >=
                                          maxProductQuantity) {
                                        AppHelpers.showAlertDialog(
                                          context: context,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text(
                                                'Límite alcanzado',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(height: 10),
                                              const Text(
                                                  'Solo puedes tener 30 productos en el carrito.'),
                                              const SizedBox(height: 20),
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: const Text('Aceptar'),
                                              ),
                                            ],
                                          ),
                                        );

                                        return;
                                      }

                                      notifier.increaseProductCount(
                                          productIndex: index,
                                          context: context);
                                    },
                                    remove: () {
                                      notifier.decreaseProductCount(
                                          productIndex: index,
                                          context: context);
                                    },
                                    cart: product,
                                    delete: () {
                                      notifier.deleteProductCount(
                                          productIndex: index);
                                    },
                                  );
                                },
                              ),
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
                                        'Añadir',
                                        style: GoogleFonts.inter(
                                            color: Style.black,
                                            fontSize: 14.sp),
                                      ),
                                      const Spacer(),
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
                                              'Nota',
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
                      : Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
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
                                'No hay productos en el carrito',
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -14 * 0.02,
                                  color: Style.black,
                                ),
                              ),
                            ],
                          ),
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
    num subtotal = 0.0;
    subtotal = state.bag?.cartTotal ?? 0.0;

    return Column(
      children: [
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
                    'Precio total',
                    style: GoogleFonts.inter(
                      color: Style.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.4,
                    ),
                  ),
                  Text(
                    NumberFormat.currency(
                      symbol: '\$',
                    ).format(subtotal),
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
                title: 'Ordenar',
                titleColor: Style.white,
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
}
