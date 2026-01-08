import 'package:flutter/material.dart';
import '../../liquid_glass_kit.dart';

/// A pressable button with glassmorphism styling.
class LiquidGlassButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final double? borderRadius;
  final Color? color;
  final Color? accentColor;

  const LiquidGlassButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.width,
    this.height,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.borderRadius,
    this.color,
    this.accentColor,
  });

  @override
  State<LiquidGlassButton> createState() => _LiquidGlassButtonState();
}

class _LiquidGlassButtonState extends State<LiquidGlassButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null) {
      _controller.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onPressed != null) {
      _controller.reverse();
      widget.onPressed!();
    }
  }

  void _onTapCancel() {
    if (widget.onPressed != null) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: isEnabled ? 1.0 : 0.5,
              child: LiquidGlassContainer(
                width: widget.width,
                height: widget.height,
                padding: widget.padding,
                borderRadius:
                    widget.borderRadius ?? 50.0, // Rounded pill by default
                color:
                    widget.color ?? widget.accentColor?.withValues(alpha: 0.2),
                borderColor: widget.accentColor?.withValues(alpha: 0.5),
                child: Center(
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: DefaultTextStyle(
                    style:
                        Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ) ??
                        const TextStyle(color: Colors.white),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// A circular icon button with glass styling.
class LiquidGlassIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;
  final double size;
  final Color? color;

  const LiquidGlassIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = 48.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return LiquidGlassButton(
      onPressed: onPressed,
      width: size,
      height: size,
      padding: EdgeInsets.zero,
      borderRadius: size / 2, // Circle
      color: color,
      child: icon,
    );
  }
}

/// A Floating Action Button with glass styling.
class LiquidGlassFAB extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? accentColor;

  const LiquidGlassFAB({
    super.key,
    required this.onPressed,
    required this.child,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme =
        Theme.of(context).extension<LiquidGlassThemeData>() ??
        LiquidGlassThemeData.light;
    return LiquidGlassButton(
      onPressed: onPressed,
      width: 56,
      height: 56,
      borderRadius: 28,
      padding: EdgeInsets.zero,
      accentColor: accentColor ?? theme.accentColor,
      child: child,
    );
  }
}
