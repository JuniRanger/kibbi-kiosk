import 'package:kiosk/src/models/models.dart';
import 'package:kiosk/src/presentation/components/components.dart';
import 'package:kiosk/src/presentation/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../right_side/riverpod/right_side_provider.dart';
import '../../riverpod/add_product_provider.dart';

class ImageExtras extends ConsumerWidget {
  final int groupIndex;
  final List<UiExtra> uiExtras;

  const ImageExtras({
    super.key,
    required this.groupIndex,
    required this.uiExtras,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(addProductProvider.notifier);
    final rightSideState = ref.watch(rightSideProvider);
    return Wrap(
      spacing: 8.r,
      runSpacing: 10.r,
      children: uiExtras
          .map(
            (uiExtra) => Material(
              borderRadius: BorderRadius.circular(21.r),
              child: InkWell(
                borderRadius: BorderRadius.circular(21.r),
                onTap: () {
                  if (uiExtra.isSelected) {
                    return;
                  }
                  notifier.updateSelectedIndexes(
                    index: groupIndex,
                    value: uiExtra.index,
                    bagIndex: rightSideState.selectedBagIndex,
                  );
                },
                child: Container(
                  width: 42.r,
                  height: 42.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21.r),
                  ),
                  child: Stack(
                    children: [
                      CommonImage(
                        url: uiExtra.value,
                        width: 42,
                        height: 42,
                        radius: 21,
                      ),
                      if (uiExtra.isSelected)
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 22.r,
                            height: 22.r,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11.r),
                              color: Style.primary,
                              border: Border.all(
                                color: Style.white,
                                width: 8.r,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
