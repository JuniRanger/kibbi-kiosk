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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(rightSideProvider.notifier)
        ..fetchBags(null)
        ..fetchCarts(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(rightSideProvider);

    // Asumimos que solo hay una bolsa, la primera de la lista
    final bag = state.bags.isNotEmpty ? state.bags.first : null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (bag != null) ...[
          Container(
            height: 56.r,
            padding: REdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Style.white,
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(
                  FlutterRemix.shopping_bag_3_fill,
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
          6.verticalSpace,
          Expanded(
            child: PageViewItem(bag: bag),
          ),
        ] else ...[
          const Center(
            child: Text("No hay bolsas disponibles"),
          ),
        ],
      ],
    );
  }
}
