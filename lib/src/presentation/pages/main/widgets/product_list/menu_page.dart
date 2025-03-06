import 'package:kibbi_kiosk/src/presentation/components/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'categories_tab.dart';
import 'products_list.dart';
// import 'right_side/right_side.dart';

class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return CustomScaffold(
      body: (c) =>  Padding(
              padding: REdgeInsets.only(left: 16, right: 16, top: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CategoriesTab(),
                      4.verticalSpace,
                      const Expanded(child: ProductsList()),
                    ],
                  )),
                  16.horizontalSpace,
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 3.2,
                    // child: const RightSide(),
                  ),
                ],
              ),
            ),
    );
  }
}
