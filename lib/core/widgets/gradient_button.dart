import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_gradients.dart';
import '../theme/app_radii.dart';
import '../theme/app_shadows.dart';
import '../theme/app_spacing.dart';

/// Premium CTA butonu
/// - primaryCta linear gradient + glowLime shadow (basıldığında shadow azalır)
/// - AnimatedScale ile press feedback (0.97)
/// - disabled state'te gradient'i gri tonlarına çevir, glow kaldır
class GradientButton extends StatefulWidget {
  const GradientButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isLoading = false,
    this.icon,
    this.compact = false,
    this.solidColor,
    this.borderRadius,
    this.boxShadow,
  });

  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;
  final IconData? icon;
  final bool compact;
  final Color? solidColor;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null && !widget.isLoading;

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
            horizontal: AppSpacing.lg,
            vertical: widget.compact ? 13 : AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: isEnabled ? widget.solidColor : null,
            gradient: isEnabled && widget.solidColor == null
                ? AppGradients.primaryCta
                : isEnabled
                ? null
                : const LinearGradient(
                    colors: [Color(0xFF6B7280), Color(0xFF4B5563)],
                  ),
            borderRadius: widget.borderRadius ?? AppRadii.brMd,
            boxShadow: isEnabled && !_isPressed
                ? widget.boxShadow ?? AppShadows.glowLime
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.isLoading)
                const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                )
              else ...[
                if (widget.icon != null) ...[
                  Icon(widget.icon, size: 18, color: Colors.black),
                  const SizedBox(width: AppSpacing.sm),
                ],
                Text(
                  widget.label,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isEnabled ? Colors.black : Colors.white54,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
