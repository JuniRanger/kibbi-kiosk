export 'custom_dropdown.dart';

import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kiosk/src/presentation/pages/main/widgets/product_list/right_side/riverpod/right_side_provider.dart';
import 'package:kiosk/src/presentation/theme/theme.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../models/models.dart';

part 'dropdown_field.dart';
part 'animated_section.dart';
part 'dropdown_overlay.dart';
part 'overlay_builder.dart';

class CustomDropdown extends StatefulWidget {
  final DropDownType dropDownType;
  final String? hintText;
  final String? searchHintText;
  final String? initialValue;
  final int? initialId;
  final Function(String)? onChanged;

  const CustomDropdown({
    super.key,
    required this.dropDownType,
    this.hintText,
    this.searchHintText,
    this.onChanged,
    this.initialValue, this.initialId,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final layerLink = LayerLink();
  late TextEditingController controller;


  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hintText = widget.hintText ?? 'Select value';
    final searchHintText = widget.searchHintText ?? 'Search value';
    return _OverlayBuilder(
      overlay: (size, hideCallback) {
        return _DropdownOverlay(
          searchHintText: searchHintText,
          controller: controller,
          size: size,
          layerLink: layerLink,
          hideOverlay: hideCallback,
          hintText: hintText,
          onChanged: widget.onChanged,
          dropDownType: widget.dropDownType,
        );
      },
      child: (showCallback) {
        return CompositedTransformTarget(
          link: layerLink,
          child: _DropDownField(
            controller: controller,
            onTap: showCallback,
            hintText: hintText,
            dropDownType: widget.dropDownType,
          ),
        );
      },
    );
  }
}
