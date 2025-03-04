import 'package:kiosk/generated/assets.dart';
import 'package:kiosk/src/presentation/components/category_tab_bar_item.dart';
import 'package:kiosk/src/presentation/components/custom_refresher.dart';
import 'package:kiosk/src/presentation/pages/main/widgets/product_list/riverpod/shop_provider.dart';
import 'package:kiosk/src/presentation/theme/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';

class CategoriesTab extends ConsumerWidget {
  const CategoriesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(shopProvider.notifier);
    final state = ref.watch(shopProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                    color: Style.white,
                    borderRadius: BorderRadius.circular(10.r)),
                height: 56.h,
                child: state.categories.isEmpty
                    ? const SizedBox.shrink()
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categories.length + 2,
                        itemBuilder: (context, index) {
                          return index == 0
                              ? Padding(
                                  padding: EdgeInsets.only(right: 6.r),
                                  child: SvgPicture.asset(Assets.svgMenu),
                                )
                              : index == 1
                                  ? CategoryTabBarItem(
                                      isActive:
                                          state.selectedCategory?.id == null,
                                      onTap: () {
                                        notifier.setSelectedCategory(
                                            context, -1);
                                      },
                                      title:
                                          AppHelpers.getTranslation(TrKeys.all),
                                    )
                                  : CategoryTabBarItem(
                                      isActive:
                                          state.categories[index - 2].id ==
                                              state.selectedCategory?.id,
                                      onTap: () {
                                        notifier.setSelectedCategory(
                                            context, index - 2);
                                      },
                                      title: state.categories[index - 2]
                                          .name,
                                    );
                        }),
              ),
            ),
            12.horizontalSpace,
            CustomRefresher(
              onTap: () {
                notifier.fetchProducts(context: context, isRefresh: true);
              },
              isLoading: state.isProductsLoading,
            ),
          ],
        )
      ],
    );
  }
}
