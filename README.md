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
- 🔄 **Custom Border Radius** - Configure corner rounding for buttons and text fields
- ✅ **Built-in Validators** - Reusable validation functions for form fields

## Table of Contents

- [Installation](#installation)
- [Setup](#setup)
- [Components](#components)
  - [Buttons](#buttons)
  - [TextFields](#textfields)
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

#### Custom Border Radius

```dart
// Rounded corners (20.0 radius)
EwaButton.primary(
  label: 'Rounded Button',
  borderRadius: 20.0,
  onPressed: () async {},
);

// Pill-shaped button (30.0 radius)
EwaButton.secondary(
  label: 'Pill Button',
  borderRadius: 30.0,
  onPressed: () async {},
);

// Square corners (0.0 radius)
EwaButton.danger(
  label: 'Square Button',
  borderRadius: 0.0,
  onPressed: () async {},
);
```

### TextFields

EWA Kit provides customizable TextField components with multiple variants and built-in validation.

#### TextField Variants

```dart
// Primary TextField (main inputs)
EwaTextField.primary(
  hintText: 'Enter your name',
  onChanged: (value) {
    // Handle text change
  },
);

// Secondary TextField (alternative inputs)
EwaTextField.secondary(
  hintText: 'Enter your email',
  onChanged: (value) {
    // Handle text change
  },
);

// Tertiary TextField (less prominent inputs)
EwaTextField.tertiary(
  hintText: 'Enter your phone',
  onChanged: (value) {
    // Handle text change
  },
);

// Danger TextField (error states)
EwaTextField.danger(
  hintText: 'Enter your password',
  onChanged: (value) {
    // Handle text change
  },
);
```

#### TextField with Icons

```dart
// Prefix icon
EwaTextField.primary(
  hintText: 'Password',
  prefixIcon: const Icon(Icons.lock),
  obscureText: true,
  onChanged: (value) {
    // Handle text change
  },
);

// Suffix icon
EwaTextField.primary(
  hintText: 'Search',
  suffixIcon: const Icon(Icons.search),
  onChanged: (value) {
    // Handle text change
  },
);
```

#### Custom Border Radius

```dart
// Rounded corners (20.0 radius)
EwaTextField.primary(
  hintText: 'Rounded TextField',
  borderRadius: 20.0,
);

// Pill-shaped TextField (30.0 radius)
EwaTextField.secondary(
  hintText: 'Pill TextField',
  borderRadius: 30.0,
);

// Square corners (0.0 radius)
EwaTextField.tertiary(
  hintText: 'Square TextField',
  borderRadius: 0.0,
);
```

#### TextField Validation

EWA Kit includes a comprehensive set of reusable validators:

```dart
// Required field validation
EwaTextField.primary(
  hintText: 'Name (Required)',
  validator: EwaValidators.required,
);

// Email validation
EwaTextField.primary(
  hintText: 'Email',
  validator: (value) => EwaValidators.combine([
    EwaValidators.required,
    EwaValidators.email,
  ], value),
);

// Password validation
EwaTextField.primary(
  hintText: 'Password',
  obscureText: true,
  validator: EwaValidators.password,
);

// Phone number validation
EwaTextField.secondary(
  hintText: 'Phone Number',
  validator: EwaValidators.phoneNumber,
);

// Numeric validation with min/max
EwaTextField.tertiary(
  hintText: 'Age (18-100)',
  validator: (value) => EwaValidators.combine([
    EwaValidators.required,
    EwaValidators.numeric,
    (val) => EwaValidators.min(18, val),
    (val) => EwaValidators.max(100, val),
  ], value),
);

// Length validation
EwaTextField.primary(
  hintText: 'Username (3-20 chars)',
  validator: (value) => EwaValidators.combine([
    EwaValidators.required,
    (val) => EwaValidators.minLength(3, val),
    (val) => EwaValidators.maxLength(20, val),
  ], value),
);
```

Available validators include:

- `required` - Checks if a field is not empty
- `email` - Validates email format
- `minLength` - Validates minimum character length
- `maxLength` - Validates maximum character length
- `exactLength` - Validates exact character length
- `password` - Validates password strength
- `phoneNumber` - Validates phone number format
- `numeric` - Validates numeric input
- `min` - Validates minimum numeric value
- `max` - Validates maximum numeric value
- `url` - Validates URL format
- `creditCard` - Validates credit card number
- `combine` - Allows combining multiple validators

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
  borderRadius: 8.0,                   // Optional: Custom border radius
);
```

### All TextField Parameters

```dart
EwaTextField(
  hintText: 'Placeholder text',        // Optional: Placeholder text
  variant: EwaTextFieldVariant.primary,// Optional: TextField variant
  borderRadius: 8.0,                   // Optional: Custom border radius
  obscureText: false,                  // Optional: Hide text (passwords)
  enabled: true,                       // Optional: Enable/disable field
  readOnly: false,                     // Optional: Read-only field
  maxLines: 1,                         // Optional: Multi-line support
  onChanged: (value) {},               // Optional: Change callback
  onEditingComplete: () {},            // Optional: Editing complete callback
  onSubmitted: (value) {},             // Optional: Submit callback
  validator: (value) {},               // Optional: Validation function
  prefixIcon: const Icon(Icons.star),  // Optional: Prefix widget
  suffixIcon: const Icon(Icons.clear), // Optional: Suffix widget
  keyboardType: TextInputType.text,    // Optional: Keyboard type
  textInputAction: TextInputAction.done,// Optional: Input action
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

// Rounded primary button
EwaButton.primary(
  label: 'Rounded Button',
  borderRadius: 20.0,
  onPressed: () async {
    // Handle action
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

### Form Example with Validation

```dart
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: Column(
    children: [
      // Name field
      EwaTextField.primary(
        hintText: 'Full Name',
        validator: (value) => EwaValidators.combine([
          EwaValidators.required,
          (val) => EwaValidators.minLength(2, val),
        ], value),
      ),
      const SizedBox(height: 16),

      // Email field
      EwaTextField.secondary(
        hintText: 'Email Address',
        validator: (value) => EwaValidators.combine([
          EwaValidators.required,
          EwaValidators.email,
        ], value),
      ),
      const SizedBox(height: 16),

      // Password field
      EwaTextField.primary(
        hintText: 'Password',
        obscureText: true,
        prefixIcon: const Icon(Icons.lock),
        validator: EwaValidators.password,
      ),
      const SizedBox(height: 16),

      // Submit button
      EwaButton.primary(
        label: 'Submit',
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            // Process form data
          }
        },
      ),
    ],
  ),
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
