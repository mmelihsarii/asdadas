import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';

/// Gradient avatar ring
/// - SweepGradient ring + iç kısımda CircleAvatar (cached_network_image)
/// - Yavaş dönen sweep (60s döngü, opsiyonel)
class GradientAvatarRing extends StatefulWidget {
  const GradientAvatarRing({
    super.key,
    required this.imageUrl,
    this.size = 80,
    this.ringWidth = 3,
    this.animated = false,
    this.initials,
  });

  final String? imageUrl;
  final double size;
  final double ringWidth;
  final bool animated;
  final String? initials;

  @override
  State<GradientAvatarRing> createState() => _GradientAvatarRingState();
}

class _GradientAvatarRingState extends State<GradientAvatarRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );

    if (widget.animated) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(GradientAvatarRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animated != oldWidget.animated) {
      if (widget.animated) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        children: [
          // Gradient ring
          if (widget.animated)
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * 3.14159,
                  child: child,
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppGradients.avatarRing,
                ),
              ),
            )
          else
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppGradients.avatarRing,
              ),
            ),

          // Inner avatar
          Center(
            child: Container(
              width: widget.size - (widget.ringWidth * 2),
              height: widget.size - (widget.ringWidth * 2),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface,
              ),
              child: ClipOval(
                child: widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: widget.imageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppColors.surface,
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            _buildInitialsAvatar(),
                      )
                    : _buildInitialsAvatar(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialsAvatar() {
    return Container(
      color: AppColors.surface,
      child: Center(
        child: Text(
          widget.initials ?? '?',
          style: TextStyle(
            fontSize: widget.size * 0.4,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
