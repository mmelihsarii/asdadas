import 'package:flutter/material.dart';
import '../theme/app_gradients.dart';

/// Sayfaların kök arkaplanı. Tek seferlik render edilir, paint cache'lenir.
/// İçerik: sceneBackdrop (linear) + 3 ambient blob (radial) + vignette.
/// Animasyon: 1 tane AnimationController, 30s döngü. Blob'ları çok yavaş scale + translate yapar.
/// disableAnimations true ise sabit kalır.
class GradientBackground extends StatefulWidget {
  const GradientBackground({
    super.key,
    required this.child,
    this.animated = true,
    this.showVignette = true,
  });

  final Widget child;
  final bool animated;
  final bool showVignette;

  @override
  State<GradientBackground> createState() => _GradientBackgroundState();
}

class _GradientBackgroundState extends State<GradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );

    if (widget.animated) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(GradientBackground oldWidget) {
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
    final mq = MediaQuery.of(context);
    final shouldAnimate = widget.animated && !mq.disableAnimations;

    return Stack(
      children: [
        // Base gradient
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(gradient: AppGradients.sceneBackdrop),
          ),
        ),

        // Ambient blobs (animated)
        if (shouldAnimate)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return RepaintBoundary(
                child: Stack(
                  children: [
                    // Blob 1 - Green (top-left)
                    Positioned(
                      left: -100 + (_controller.value * 60 - 30),
                      top: -100 + (_controller.value * 40 - 20),
                      child: IgnorePointer(
                        child: Container(
                          width: 400,
                          height: 400,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: AppGradients.ambientBlobGreen,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Blob 2 - Cyan (right-center)
                    Positioned(
                      right: -80 + (_controller.value * -50 + 25),
                      top: mq.size.height * 0.3 + (_controller.value * 60 - 30),
                      child: IgnorePointer(
                        child: Container(
                          width: 350,
                          height: 350,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: AppGradients.ambientBlobCyan,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Blob 3 - Lime (bottom-left)
                    Positioned(
                      left:
                          mq.size.width * 0.25 + (_controller.value * 40 - 20),
                      bottom: -120 + (_controller.value * -50 + 25),
                      child: IgnorePointer(
                        child: Container(
                          width: 380,
                          height: 380,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: AppGradients.ambientBlobLime,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        else
          // Static blobs (no animation)
          RepaintBoundary(
            child: Stack(
              children: [
                Positioned(
                  left: -100,
                  top: -100,
                  child: IgnorePointer(
                    child: Container(
                      width: 400,
                      height: 400,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: AppGradients.ambientBlobGreen,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: -80,
                  top: mq.size.height * 0.3,
                  child: IgnorePointer(
                    child: Container(
                      width: 350,
                      height: 350,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: AppGradients.ambientBlobCyan,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: mq.size.width * 0.25,
                  bottom: -120,
                  child: IgnorePointer(
                    child: Container(
                      width: 380,
                      height: 380,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: AppGradients.ambientBlobLime,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        // Vignette
        if (widget.showVignette)
          const Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(gradient: AppGradients.vignette),
              ),
            ),
          ),

        // Content
        widget.child,
      ],
    );
  }
}
