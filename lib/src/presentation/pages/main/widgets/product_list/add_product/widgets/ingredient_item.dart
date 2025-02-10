import 'package:kiosk/src/core/utils/local_storage.dart';
import 'package:kiosk/src/models/data/addons_data.dart';
import 'package:kiosk/src/presentation/components/custom_checkbox.dart';
import 'package:kiosk/src/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;

class IngredientItem extends ConsumerWidget {
  final VoidCallback onTap;
  final VoidCallback add;
  final VoidCallback remove;
  final Addons addon;

  const IngredientItem({
    required this.add,
    required this.remove,
    super.key,
    required this.onTap,
    required this.addon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10.r),
        decoration: BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.all(Radius.circular(10.r))),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomCheckbox(
                  isActive: addon.active ?? false,
                  onTap: onTap,
                ),
                10.horizontalSpace,
                (addon.active ?? false)
                    ? Row(
                  children: [
                    InkWell(
                      onTap: remove,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Style.removeButtonColor
                        ),
                        child: Icon(
                          Icons.remove,
                          color: (addon.quantity ?? 1) == 1
                              ? Style.outlineButtonBorder
                              : Style.black,
                        ),
                      ),
                    ),
                    8.horizontalSpace,
                    Text(
                      "${addon.quantity ?? 1}",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                      ),
                    ),
                    8.horizontalSpace,
                    InkWell(
                      onTap: add,
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Style.addButtonColor
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Style.black,
                        ),
                      ),
                    ),
                  ],
                )
                    : const SizedBox.shrink(),
                16.horizontalSpace,
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        addon.product?.translation?.title ?? "",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Style.black,
                        ),
                      ),
                      4.horizontalSpace,
                      Text(
                        "+${intl.NumberFormat.currency(
                          symbol: LocalStorage.getSelectedCurrency()
                              .symbol,
                        ).format(addon.product?.stock?.totalPrice ?? 0)}",
                        style:  GoogleFonts.inter(
                          fontSize: 14,
                          color: Style.hint,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
