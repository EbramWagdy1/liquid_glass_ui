import 'package:flutter/material.dart';
import '../../liquid_glass_ui.dart';

class LiquidGlassNavBarItem {
  final IconData icon;
  final String? label;

  LiquidGlassNavBarItem({required this.icon, this.label});
}

class LiquidGlassNavBar extends StatelessWidget {
  final List<LiquidGlassNavBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color? activeColor;

  /// Whether to show the text labels when an item is selected.
  final bool showLabels;

  /// External padding for the bar.
  final EdgeInsetsGeometry padding;

  /// Duration of the selection animation.
  final Duration animationDuration;

  const LiquidGlassNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.activeColor,
    this.showLabels = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    // Access theme via connection
    final theme =
        Theme.of(context).extension<LiquidGlassThemeData>() ??
        LiquidGlassThemeData.light;
    final effectiveActiveColor = activeColor ?? theme.accentColor;

    return Center(
      heightFactor: 1.0,
      child: SafeArea(
        child: LiquidGlassContainer(
          height: 70,
          margin: padding,
          borderRadius: 35,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isSelected = index == currentIndex;

              return GestureDetector(
                onTap: () => onTap(index),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: animationDuration,
                  curve: Curves.fastOutSlowIn,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? effectiveActiveColor.withValues(alpha: 0.3)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LiquidGlassIcon(
                        item.icon,
                        color: isSelected ? Colors.white : Colors.white70,
                        size: 24,
                        // Disable gradient on nav bar icons for clarity if needed, or keep consistent
                        useGradient:
                            isSelected, // Only highlight selected with "glassy" look?
                      ),
                      if (isSelected && showLabels && item.label != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          item.label!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
