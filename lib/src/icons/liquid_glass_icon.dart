import 'package:flutter/material.dart';

/// An icon wrapper that adds a glass-like gradient effect.
class LiquidGlassIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color? color;

  /// Whether to apply the gradient mask.
  final bool useGradient;

  const LiquidGlassIcon(
    this.icon, {
    super.key,
    this.size = 24.0,
    this.color,
    this.useGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = color ?? Colors.white;

    if (!useGradient) {
      return Icon(icon, size: size, color: baseColor);
    }

    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            baseColor,
            baseColor.withValues(alpha: 0.7),
            baseColor.withValues(alpha: 0.9),
          ],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: Icon(icon, size: size, color: baseColor),
    );
  }
}
