import 'package:kiosk/src/core/constants/constants.dart';
import 'package:kiosk/src/core/utils/utils.dart';
import 'package:kiosk/src/presentation/components/buttons/has_more_button.dart';
import 'package:kiosk/src/presentation/pages/main/riverpod/main_provider.dart';
import 'package:kiosk/src/presentation/pages/main/widgets/product_list/riverpod/shop_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'widgets/all_shop_two_shimmer.dart';
import 'widgets/market_two_item.dart';
import 'widgets/title_icon.dart';

class ShopListPage extends ConsumerStatefulWidget {
  const ShopListPage({super.key});

  @override
  ConsumerState<ShopListPage> createState() => _ShopListPageState();
}

class _ShopListPageState extends ConsumerState<ShopListPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mainProvider);
    final notifier = ref.watch(mainProvider.notifier);
    return SingleChildScrollView(
      child: Column(
        children: [
          12.verticalSpace,
          TitleAndIcon(
            title: AppHelpers.getTranslation(TrKeys.allRestaurants),
          ),
          state.isShopsLoading
              ? const AllShopTwoShimmer()
              : Column(
                  children: [
                    12.verticalSpace,
                    state.shops.isNotEmpty
                        ? AnimationLimiter(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisExtent: 280.r,
                                crossAxisSpacing: 8.r,
                                mainAxisSpacing: 8.r,
                              ),
                              padding: REdgeInsets.symmetric(horizontal: 16),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: state.shops.length,
                              itemBuilder: (context, index) =>
                                  AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: MarketTwoItem(
                                      shop: state.shops[index],
                                      isSimpleShop: true,
                                      onTap: () {
                                        ref
                                            .refresh(shopProvider.notifier);
                                            // .setShop(
                                            //     shop: state.shops[index],
                                            //     context: context);
                                        ref
                                            .read(mainProvider.notifier)
                                            .changeIndex(1);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SvgPicture.asset(
                            "assets/svg/empty.svg",
                            height: 100.h,
                          ),
                    16.verticalSpace,
                    state.isMoreShopsLoading
                        ? const AllShopTwoShimmer()
                        : Padding(
                            padding: REdgeInsets.symmetric(horizontal: 16),
                            child: HasMoreButton(
                                hasMore: state.hasMore,
                                onViewMore: () {
                                }),
                          ),
                    16.verticalSpace,
                  ],
                ),
        ],
      ),
    );
  }
}
