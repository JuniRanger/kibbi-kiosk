import 'package:kibbi_kiosk/src/models/models.dart';
import 'package:kibbi_kiosk/src/presentation/components/components.dart';
import 'package:kibbi_kiosk/src/presentation/theme/theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kibbi_kiosk/src/core/utils/utils.dart';

import '../right_side/riverpod/right_side_provider.dart';
import 'riverpod/add_product_provider.dart';

class AddProductDialog extends ConsumerStatefulWidget {
  final ProductData? product;

  const AddProductDialog({super.key, required this.product});

  @override
  ConsumerState<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends ConsumerState<AddProductDialog> {
  static const int maxCartProducts = 30; // Maximum allowed products in the cart

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(addProductProvider.notifier).setProduct(widget.product);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addProductProvider);
    final notifier = ref.read(addProductProvider.notifier);
    final rightSideNotifier = ref.read(rightSideProvider.notifier);

    final num price = widget.product?.salePrice ?? 0.0;
    final String priceFormatted = NumberFormat.currency(
      symbol: '\$',
    ).format(price);

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
                            url: widget.product?.imageUrl,
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
                                  onPressed: () =>
                                      notifier.decreaseStockCount(),
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
                                  onPressed: () =>
                                      notifier.increaseStockCount(),
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
                                widget.product?.name ?? '',
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
                                '${widget.product?.description}',
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
                                color:
                                    Style.black.withAlpha((0.2 * 255).toInt()),
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
                          title: 'Agregar',
                          titleColor: Style.white,
                          onPressed: () {
                            final totalQuantity = rightSideNotifier
                                    .state.bag?.bagProducts
                                    ?.fold<int>(
                                        0,
                                        (sum, product) =>
                                            sum + (product.quantity ?? 0)) ??
                                0;

                            if (totalQuantity + state.stockCount >
                                maxCartProducts) {
                              AppHelpers.showAlertDialog(
                                context: context,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Límite alcanzado',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
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

                            notifier.addProductToBag(
                              context,
                              rightSideNotifier,
                            );
                            context.router.maybePop();
                          },
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Precio:',
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Style.black,
                              letterSpacing: -14 * 0.02,
                            ),
                          ),
                          4.verticalSpace,
                          Text(
                            priceFormatted,
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
                  10.verticalSpace,
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: const Icon(FlutterRemix.close_line),
              onPressed: () {
                context.router.maybePop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
