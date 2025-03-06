import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/utils.dart';
import 'button_effect_animation.dart';

class StatusButton extends StatelessWidget {
  final String status;
  final VoidCallback? onTap;
  final double verticalPadding;
  final double horizontalPadding;

  const StatusButton({
    super.key,
    required this.status,
    this.onTap,
    this.verticalPadding = 6,
    this.horizontalPadding = 16,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonEffectAnimation(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppHelpers.getStatusColor(status).withOpacity(0.16),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          _getStatusText(status), // Usamos directamente el texto en español
          style: GoogleFonts.inter(
            fontSize: 16,
            color: AppHelpers.getStatusColor(status),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Pendiente';
      case 'completed':
        return 'Completado';
      case 'cancelled':
        return 'Cancelado';
      case 'in_progress':
        return 'En progreso';
      default:
        return status; // Devolver tal cual si no coincide
    }
  }
}
