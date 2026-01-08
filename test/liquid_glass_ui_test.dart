import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liquid_glass_ui/liquid_glass_ui.dart';

void main() {
  group('LiquidGlassTheme', () {
    testWidgets('Extension provides correct values', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: const [
              LiquidGlassThemeData(
                blurSigma: 20.0,
                baseOpacity: 0.5,
                quality: LiquidGlassQuality.high,
              ),
            ],
          ),
          home: Builder(
            builder: (context) {
              final theme = Theme.of(context).extension<LiquidGlassThemeData>();
              return Column(
                children: [
                  Text('Blur: ${theme?.blurSigma}'),
                  Text('Quality: ${theme?.quality}'),
                ],
              );
            },
          ),
        ),
      );

      expect(find.text('Blur: 20.0'), findsOneWidget);
      expect(find.text('Quality: LiquidGlassQuality.high'), findsOneWidget);
    });

    test('lerp interpolates values correctly', () {
      const theme1 = LiquidGlassThemeData(blurSigma: 10, baseOpacity: 0.1);
      const theme2 = LiquidGlassThemeData(blurSigma: 20, baseOpacity: 0.5);

      final lerped = theme1.lerp(theme2, 0.5);

      expect(lerped.blurSigma, 15.0); // Midpoint
      expect(lerped.baseOpacity, closeTo(0.3, 0.0001)); // Midpoint
    });
  });

  group('LiquidGlassContainer', () {
    testWidgets('Renders with BackdropFilter in High Quality', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              const LiquidGlassThemeData(quality: LiquidGlassQuality.high),
            ],
          ),
          home: const LiquidGlassContainer(child: Text('High')),
        ),
      );

      // Should find BackdropFilter
      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('Skips BackdropFilter in Low Quality', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              const LiquidGlassThemeData(quality: LiquidGlassQuality.low),
            ],
          ),
          home: const LiquidGlassContainer(child: Text('Low')),
        ),
      );

      // Should NOT find BackdropFilter
      expect(find.byType(BackdropFilter), findsNothing);
      expect(find.text('Low'), findsOneWidget);
    });

    testWidgets('Applies custom border radius', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LiquidGlassContainer(borderRadius: 99.0)),
      );

      // Finding ClipRRect is a proxy for checking if clipping is applied
      final clipFinder = find.byType(ClipRRect);
      expect(clipFinder, findsOneWidget);

      final ClipRRect clip = tester.widget(clipFinder);
      expect(clip.borderRadius, BorderRadius.circular(99.0));
    });
  });

  group('LiquidGlassButton', () {
    testWidgets('Callback fires on tap', (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: LiquidGlassButton(
            onPressed: () => tapped = true,
            child: const Text('Tap Me'),
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      await tester.pumpAndSettle();
      expect(tapped, isTrue);
    });

    testWidgets('Disabled state triggers no callback', (
      WidgetTester tester,
    ) async {
      bool tapped = false;
      await tester.pumpWidget(
        const MaterialApp(
          home: LiquidGlassButton(
            onPressed: null, // Disabled
            child: Text('Disabled'),
          ),
        ),
      );

      await tester.tap(find.text('Disabled'));
      expect(tapped, isFalse);

      // Verify visual opacity (half opacity)
      final opacityFinder = find.byType(Opacity);
      final Opacity opacity = tester.widget(opacityFinder.last);
      expect(opacity.opacity, 0.5);
    });
  });

  group('LiquidGlassNavBar', () {
    testWidgets('Selection update triggers callback', (
      WidgetTester tester,
    ) async {
      int? selectedIndex;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: LiquidGlassNavBar(
              items: [
                LiquidGlassNavBarItem(icon: Icons.home, label: "A"),
                LiquidGlassNavBarItem(icon: Icons.settings, label: "B"),
              ],
              currentIndex: 0,
              onTap: (i) => selectedIndex = i,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.settings));
      expect(selectedIndex, 1);
    });
  });
}
