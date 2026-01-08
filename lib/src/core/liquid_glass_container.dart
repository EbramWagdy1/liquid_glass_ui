import 'dart:ui';
import 'package:flutter/material.dart';
import '../../liquid_glass_kit.dart';

/// The core container for the Liquid Glass UI system.
class LiquidGlassContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;

  /// Blur amount. Ignored if Quality is Low.
  final double? blur;

  /// Base opacity of the glass effect.
  final double? opacity;

  /// Border radius.
  final double? borderRadius;

  /// Border color.
  final Color? borderColor;

  /// Border width.
  final double? borderWidth;

  /// Background tint color.
  final Color? color;

  /// Gradient overlay.
  final Gradient? gradient;

  /// Box shadow.
  final List<BoxShadow>? boxShadow;

  /// Clip behavior.
  final Clip clipBehavior;

  /// Shape of the container (BoxShape.rectangle or BoxShape.circle).
  /// If [BoxShape.circle], [borderRadius] is ignored.
  final BoxShape shape;

  const LiquidGlassContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.alignment,
    this.blur,
    this.opacity,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.color,
    this.gradient,
    this.boxShadow,
    this.clipBehavior = Clip.antiAlias,
    this.shape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    // defaults if extension not found
    final theme =
        Theme.of(context).extension<LiquidGlassThemeData>() ??
        LiquidGlassThemeData.light;

    // Resolve values
    final double rawBlur = blur ?? theme.blurSigma;
    final double effectiveOpacity = opacity ?? theme.baseOpacity;
    final double effectiveRadius = borderRadius ?? theme.borderRadius;
    final Color effectiveBorderColor = borderColor ?? theme.borderColor;
    final double effectiveBorderWidth = borderWidth ?? theme.borderWidth;
    final Color baseColor = color ?? theme.baseColor;

    // Quality Check
    double effectiveBlur = 0;
    switch (theme.quality) {
      case LiquidGlassQuality.high:
        effectiveBlur = rawBlur;
        break;
      case LiquidGlassQuality.medium:
        effectiveBlur = rawBlur * 0.5;
        break;
      case LiquidGlassQuality.low:
        effectiveBlur = 0; // Disable blur for performance
        break;
    }

    final decoration = BoxDecoration(
      color: gradient == null
          ? baseColor.withValues(alpha: effectiveOpacity)
          : null,
      gradient: gradient,
      borderRadius: shape == BoxShape.circle
          ? null
          : BorderRadius.circular(effectiveRadius),
      shape: shape,
      border: Border.all(
        color: effectiveBorderColor,
        width: effectiveBorderWidth,
      ),
      boxShadow: boxShadow,
    );

    // If low quality or 0 blur, skip BackdropFilter entirely
    if (effectiveBlur == 0) {
      return Container(
        width: width,
        height: height,
        margin: margin,
        decoration: decoration.copyWith(
          // Ensure we still have some background if blur is gone, maybe boost opacity slightly?
          // For now, respect the opacity.
        ),
        child: Container(padding: padding, alignment: alignment, child: child),
      );
    }

    // High/Medium Quality
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: shape == BoxShape.circle
            ? BorderRadius.circular(1000)
            : BorderRadius.circular(effectiveRadius),
        clipBehavior: clipBehavior,
        child: Stack(
          children: [
            // 1. Blur
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: effectiveBlur,
                  sigmaY: effectiveBlur,
                ),
                child: Container(color: Colors.transparent),
              ),
            ),

            // 2. Surface
            Positioned.fill(child: Container(decoration: decoration)),

            // 3. Content
            Container(padding: padding, alignment: alignment, child: child),
          ],
        ),
      ),
    );
  }
}
