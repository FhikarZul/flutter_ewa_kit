# EWA Kit

A comprehensive Flutter UI component library with a robust design system that supports dark mode, responsive sizing, and customizable components.

## Features

- 🎨 **Customizable Buttons** - Multiple variants (primary, secondary, tertiary, danger)
- 🌓 **Dark Mode Support** - Automatic color adaptation based on app theme
- 📐 **Responsive Design** - Built-in support for different screen sizes
- 🎯 **Multiple Button Types** - Filled, outline, and ghost styles
- 📏 **Flexible Sizing** - Five size options (xs, sm, md, lg, xl)
- ⚡ **Debounce Support** - Prevent multiple rapid clicks
- 🔧 **Highly Configurable** - Extensive customization options

## Table of Contents

- [Installation](#installation)
- [Setup](#setup)
- [Components](#components)
  - [Buttons](#buttons)
- [Customization](#customization)
- [Dark Mode](#dark-mode)
- [Examples](#examples)

## Installation

Add this to your app's `pubspec.yaml` file:

```yaml
dependencies:
  ewa_kit:
    path: ./ewa_kit # Adjust path relative to your project
```

Then run:

```bash
flutter pub get
```

## Setup

### 1. Import the package

```dart
import 'package:ewa_kit/ewa_kit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
```

### 2. Initialize ScreenUtil (Required)

Wrap your MaterialApp with `ScreenUtilInit` in your `main.dart`:

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X size (recommended)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Your App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          themeMode: ThemeMode.system,
          home: const HomePage(),
        );
      },
    );
  }
}
```

## Components

### Buttons

EWA Kit provides versatile button components with multiple variants, types, and sizes.

#### Button Variants

```dart
// Primary Button (main actions)
EwaButton.primary(
  label: 'Primary Button',
  onPressed: () async {
    // Handle button press
  },
);

// Secondary Button (alternative actions)
EwaButton.secondary(
  label: 'Secondary Button',
  onPressed: () async {
    // Handle button press
  },
);

// Tertiary Button (less prominent actions)
EwaButton.tertiary(
  label: 'Tertiary Button',
  onPressed: () async {
    // Handle button press
  },
);

// Danger Button (destructive actions)
EwaButton.danger(
  label: 'Delete',
  onPressed: () async {
    // Handle delete
  },
);
```

#### Button Types

```dart
// Filled Button (default - solid background)
EwaButton.primary(
  label: 'Filled Button',
  type: EwaButtonType.filled,
  onPressed: () async {},
);

// Outline Button (transparent background with border)
EwaButton.primary(
  label: 'Outline Button',
  type: EwaButtonType.outline,
  onPressed: () async {},
);

// Ghost Button (transparent background, no border)
EwaButton.primary(
  label: 'Ghost Button',
  type: EwaButtonType.ghost,
  onPressed: () async {},
);
```

#### Button Sizes

```dart
// Extra Small
EwaButton.primary(
  label: 'XS',
  size: EwaButtonSize.xs,
  onPressed: () async {},
);

// Small
EwaButton.primary(
  label: 'Small',
  size: EwaButtonSize.sm,
  onPressed: () async {},
);

// Medium (default)
EwaButton.primary(
  label: 'Medium',
  size: EwaButtonSize.md,
  onPressed: () async {},
);

// Large
EwaButton.primary(
  label: 'Large',
  size: EwaButtonSize.lg,
  onPressed: () async {},
);

// Extra Large
EwaButton.primary(
  label: 'Extra Large',
  size: EwaButtonSize.xl,
  onPressed: () async {},
);
```

#### Button with Icons

```dart
// Leading icon
EwaButton.primary(
  label: 'Download',
  leading: const Icon(Icons.download, size: 20),
  onPressed: () async {},
);

// Trailing icon
EwaButton.primary(
  label: 'Next',
  trailing: const Icon(Icons.arrow_forward, size: 20),
  onPressed: () async {},
);

// Both leading and trailing icons
EwaButton.primary(
  label: 'Share',
  leading: const Icon(Icons.share, size: 20),
  trailing: const Icon(Icons.arrow_forward, size: 20),
  onPressed: () async {},
);
```

#### Full Width Button

```dart
// Set wrap to false for full-width button
EwaButton.primary(
  label: 'Full Width Button',
  wrap: false,
  onPressed: () async {},
);
```

#### Disabled Button

```dart
// Set enable to false to disable the button
EwaButton.primary(
  label: 'Disabled Button',
  enable: false,
  onPressed: () async {},
);

// Or set onPressed to null
EwaButton.primary(
  label: 'Disabled Button',
  onPressed: null,
);
```

#### Debounce Control

```dart
// Disable debounce (allow rapid clicks)
EwaButton.primary(
  label: 'No Debounce',
  debounce: false,
  onPressed: () async {},
);

// Enable debounce (default - prevents rapid clicks)
EwaButton.primary(
  label: 'With Debounce',
  debounce: true,
  onPressed: () async {},
);
```

## Customization

### All Button Parameters

```dart
EwaButton(
  label: 'Custom Button',              // Required: Button text
  onPressed: () async {},              // Required: Callback function
  variant: EwaButtonVariant.primary,   // Optional: Button variant
  type: EwaButtonType.filled,          // Optional: Button type
  size: EwaButtonSize.md,              // Optional: Button size
  enable: true,                        // Optional: Enable/disable button
  debounce: true,                      // Optional: Debounce control
  wrap: true,                          // Optional: Wrap content or full width
  leading: const Icon(Icons.star),     // Optional: Leading widget
  trailing: const Icon(Icons.arrow),   // Optional: Trailing widget
);
```

### Creating Custom Button Variants

You can combine different properties to create custom button styles:

```dart
// Large danger outline button with icon
EwaButton.danger(
  label: 'Delete Account',
  type: EwaButtonType.outline,
  size: EwaButtonSize.lg,
  leading: const Icon(Icons.delete_forever),
  onPressed: () async {
    // Handle delete
  },
);

// Small tertiary ghost button
EwaButton.tertiary(
  label: 'Cancel',
  type: EwaButtonType.ghost,
  size: EwaButtonSize.sm,
  onPressed: () async {
    // Handle cancel
  },
);
```

## Dark Mode

EWA Kit automatically adapts to your app's theme mode. All components support both light and dark themes out of the box.

### Enabling Dark Mode

```dart
MaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  ),
  darkTheme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  ),
  themeMode: ThemeMode.system, // or ThemeMode.light, ThemeMode.dark
  home: const HomePage(),
);
```

The buttons will automatically adjust their colors based on the current theme.

## Examples

### Complete Button Grid Example

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    // Primary buttons
    EwaButton.primary(
      label: 'Primary Filled',
      wrap: false,
      onPressed: () async {},
    ),
    const SizedBox(height: 10),
    EwaButton.primary(
      label: 'Primary Outline',
      type: EwaButtonType.outline,
      wrap: false,
      onPressed: () async {},
    ),
    const SizedBox(height: 10),

    // Secondary buttons
    EwaButton.secondary(
      label: 'Secondary Filled',
      wrap: false,
      onPressed: () async {},
    ),
    const SizedBox(height: 10),

    // Tertiary buttons
    EwaButton.tertiary(
      label: 'Tertiary',
      wrap: false,
      onPressed: () async {},
    ),
    const SizedBox(height: 10),

    // Danger button
    EwaButton.danger(
      label: 'Delete',
      leading: const Icon(Icons.delete, size: 20),
      wrap: false,
      onPressed: () async {},
    ),
  ],
)
```

### Form Buttons Example

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    EwaButton.tertiary(
      label: 'Cancel',
      type: EwaButtonType.ghost,
      onPressed: () async {
        // Handle cancel
      },
    ),
    const SizedBox(width: 12),
    EwaButton.primary(
      label: 'Submit',
      onPressed: () async {
        // Handle submit
      },
    ),
  ],
)
```

### Loading State Example

When `debounce` is enabled, the button shows a loading indicator during async operations:

```dart
EwaButton.primary(
  label: 'Save Changes',
  debounce: true, // Shows spinner while processing
  onPressed: () async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    // Button automatically re-enables after completion
  },
);
```

## Dependencies

EWA Kit depends on the following packages:

- `flutter_screenutil` - Responsive sizing
- `google_fonts` - Typography
- `tap_debouncer` - Button debounce functionality
- `flutter_spinkit` - Loading indicators
- `gap` - Spacing utilities

These are automatically installed when you add EWA Kit to your project.

## License

This project is licensed under the MIT License.

## Support

For issues, questions, or contributions, please contact the development team.
