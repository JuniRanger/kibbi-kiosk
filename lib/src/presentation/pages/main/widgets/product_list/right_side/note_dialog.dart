import 'package:kibbi_kiosk/src/presentation/components/components.dart';
import 'package:kibbi_kiosk/src/presentation/theme/theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'riverpod/right_side_provider.dart';

class NoteDialog extends ConsumerStatefulWidget {
  const NoteDialog({super.key});

  @override
  ConsumerState<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends ConsumerState<NoteDialog> {
  late TextEditingController controller;
  int charCount = 0;

  @override
  void initState() {
    controller = TextEditingController();
    controller.addListener(() {
      setState(() {
        charCount = controller.text.length;
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    controller.text = ref.watch(rightSideProvider).comment;
    charCount = controller.text.length;
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    controller.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      height: 260.w,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Añadir nota',
            style:
                GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 22.r),
          ),
          24.verticalSpace,
          OutlinedBorderTextField(
            textController: controller,
            label: 'Nota',
            maxLength: 30, // Limita el texto a 30 caracteres
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '$charCount/30',
              style: GoogleFonts.inter(
                fontSize: 12.r,
                color: Style.black,
              ),
            ),
          ),
          const Spacer(),
          LoginButton(
            title: 'Guardar',
            titleColor: Style.white,
            onPressed: () {
              ref.read(rightSideProvider.notifier).setNote(controller.text);
              context.router.maybePop();
            },
          )
        ],
      ),
    );
  }
}
