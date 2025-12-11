# How to Change Button Text Color in EWA Kit

## Overview

This guide shows different ways to customize button text colors in the EWA Kit.

## Methods

### Method 1: Global Text Color (All Buttons)

**File:** `lib/foundations/color/ewa_color_foundation.dart`

Change the default text color for ALL buttons:

```dart
class EwaColorFoundation {
  // Text colors
  static const Color textLight = Color(0xFFFFFFFF); // White for light theme
  static const Color textDark = Color(0xFF000000);   // Black for dark theme
  // ...
}
```

**Use when:** You want to change text color across the entire app.

---

### Method 2: Per Button Variant (Recommended)

**File:** `lib/ui/button/enums/ewa_button_variant.dart`

Customize text color for specific button variants:

```dart
primary => ButtonVariantData(
  backgroundColor: EwaColorFoundation.getPrimary(context),
  outlineBgColor: Colors.transparent,
  outlineBorderColor: EwaColorFoundation.getPrimary(context),
  borderColor: EwaColorFoundation.getPrimary(context),
  outlineFgColor: EwaColorFoundation.getPrimary(context),
  foregroundColor: Colors.white, // ✅ Text color for filled buttons
),
```

**Properties:**

- `foregroundColor` - Text color for **filled** buttons
- `outlineFgColor` - Text color for **outline** and **ghost** buttons

**Examples:**

```dart
// Primary with white text
foregroundColor: Colors.white,

// Secondary with black text
foregroundColor: Colors.black,

// Danger with custom color
foregroundColor: Color(0xFFFEFEFE),

// Tertiary with theme-aware color
foregroundColor: EwaColorFoundation.resolveColor(
  context,
  Colors.black,  // Light theme
  Colors.white,  // Dark theme
),
```

---

### Method 3: Per Button Instance

Wrap a single button with a Theme widget:

```dart
Theme(
  data: Theme.of(context).copyWith(
    textTheme: Theme.of(context).textTheme.apply(
      bodyColor: Colors.red, // Custom text color
    ),
  ),
  child: EwaButton.primary(
    label: 'Custom Color Button',
    onPressed: () async {},
  ),
)
```

**Use when:** You need different text colors for individual buttons.

---

### Method 4: Create New Variant

Add a new button variant with custom colors:

**Step 1:** Modify `lib/ui/button/enums/ewa_button_variant.dart`

```dart
enum EwaButtonVariant {
  primary,
  secondary,
  tertiary,
  danger,
  success; // ✅ New variant

  ButtonVariantData data(BuildContext context) => switch (this) {
    // ... existing variants ...
    success => ButtonVariantData(
      backgroundColor: const Color(0xFF10B981), // Green
      outlineBgColor: Colors.transparent,
      outlineBorderColor: const Color(0xFF10B981),
      borderColor: const Color(0xFF10B981),
      outlineFgColor: const Color(0xFF10B981),
      foregroundColor: Colors.white, // ✅ White text
    ),
  };
}
```

**Step 2:** Add factory constructor in `lib/ui/button/ewa_button.dart`

```dart
factory EwaButton.success({
  required String label,
  EwaButtonType type = EwaButtonType.filled,
  bool enable = true,
  Future<void> Function()? onPressed,
  EwaButtonSize size = EwaButtonSize.md,
  bool debounce = true,
  bool wrap = true,
  Widget? leading,
  Widget? trailing,
}) => EwaButton(
  variant: EwaButtonVariant.success,
  label: label,
  size: size,
  type: type,
  enable: enable,
  onPressed: onPressed,
  leading: leading,
  trailing: trailing,
  debounce: debounce,
  wrap: wrap,
);
```

**Step 3:** Use it

```dart
EwaButton.success(
  label: 'Success',
  onPressed: () async {},
)
```

---

## Color Reference

### Filled vs Outline/Ghost Buttons

```dart
// For FILLED buttons
foregroundColor: Colors.white,

// For OUTLINE and GHOST buttons
outlineFgColor: Colors.blue,
```

### Common Color Values

```dart
// Solid Colors
Colors.white           // #FFFFFF
Colors.black           // #000000
Colors.red             // #F44336
Colors.blue            // #2196F3
Colors.green           // #4CAF50

// Custom Hex Colors
Color(0xFFFFFFFF)      // White
Color(0xFF000000)      // Black
Color(0xFF0DAA4E)      // Custom green
Color(0xFF1E40AF)      // Custom blue

// Theme-aware Colors (adapts to dark mode)
EwaColorFoundation.resolveColor(
  context,
  Colors.black,  // Light theme color
  Colors.white,  // Dark theme color
)
```

---

## Examples

### Example 1: White Text on All Primary Buttons

**File:** `lib/ui/button/enums/ewa_button_variant.dart`

```dart
primary => ButtonVariantData(
  backgroundColor: EwaColorFoundation.getPrimary(context),
  // ...
  foregroundColor: Colors.white,        // Filled buttons
  outlineFgColor: EwaColorFoundation.getPrimary(context), // Outline buttons
),
```

### Example 2: Different Text Colors Per Variant

```dart
// Primary - White text
primary => ButtonVariantData(
  foregroundColor: Colors.white,
  // ...
),

// Secondary - Black text
secondary => ButtonVariantData(
  foregroundColor: Colors.black,
  // ...
),

// Danger - Yellow text
danger => ButtonVariantData(
  foregroundColor: Colors.yellow,
  // ...
),
```

### Example 3: Dark Mode Aware Text

```dart
tertiary => ButtonVariantData(
  backgroundColor: EwaColorFoundation.resolveColor(
    context,
    EwaColorFoundation.neutral200,  // Light mode
    EwaColorFoundation.neutral700,  // Dark mode
  ),
  foregroundColor: EwaColorFoundation.resolveColor(
    context,
    Colors.black,  // Black text in light mode
    Colors.white,  // White text in dark mode
  ),
),
```

---

## Testing Your Changes

After making changes, run:

```bash
cd ewa_kit
flutter analyze
flutter test
```

Both should pass with no errors.

---

## Best Practices

1. **Use theme-aware colors** for dark mode support
2. **Ensure good contrast** between text and background (WCAG AA: 4.5:1 ratio)
3. **Test in both light and dark modes**
4. **Keep consistency** across similar button types
5. **Document custom colors** in your code comments

---

## Troubleshooting

### Text color not changing?

1. Check you're modifying the correct property:

   - `foregroundColor` for filled buttons
   - `outlineFgColor` for outline/ghost buttons

2. Hot reload might not work - try hot restart:

   ```bash
   # Press 'R' in terminal or restart the app
   ```

3. Make sure you're using the correct variant:
   ```dart
   EwaButton.primary()  // Uses primary variant
   EwaButton.secondary() // Uses secondary variant
   ```

### Color looks wrong in dark mode?

Use `EwaColorFoundation.resolveColor()` for theme-aware colors:

```dart
foregroundColor: EwaColorFoundation.resolveColor(
  context,
  Color(0xFF000000), // Light mode color
  Color(0xFFFFFFFF), // Dark mode color
),
```

---

## Quick Reference

| Button Type | Text Color Property | Use Case                 |
| ----------- | ------------------- | ------------------------ |
| Filled      | `foregroundColor`   | Solid background buttons |
| Outline     | `outlineFgColor`    | Bordered buttons         |
| Ghost       | `outlineFgColor`    | Transparent buttons      |

---

Need more help? Check the [README.md](../README.md) for full documentation.
