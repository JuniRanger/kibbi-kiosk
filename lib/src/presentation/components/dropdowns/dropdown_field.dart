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
  @override
  void initState() {
    super.initState();
    // Aquí puedes agregar cualquier lógica para inicializar el controlador si lo necesitas
  }

  @override
  void dispose() {
    super.dispose();
    // Aquí puedes limpiar recursos si es necesario
  }

  @override
  void didUpdateWidget(covariant _DropDownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Aquí puedes manejar cambios cuando el widget se actualiza
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
        suffixIcon: Icon(
          FlutterRemix.arrow_down_s_line,
          color: Style.black,
          size: 20.r,
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
