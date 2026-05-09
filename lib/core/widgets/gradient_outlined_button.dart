import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_radii.dart';
import '../theme/app_spacing.dart';

/// İkincil CTA butonu (Glass Border + Gradient)
class GradientOutlinedButton extends StatefulWidget {
  const GradientOutlinedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.compact = false,
  });

  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final bool compact;

  @override
  State<GradientOutlinedButton> createState() => _GradientOutlinedButtonState();
}

class _GradientOutlinedButtonState extends State<GradientOutlinedButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null;

    return GestureDetector(
      onTapDown: isEnabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: isEnabled ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel: isEnabled ? () => setState(() => _isPressed = false) : null,
      onTap: widget.onPressed,
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: widget.compact ? 13 : 11,
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: AppRadii.brMd,
            border: Border.all(
              color: isEnabled ? AppColors.primary : AppColors.textMuted,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: 16,
                  color: isEnabled ? AppColors.primary : AppColors.textMuted,
                ),
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isEnabled ? AppColors.primary : AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
