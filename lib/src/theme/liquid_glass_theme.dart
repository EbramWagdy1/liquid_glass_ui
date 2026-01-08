import 'package:flutter/material.dart';

/// Defines the performance/visual quality level of the glass effect.
enum LiquidGlassQuality {
  /// Highest quality: High blur, full effects. May impact performance on low-end devices.
  high,

  /// Medium quality: Moderate blur. Balanced.
  medium,

  /// Low quality: No blur filter, falls back to simple opacity/color. Best for performance.
  low,
}

/// Defines the configuration for the Liquid Glass UI system.
@immutable
class LiquidGlassThemeData extends ThemeExtension<LiquidGlassThemeData> {
  /// The performance quality level.
  final LiquidGlassQuality quality;

  /// The blur intensity of the glass effect (used when quality is not low).
  final double blurSigma;

  /// The base opacity of the glass container.
  final double baseOpacity;

  /// The color of the glass (usually white or black).
  final Color baseColor;

  /// The color of the container border.
  final Color borderColor;

  /// The width of the container border.
  final double borderWidth;

  /// The default border radius.
  final double borderRadius;

  /// The primary accent color for active elements.
  final Color accentColor;

  /// Creates a [LiquidGlassThemeData].
  const LiquidGlassThemeData({
    this.quality = LiquidGlassQuality.high,
    this.blurSigma = 12.0,
    this.baseOpacity = 0.1,
    this.baseColor = Colors.white,
    this.borderColor = Colors.white24,
    this.borderWidth = 1.0,
    this.borderRadius = 16.0,
    this.accentColor = Colors.blueAccent,
  });

  /// Default light theme.
  static const LiquidGlassThemeData light = LiquidGlassThemeData(
    baseColor: Colors.white,
    borderColor: Colors.white30,
    baseOpacity: 0.2,
  );

  /// Default dark theme.
  static const LiquidGlassThemeData dark = LiquidGlassThemeData(
    baseColor: Colors.black,
    borderColor: Colors.white12,
    baseOpacity: 0.3,
  );

  @override
  LiquidGlassThemeData copyWith({
    LiquidGlassQuality? quality,
    double? blurSigma,
    double? baseOpacity,
    Color? baseColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    Color? accentColor,
  }) {
    return LiquidGlassThemeData(
      quality: quality ?? this.quality,
      blurSigma: blurSigma ?? this.blurSigma,
      baseOpacity: baseOpacity ?? this.baseOpacity,
      baseColor: baseColor ?? this.baseColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      accentColor: accentColor ?? this.accentColor,
    );
  }

  @override
  LiquidGlassThemeData lerp(
    ThemeExtension<LiquidGlassThemeData>? other,
    double t,
  ) {
    if (other is! LiquidGlassThemeData) return this;
    return LiquidGlassThemeData(
      quality: other.quality, // Non-lerpable
      blurSigma: lerpDouble(blurSigma, other.blurSigma, t) ?? blurSigma,
      baseOpacity: lerpDouble(baseOpacity, other.baseOpacity, t) ?? baseOpacity,
      baseColor: Color.lerp(baseColor, other.baseColor, t) ?? baseColor,
      borderColor: Color.lerp(borderColor, other.borderColor, t) ?? borderColor,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t) ?? borderWidth,
      borderRadius:
          lerpDouble(borderRadius, other.borderRadius, t) ?? borderRadius,
      accentColor: Color.lerp(accentColor, other.accentColor, t) ?? accentColor,
    );
  }

  /// Helper to get the blur sigma based on quality.
  double get effectiveBlur {
    switch (quality) {
      case LiquidGlassQuality.high:
        return blurSigma;
      case LiquidGlassQuality.medium:
        return blurSigma * 0.5;
      case LiquidGlassQuality.low:
        return 0.0;
    }
  }

  /// Helper methods for lerping doubles.
  double? lerpDouble(double? a, double? b, double t) {
    if (a == null && b == null) return null;
    return (a ?? 0.0) + ((b ?? 0.0) - (a ?? 0.0)) * t;
  }
}
