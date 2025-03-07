import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kibbi_kiosk/src/models/data/product_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import '../../theme/theme.dart';

class CartOrderItem extends StatelessWidget {
  final OrderProduct? cart;
  final String? symbol;
  final VoidCallback add;
  final VoidCallback remove;
  final VoidCallback delete;
  final bool isActive;

  const CartOrderItem({
    super.key,
    required this.add,
    required this.remove,
    required this.cart,
    required this.delete,
    this.isActive = true,
    required this.symbol,
  });

  @override
  Widget build(BuildContext context) {
    num sumPrice = (cart?.product.salePrice ?? 0) * (cart?.quantity ?? 1); // Calculamos el precio base
    num disSumPrice = sumPrice - (cart?.product.salePrice ?? 0) * (cart?.quantity ?? 1); // Se mantiene como ejemplo, pero puedes personalizarlo según los descuentos

    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.12,
        motion: const ScrollMotion(),
        children: [
          Expanded(
            child: Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Slidable.of(context)?.close();
                    delete.call();
                  },
                  child: Container(
                    width: 50.r,
                    height: 72.r,
                    decoration: BoxDecoration(
                      color: Style.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        bottomLeft: Radius.circular(16.r),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      FlutterRemix.close_fill,
                      color: Style.white,
                      size: 24.r,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      child: Column(
        children: [
          if (isActive && cart == null)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Style.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.r),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                cart?.product.name ?? "",
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  color: Style.black,
                                ),
                              ),
                              8.verticalSpace,
                              Text(
                                cart?.product.description ?? "",
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  color: Style.unselectedTab,
                                ),
                              ),
                              16.verticalSpace,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                            color: Style.primary,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.r),
                                bottomRight: Radius.circular(10.r))),
                        child: Text(
                          "${(cart?.quantity ?? 1).toString()}x",
                          style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: Style.black,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      24.horizontalSpace,
                      GestureDetector(
                        onTap: remove,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Style.removeButtonColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              bottomLeft: Radius.circular(10.r),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 25.w),
                            child: const Icon(
                              Icons.remove,
                              color: Style.black,
                            ),
                          ),
                        ),
                      ),
                      4.horizontalSpace,
                      GestureDetector(
                        onTap: add,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Style.addButtonColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.r),
                              bottomRight: Radius.circular(10.r),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 25.w),
                            child: const Icon(
                              Icons.add,
                              color: Style.black,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Text(
                            intl.NumberFormat.currency(
                              symbol: symbol ?? '\$', // Símbolo de moneda
                            ).format(sumPrice),
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                                color: Style.black),
                          ),
                        ],
                      ),
                      16.horizontalSpace,
                    ],
                  ),
                ],
              ),
            )
          else
            Container(
              margin: EdgeInsets.only(bottom: 8.h),
              padding: EdgeInsets.all(16.r),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Style.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Style.border)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    cart?.product.name ?? "",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Style.black,
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    cart?.product.description ?? "",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Style.unselectedTab,
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    intl.NumberFormat.currency(
                      symbol: symbol ?? '\$', // Símbolo de moneda
                    ).format(sumPrice),
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Style.black,
                    ),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
