import 'package:kiosk/src/core/constants/constants.dart';
import 'package:kiosk/src/core/utils/utils.dart';
import 'package:kiosk/src/presentation/components/components.dart';
import 'package:kiosk/src/presentation/pages/main/widgets/product_list/riverpod/shop_provider.dart';
import 'package:kiosk/src/presentation/theme/theme.dart';
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
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(rightSideProvider.notifier)
        ..fetchBags(ref.read(shopProvider).selectedShop?.id)
        ..fetchCurrencies(
          checkYourNetwork: () {
            AppHelpers.showSnackBar(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        )
        ..fetchPayments(
          checkYourNetwork: () {
            AppHelpers.showSnackBar(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        )
        ..fetchCarts(context: context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(rightSideProvider);
    final notifier = ref.read(rightSideProvider.notifier);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 56.r,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: state.bags.length,
                  itemBuilder: (context, index) {
                    final bag = state.bags[index];
                    final bool isSelected = state.selectedBagIndex == index;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(10.r),
                          onTap: () {
                            notifier.setSelectedBagIndex(index);
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                          child: Container(
                            height: 56.r,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color:
                                  isSelected ? Style.white : Style.transparent,
                            ),
                            padding: REdgeInsets.only(
                              left: 20,
                              right: index == 0 ? 20 : 4,
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  FlutterRemix.shopping_bag_3_fill,
                                  size: 20.r,
                                  color: isSelected
                                      ? Style.black
                                      : Style.unselectedTab,
                                ),
                                8.horizontalSpace,
                                Text(
                                  '${AppHelpers.getTranslation(TrKeys.bag)} - ${(bag.index ?? 0) + 1}',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: isSelected
                                        ? Style.black
                                        : Style.unselectedTab,
                                    letterSpacing: -14 * 0.02,
                                  ),
                                ),
                                if (index != 0)
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      16.horizontalSpace,
                                      CircleIconButton(
                                        backgroundColor: Style.transparent,
                                        iconData: FlutterRemix.close_line,
                                        iconColor: isSelected
                                            ? Style.black
                                            : Style.unselectedTab,
                                        onTap: () => notifier.removeBag(index),
                                        size: 30,
                                      )
                                    ],
                                  )
                              ],
                            ),
                          ),
                        ),
                        4.horizontalSpace,
                      ],
                    );
                  },
                ),
              ),
            ),
            9.horizontalSpace,
            InkWell(
              onTap: notifier.addANewBag,
              child: AnimationButtonEffect(
                child: Container(
                  width: 52.r,
                  height: 52.r,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Style.white),
                  child: const Center(child: Icon(FlutterRemix.add_line)),
                ),
              ),
            ),
          ],
        ),
        6.verticalSpace,
        Expanded(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: state.bags.map((bag) => PageViewItem(bag: bag)).toList(),
          ),
        )
      ],
    );
  }
}
