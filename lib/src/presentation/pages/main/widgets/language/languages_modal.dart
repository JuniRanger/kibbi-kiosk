import 'package:flutter_remix/flutter_remix.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kiosk/src/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiosk/src/presentation/theme/theme.dart';
import 'package:kiosk/src/core/utils/utils.dart';
import 'package:kiosk/src/presentation/components/loading.dart';
import 'riverpod/provider/languages_provider.dart';
import 'widgets/select_item.dart';

class LanguagesModal extends ConsumerWidget {
  final VoidCallback? afterUpdate;

  const LanguagesModal({super.key, this.afterUpdate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(languagesProvider.notifier);
    final state = ref.watch(languagesProvider);
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: REdgeInsets.only(left: 15, right: 15, top: 15),
            child: Row(
              children: [
                Text(
                  AppHelpers.getTranslation(TrKeys.language),
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Style.black,
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(FlutterRemix.close_fill))
              ],
            ),
          ),
          state.isLoading
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Loading(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  padding: REdgeInsets.only(top: 24, bottom: 24),
                  itemCount: state.languages.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return SelectItem(
                      onTap: () {
                        notifier.change(index, afterUpdate: afterUpdate);
                        Navigator.pop(context);
                      },
                      isActive: LocalStorage.getLanguage()?.locale ==
                          state.languages[index].locale,
                      title: state.languages[index].title ?? '',
                    );
                  },
                ),
          32.verticalSpace,
        ],
      ),
    );
  }
}
