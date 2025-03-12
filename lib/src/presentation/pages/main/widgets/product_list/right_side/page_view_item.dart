import 'package:kibbi_kiosk/generated/assets.dart';
import 'package:kibbi_kiosk/src/core/constants/constants.dart';
import 'package:kibbi_kiosk/src/core/utils/utils.dart';
import 'package:kibbi_kiosk/src/models/models.dart';
import 'package:kibbi_kiosk/src/presentation/components/components.dart';
import 'package:kibbi_kiosk/src/presentation/theme/theme.dart';
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
import 'package:kibbi_kiosk/src/presentation/pages/main/widgets/product_list/riverpod/shop_provider.dart';

class PageViewItem extends ConsumerStatefulWidget {
  final BagData? bag;

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
    debugPrint('PageViewItem initState - bag: ${widget.bag}');
    debugPrint(
        'PageViewItem initState - bag products: ${widget.bag?.bagProducts}');

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
    final products = ref.watch(shopProvider).products;

    // Verificación directa de bag para debugging
    debugPrint('PageViewItem build - bag: ${widget.bag}');
    debugPrint('PageViewItem build - bag products: ${widget.bag?.bagProducts}');
    debugPrint(
        'PageViewItem build - bag products length: ${widget.bag?.bagProducts?.length}');

    // Usar directamente los datos de bag
    final hasBagProducts =
        widget.bag?.bagProducts != null && widget.bag!.bagProducts!.isNotEmpty;

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
                              itemCount: widget.bag?.bagProducts?.length ?? 0,
                              itemBuilder: (context, index) {
                                final bagProduct =
                                    widget.bag?.bagProducts?[index];
                                final productName =
                                    bagProduct?.getProductName(products) ??
                                        "Producto ${index + 1}";
                                final productSalePrice =
                                    bagProduct?.getProductSalePrice(products) ??
                                        0.0;
                                // Crear un ProductData temporal basado en BagProductData
                                final product = ProductData(
                                  id: bagProduct?.productId,
                                  quantity: bagProduct?.quantity,
                                  // Añadir más campos según sea necesario, aquí solo ejemplo
                                  name: productName,
                                  salePrice: productSalePrice,
                                );

                                return CartOrderItem(
                                  symbol: '\$',
                                  add: () {
                                    notifier.increaseProductCount(
                                        productIndex: index);
                                  },
                                  remove: () {
                                    notifier.decreaseProductCount(
                                        productIndex: index, context: context);
                                  },
                                  cart: product,
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
                              'No hay productos en el carrito',
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
    // Calcular subtotal basado en los productos en la bolsa
    // Esto es un placeholder, necesitarás ajustarlo con los precios reales
    double subtotal = 0;
    // Si tienes precios en los productos de la bolsa, calcular aquí

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
                title: 'Subtotal',
                price: state.paginateResponse?.price ?? subtotal,
                symbol: '\$',
              ),
              // Otros ítems de precio comentados...
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
                    ).format(state.paginateResponse?.totalPrice ?? subtotal),
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
                    title, // Cambiado de 'Titulo' a title para usar el parámetro correcto
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
