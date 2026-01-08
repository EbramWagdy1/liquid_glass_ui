import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liquid_glass_ui/liquid_glass_ui.dart';

void main() {
  testWidgets('LiquidGlassContainer pumps correctly', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LiquidGlassContainer(
            width: 100,
            height: 100,
            child: const Text('Glass'),
          ),
        ),
      ),
    );

    // Verify that the widget appears
    expect(find.text('Glass'), findsOneWidget);
    expect(find.byType(LiquidGlassContainer), findsOneWidget);
  });

  testWidgets('LiquidGlassButton respects tap', (WidgetTester tester) async {
    bool pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LiquidGlassButton(
            onPressed: () {
              pressed = true;
            },
            child: const Text('Tap Me'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Tap Me'));
    await tester.pumpAndSettle(); // Animation

    expect(pressed, isTrue);
  });

  testWidgets('LiquidGlassTheme extension provides values', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: const [
            LiquidGlassThemeData(blurSigma: 20.0, baseOpacity: 0.5),
          ],
        ),
        home: Builder(
          builder: (context) {
            final theme = Theme.of(context).extension<LiquidGlassThemeData>();
            return Text(
              'Blur: ${theme?.blurSigma}',
              textDirection: TextDirection.ltr,
            );
          },
        ),
      ),
    );

    expect(find.text('Blur: 20.0'), findsOneWidget);
  });
}
