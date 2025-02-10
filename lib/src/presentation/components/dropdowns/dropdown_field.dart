part of 'custom_dropdown.dart';

const _noTextStyle = TextStyle(height: 0);
const _borderSide = BorderSide(color: Colors.transparent);
const _errorBorderSide = BorderSide(color: Colors.redAccent, width: 2);

class _DropDownField extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final VoidCallback onTap;
  final DropDownType dropDownType;
  final String? hintText;

  const _DropDownField({
    required this.controller,
    required this.onTap,
    required this.dropDownType,
    this.hintText,
  });

  @override
  ConsumerState<_DropDownField> createState() => _DropDownFieldState();
}

class _DropDownFieldState extends ConsumerState<_DropDownField> {
  String? prevText;
  bool listenChanges = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listenItemChanges);
  }

  @override
  void dispose() {
    widget.controller.removeListener(listenItemChanges);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _DropDownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.controller.addListener(listenItemChanges);
  }

  void listenItemChanges() {
    if (listenChanges) {
      prevText = widget.controller.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: _borderSide,
    );

    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: _errorBorderSide,
    );
    final rightSideState = ref.watch(rightSideProvider);
    final rightSideNotifier = ref.read(rightSideProvider.notifier);
    final bool isSelected = (widget.dropDownType == DropDownType.section
        ? rightSideState.selectedSection != null
        : widget.dropDownType == DropDownType.table
            ? rightSideState.selectedTable != null
            :  rightSideState.selectedUser != null);
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      onTap: widget.onTap,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
        color: Style.black,
        letterSpacing: -14 * 0.02,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        suffixIcon: !isSelected
            ? Icon(
                FlutterRemix.arrow_down_s_line,
                color: Style.black,
                size: 20.r,
              )
            : IconButton(
                hoverColor: Style.transparent,
                splashColor: Style.transparent,
                onPressed: () {
                  widget.controller.clear();
                  switch (widget.dropDownType) {
                    case DropDownType.section:
                      rightSideNotifier.removeSelectedSection();
                      break;
                    case DropDownType.table:
                      rightSideNotifier.removeSelectedTable();

                      break;
                  }
                },
                icon: Icon(
                  FlutterRemix.close_circle_line,
                  size: 20.r,
                  color: Style.black.withOpacity(0.5),
                ),
              ),
        hintText: widget.hintText,
        fillColor: Style.white,
        hintStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
          color: Style.searchHint,
        ),
        hoverColor: Style.transparent,
        errorStyle: _noTextStyle,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
      ),
    );
  }
}
