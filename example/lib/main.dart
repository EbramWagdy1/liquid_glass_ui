import 'package:flutter/material.dart';
import 'package:liquid_glass_kit/liquid_glass_kit.dart';

void main() {
  runApp(const LiquidGlassShowcaseApp());
}

class LiquidGlassShowcaseApp extends StatefulWidget {
  const LiquidGlassShowcaseApp({super.key});

  @override
  State<LiquidGlassShowcaseApp> createState() => _LiquidGlassShowcaseAppState();
}

class _LiquidGlassShowcaseAppState extends State<LiquidGlassShowcaseApp> {
  // Toggle for performance demonstration
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
    // Premium Dark Glass Theme
    final glassTheme = LiquidGlassThemeData(
      quality: _quality,
      blurSigma: 25.0, // High blur for "frosted" look
      baseOpacity: 0.1, // Very transparent base
      baseColor: Colors.black, // Dark glass
      // The secret to "Real Glass": Crisp, semi-transparent white borders
      borderColor: Colors.white.withValues(alpha: 0.3),
      borderWidth: 1.5,
      borderRadius: 30.0,
      accentColor: Colors.amber, // Warm accent
    );

    return MaterialApp(
      title: 'Liquid Glass High Fidelity',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F0F0F), // Deep black
        extensions: <ThemeExtension<dynamic>>[glassTheme],
      ),
      home: ControlCenterPage(onQualityToggle: _cycleQuality),
    );
  }
}

class ControlCenterPage extends StatelessWidget {
  final VoidCallback onQualityToggle;

  const ControlCenterPage({super.key, required this.onQualityToggle});

  @override
  Widget build(BuildContext context) {
    // Complex abstract background to show off the refraction
    return Scaffold(
      body: Stack(
        children: [
          // 1. Dynamic Background (Lava Lamp style)
          Positioned.fill(
            child: Container(
              color: Colors.black,
              child: Stack(
                children: [
                  // Moving gradients / images would be best, here we simulate with static blobs
                  _buildBlob(topLeft: true, color: Colors.blueAccent),
                  _buildBlob(bottomRight: true, color: Colors.purpleAccent),
                  _buildBlob(center: true, color: Colors.orangeAccent),

                  // Texture overlay (noise) could be added here for "grit"
                ],
              ),
            ),
          ),

          // 2. The Glass UI Layer
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  _buildHeader(),
                  const SizedBox(height: 30),

                  // Status Pill (Big Glass Block)
                  LiquidGlassContainer(
                    height: 140,
                    padding: const EdgeInsets.all(24),
                    // Add a subtle gradient overlay to simulate surface reflection
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.1),
                        Colors.white.withValues(alpha: 0.0),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icons with "Glow"
                            LiquidGlassIcon(
                              Icons.wifi,
                              size: 32,
                              useGradient: true,
                            ),
                            const SizedBox(height: 16),
                            LiquidGlassIcon(
                              Icons.bluetooth,
                              size: 32,
                              useGradient: true,
                            ),
                          ],
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Liquid Wi-Fi",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "Connected",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Bluetooth",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "On",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Toggles Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildGlassToggle(Icons.airplane_ticket, Colors.orange),
                      _buildGlassToggle(Icons.data_usage, Colors.green),
                      _buildGlassToggle(Icons.share, Colors.blue),
                      _buildGlassToggle(Icons.flashlight_on, Colors.white),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Sliders Row
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildVerticalSlider(
                            icon: Icons.brightness_6,
                            level: 0.7,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _buildVerticalSlider(
                            icon: Icons.volume_up,
                            level: 0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Quality Toggle as a "Button"
                  Center(
                    child: LiquidGlassButton(
                      onPressed: onQualityToggle,
                      borderRadius: 50,
                      child: const Text("Toggle Quality (Bloom)"),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassToggle(IconData icon, Color color) {
    return LiquidGlassContainer(
      width: 70,
      height: 70,
      borderRadius: 35, // Circle
      // Make the "pressed" or "active" state feel like a lens
      child: Center(
        child: LiquidGlassIcon(icon, size: 28, color: color, useGradient: true),
      ),
    );
  }

  Widget _buildVerticalSlider({required IconData icon, required double level}) {
    return LiquidGlassContainer(
      padding: EdgeInsets.zero,
      // Inner stack for the "fill" level
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Analysis: To look like a filled glass tube, the fill needs to be opaque-ish white
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                height: constraints.maxHeight * level,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9), // Bright fill
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            child: Icon(
              icon,
              color: Colors.black,
              size: 30,
            ), // Icon inside the fill
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Control Center",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        LiquidGlassIcon(Icons.more_horiz),
      ],
    );
  }

  Widget _buildBlob({
    bool topLeft = false,
    bool bottomRight = false,
    bool center = false,
    required Color color,
  }) {
    // Helper for background gradients
    return Positioned(
      top: topLeft ? -100 : (center ? 200 : null),
      bottom: bottomRight ? -100 : null,
      left: topLeft ? -50 : null,
      right: bottomRight ? -50 : null,
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.6),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 100,
              spreadRadius: 50,
            ),
          ],
        ),
      ),
    );
  }
}
