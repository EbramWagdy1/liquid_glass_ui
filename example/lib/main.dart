import 'package:flutter/material.dart';
import 'package:liquid_glass_ui/liquid_glass_ui.dart';

void main() {
  runApp(const LiquidGlassShowcaseApp());
}

class LiquidGlassShowcaseApp extends StatefulWidget {
  const LiquidGlassShowcaseApp({super.key});

  @override
  State<LiquidGlassShowcaseApp> createState() => _LiquidGlassShowcaseAppState();
}

class _LiquidGlassShowcaseAppState extends State<LiquidGlassShowcaseApp> {
  LiquidGlassQuality _quality = LiquidGlassQuality.high;

  void _cycleQuality() {
    setState(() {
      switch (_quality) {
        case LiquidGlassQuality.high:
          _quality = LiquidGlassQuality.medium;
          break;
        case LiquidGlassQuality.medium:
          _quality = LiquidGlassQuality.low;
          break;
        case LiquidGlassQuality.low:
          _quality = LiquidGlassQuality.high;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define the custom theme extension
    final glassTheme = LiquidGlassThemeData(
      quality: _quality,
      accentColor: Colors.pinkAccent,
      baseOpacity: 0.15,
    );

    return MaterialApp(
      title: 'Liquid Glass UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        extensions: <ThemeExtension<dynamic>>[glassTheme],
      ),
      home: LiquidGlassHomePage(onQualityToggle: _cycleQuality),
    );
  }
}

class LiquidGlassHomePage extends StatefulWidget {
  final VoidCallback onQualityToggle;
  const LiquidGlassHomePage({super.key, required this.onQualityToggle});

  @override
  State<LiquidGlassHomePage> createState() => _LiquidGlassHomePageState();
}

class _LiquidGlassHomePageState extends State<LiquidGlassHomePage> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Access current quality for display
    final glassTheme = Theme.of(context).extension<LiquidGlassThemeData>();
    final currentQuality = glassTheme?.quality ?? LiquidGlassQuality.high;

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF2E0249),
                    Color(0xFF570A57),
                    Color(0xFFA91079),
                    Color(0xFFF806CC),
                  ],
                ),
              ),
            ),
          ),

          // Decorative shapes
          Positioned(
            top: -100,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purpleAccent.withValues(alpha: 0.4),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent.withValues(alpha: 0.4),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Liquid Glass UI',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Premium Glassmorphism Kit',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      LiquidGlassIconButton(
                        onPressed: widget.onQualityToggle,
                        icon: const Icon(Icons.speed, color: Colors.white),
                        size: 40,
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Quality: ${currentQuality.name.toUpperCase()}",
                      style: const TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Cards Section
                  const _SectionHeader('Cards'),
                  const SizedBox(height: 10),
                  LiquidGlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Glass Card',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'This is a premium card component with real-time background blur and border effects.',
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            LiquidGlassButton(
                              onPressed: () {},
                              borderRadius: 12,
                              height: 40,
                              child: const Text('Action'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Buttons Section
                  const _SectionHeader('Buttons'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      LiquidGlassButton(
                        onPressed: () {},
                        child: const Text('Primary Button'),
                      ),
                      LiquidGlassButton(
                        onPressed: () {},
                        color: Colors.white.withValues(alpha: 0.1),
                        child: const Text('Secondary'),
                      ),
                      LiquidGlassIconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite, color: Colors.white),
                      ),
                      LiquidGlassIconButton(
                        onPressed: () {},
                        icon: const LiquidGlassIcon(
                          Icons.star,
                          useGradient: true,
                        ),
                        color: Colors.amber.withValues(alpha: 0.2),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  // Inputs / Misc
                  const _SectionHeader('Shapes & Effects'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      LiquidGlassContainer(
                        width: 100,
                        height: 100,
                        blur: 20,
                        borderRadius: 20,
                        child: const Center(
                          child: Text(
                            "Box",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      LiquidGlassContainer(
                        width: 100,
                        height: 100,
                        blur: 5,
                        shape: BoxShape.circle,
                        child: const Center(
                          child: Text(
                            "Circle",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Navigation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: LiquidGlassNavBar(
              currentIndex: _navIndex,
              showLabels: true,
              onTap: (index) => setState(() => _navIndex = index),
              items: [
                LiquidGlassNavBarItem(icon: Icons.home_rounded, label: 'Home'),
                LiquidGlassNavBarItem(
                  icon: Icons.explore_rounded,
                  label: 'Explore',
                ),
                LiquidGlassNavBarItem(
                  icon: Icons.person_rounded,
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: LiquidGlassFAB(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (_) => const LiquidGlassSheet(
              height: 300,
              child: Center(
                child: Text(
                  "Glass Sheet",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white54,
        letterSpacing: 1.2,
      ),
    );
  }
}
