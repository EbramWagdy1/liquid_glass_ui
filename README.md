# Liquid Glass UI

A production-ready Flutter UI Kit for creating stunning glassmorphism interfaces.

[![Pub Version](https://img.shields.io/pub/v/liquid_glass_kit)](https://pub.dev/packages/liquid_glass_kit)
[![Flutter Platform](https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter)](https://flutter.dev)

`liquid_glass_kit` provides a set of highly optimized, customizable, and ready-to-use components to build "Liquid Glass" interfaces. It focuses on performance, clean architecture, and ease of use.

## Features

- 🧊 **LiquidGlassContainer**: The core engine with configurable blur, opacity, and gradients.
- 🚀 **Performance Modes**: Built-in Quality Control (High, Medium, Low) to support low-end devices.
- 🌐 **Web Support**: Fully compatible using the **CanvasKit** renderer (`flutter run -d chrome --web-renderer canvaskit`). HTML renderer may have artifacts with blur filters.
- 🎨 **Theme System**: Full `ThemeExtension` support for seamless integration with `ThemeData`.
- 🧩 **UI Components**:
    - `LiquidGlassButton`, `LiquidGlassIconButton`, `LiquidGlassFAB`
    - `LiquidGlassCard`, `LiquidGlassSheet`
    - `LiquidGlassNavBar` with animated selection
    - `LiquidGlassIcon` with optional gradient effects

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  liquid_glass_kit: ^1.0.0
```

## Usage

### 1. Setup Theme

Add `LiquidGlassThemeData` to your app's `ThemeData` extensions. This allows you to control the global glass style and performance quality.

```dart
import 'package:liquid_glass_kit/liquid_glass_kit.dart';

MaterialApp(
  theme: ThemeData.dark().copyWith(
    extensions: [
      LiquidGlassThemeData(
        quality: LiquidGlassQuality.high, // Use .low for better performance on older devices
        blurSigma: 15.0,
        baseOpacity: 0.2,
        accentColor: Colors.pinkAccent,
      ),
    ],
  ),
  home: MyHomePage(),
);
```

### 2. Components

#### Glass Container
The basic building block.

```dart
LiquidGlassContainer(
  width: 200,
  height: 100,
  borderRadius: 16,
  blur: 20, // Override theme blur
  child: Text("Hello Glass"),
)
```

#### Buttons
Pressable buttons with built-in animations.

```dart
LiquidGlassButton(
  onPressed: () {},
  child: Text("Action"),
)

LiquidGlassIconButton(
  onPressed: () {},
  icon: Icon(Icons.star),
)
```

#### Navigation Bar
A floating glass navigation bar.

```dart
LiquidGlassNavBar(
  currentIndex: _index,
  onTap: (i) => setState(() => _index = i),
  items: [
    LiquidGlassNavBarItem(icon: Icons.home, label: "Home"),
    LiquidGlassNavBarItem(icon: Icons.search, label: "Search"),
  ],
)
```

## Performance & Quality

Glassmorphism relies on `BackdropFilter`, which can be expensive on the GPU. `liquid_glass_ui` provides a `LiquidGlassQuality` enum to manage this:

- **High**: Full blur effects.
- **Medium**: Reduced blur radius (lighter).
- **Low**: No blur. Falls back to simple opacity/color. Recommended for low-end Android devices.

You can change this globally in your theme:

```dart
LiquidGlassThemeData(
  quality: isLowEndDevice ? LiquidGlassQuality.low : LiquidGlassQuality.high,
)
```

## Contributing

Contributions are welcome! Please check the [repository](https://github.com/example/liquid_glass_ui) for more info.
