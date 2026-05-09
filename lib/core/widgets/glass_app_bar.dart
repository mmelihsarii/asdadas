import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'glass_container.dart';
import '../theme/glass_tokens.dart';

/// Glass AppBar
/// - PreferredSizeWidget
/// - GlassContainer(intensity: regular) + alt 1px glassEdgeAccent
/// - extendBodyBehindAppBar: true ile kullanılacak
class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlassAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.centerTitle = false,
  });

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: GlassContainer(
        intensity: GlassIntensity.regular,
        showEdgeAccent: true,
        padding: EdgeInsets.zero,
        child: SizedBox(
          height: kToolbarHeight,
          child: Row(
            children: [
              if (leading != null)
                leading!
              else
                const SizedBox(
                  width: 6.4,
                ), // 20% reduction from AppSpacing.sm (8px)
              if (title != null)
                Expanded(
                  child: centerTitle
                      ? Center(child: title!)
                      : Padding(
                          padding: const EdgeInsets.only(
                            left: 9.6,
                          ), // 20% reduction from AppSpacing.md (12px)
                          child: DefaultTextStyle(
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                            child: title!,
                          ),
                        ),
                ),
              if (actions != null) ...actions!,
              const SizedBox(
                width: 6.4,
              ), // 20% reduction from AppSpacing.sm (8px)
            ],
          ),
        ),
      ),
    );
  }
}
