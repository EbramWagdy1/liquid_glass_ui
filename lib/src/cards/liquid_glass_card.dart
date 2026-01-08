import 'package:flutter/material.dart';
import '../../liquid_glass_kit.dart';

/// A general purpose glass card.
class LiquidGlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double? width;
  final double? height;
  final Color? color;

  const LiquidGlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return LiquidGlassContainer(
      width: width,
      height: height,
      padding: padding,
      color: color,
      child: child,
    );
  }
}

/// A bottom sheet style glass container.
class LiquidGlassSheet extends StatelessWidget {
  final Widget child;
  final double? height;

  const LiquidGlassSheet({super.key, required this.child, this.height});

  @override
  Widget build(BuildContext context) {
    // Theme is handled internally by LiquidGlassContainer logic now.
    // We defer borderRadius logic to the user or Defaults.
    return LiquidGlassContainer(
      width: double.infinity,
      height: height,
      padding: const EdgeInsets.all(24.0),
      child: child,
    );
  }
}
