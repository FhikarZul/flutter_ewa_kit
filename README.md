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
- 💰 **Currency Formatter** - Indonesian currency formatting for text fields
- 🗓️ **DateTime Converter** - Date/time parsing and formatting with Indonesian localization
- 📋 **Dialog Components** - Alert, confirmation, and custom dialogs
- 📝 **Toast Notifications** - Success, error, info, and warning notifications
- ⏳ **Loading Indicators** - Multiple animated loading components
- 📊 **Lazy Load** - Infinite scroll pagination component
- 📤 **HTTP Client** - Advanced networking with Dio, token management, and file download
- 📱 **Bottom Sheets** - Modal bottom sheets with customizable content
- 📚 **Typography System** - Consistent text styles and hierarchy
- 🎨 **Color Foundation** - Light and dark theme color palette

## Table of Contents

- [Installation](#installation)
- [Setup](#setup)
- [Components](#components)
  - [Buttons](#buttons)
  - [TextFields](#textfields)
  - [Dialogs](#dialogs)
  - [Toast Notifications](#toast-notifications)
  - [Loading Indicators](#loading-indicators)
  - [Bottom Sheets](#bottom-sheets)
  - [Lazy Load](#lazy-load)
- [Utilities](#utilities)
  - [DateTime Converter](#datetime-converter)
  - [HTTP Client](#http-client)
  - [Logging](#logging)
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

### 3. Initialize All EWA Kit Dependencies

Some components in EWA Kit require additional initialization for optimal performance:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize EWA Kit
  await EwaKit.initialize();

  runApp(const MyApp());
}
```

The `EwaKit.initialize()` method handles the initialization of all required dependencies including:

- ScreenUtil configuration
- Google Fonts loading
- Default theme settings
- Network client setup
- Logger configuration

This ensures all components work correctly and have access to the required resources.

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

#### Currency Formatter

EWA Kit includes a currency formatter for Indonesian financial applications:

```dart
// Currency formatted TextField
EwaTextField.primary(
  hintText: 'Amount',
  formatter: (value) => EwaFormatters.currencyFormatter(value),
  keyboardType: TextInputType.number,
);
```

### Dialogs

EWA Kit provides multiple dialog types for different use cases:

```dart
// Alert dialog
EwaDialog.showAlert(
  context: context,
  title: 'Alert',
  message: 'This is an alert message',
);

// Confirmation dialog
final result = await EwaDialog.showConfirmation(
  context: context,
  title: 'Confirm',
  message: 'Are you sure you want to proceed?',
);

if (result == true) {
  // User confirmed
} else {
  // User cancelled
}

// Custom dialog with actions
EwaDialog.show(
  context: context,
  title: 'Custom Dialog',
  message: 'This is a custom dialog with custom actions.',
  primaryAction: EwaDialogAction(
    label: 'OK',
    onPressed: () => Navigator.pop(context),
  ),
  secondaryAction: EwaDialogAction(
    label: 'Cancel',
    onPressed: () => Navigator.pop(context),
  ),
  tertiaryAction: EwaDialogAction(
    label: 'More',
    onPressed: () {
      // Custom action
    },
  ),
);
```

### Toast Notifications

Display temporary messages to users with different styles:

```dart
// Success toast
EwaToast.showSuccess(context, 'Operation completed successfully!');

// Error toast
EwaToast.showError(context, 'Something went wrong!');

// Info toast
EwaToast.showInfo(context, 'This is an information message.');

// Warning toast
EwaToast.showWarning(context, 'This is a warning message!');
```

### Loading Indicators

Multiple animated loading indicators for different contexts:

```dart
// Bouncing dots loader
EwaLoading.bouncingDots(size: 30);

// Wave loader
EwaLoading.wave(size: 30);

// Circular progress loader
EwaLoading.circularProgress(size: 30);

// Pulse loader
EwaLoading.pulse(size: 30);

// Loader with label
EwaLoading.bouncingDots(label: 'Loading data...', size: 40);
```

### Bottom Sheets

Modal bottom sheets for presenting options or content:

```dart
// Options bottom sheet
await EwaBottomSheet.showOptions(
  context: context,
  title: 'Choose an Option',
  options: [
    EwaBottomSheetOption(
      title: 'Option 1',
      subtitle: 'This is the first option',
      onTap: () {
        // Handle option 1
      },
    ),
    EwaBottomSheetOption(
      title: 'Option 2',
      subtitle: 'This is the second option',
      onTap: () {
        // Handle option 2
      },
    ),
  ],
);

// Custom bottom sheet
await EwaBottomSheet.show(
  context: context,
  title: 'Custom Content',
  content: Container(
    padding: EdgeInsets.all(16.sp),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('This is custom content in the bottom sheet'),
        const SizedBox(height: 16),
        EwaTextField.primary(hintText: 'Enter some text'),
      ],
    ),
  ),
  actions: [
    EwaBottomSheetAction(
      label: 'Cancel',
      onPressed: () => Navigator.pop(context),
    ),
    EwaBottomSheetAction(
      label: 'Save',
      onPressed: () {
        Navigator.pop(context);
        // Handle save
      },
    ),
  ],
);
```

### Lazy Load

Infinite scroll pagination component for loading data progressively:

```dart
EwaLazyLoad(
  page: 1,
  totalPage: 3,
  itemCount: 5,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text('Item ${index + 1}'),
      subtitle: Text('Subtitle for item ${index + 1}'),
    );
  },
  onChanged: (page) {
    // Handle page change
  },
  isLoading: false,
  onRefresh: () async {
    // Handle refresh
  },
  emptyMessage: 'Tidak ada data tersedia',
);
```

## Utilities

### DateTime Converter

Comprehensive date/time parsing and formatting utilities with Indonesian localization:

```dart
// Format to full date and time
final formatted = EwaDateTimeConverter.formatToFullDateTime(DateTime.now());

// Format to Indonesian date and time
final indonesianFormatted = EwaDateTimeConverter.formatToFullIndonesianDateTime(DateTime.now());

// Get time ago in English or Indonesian
final timeAgo = EwaDateTimeConverter.getTimeAgo(DateTime.now().subtract(Duration(hours: 2)));
final indonesianTimeAgo = EwaDateTimeConverter.getTimeAgo(DateTime.now().subtract(Duration(hours: 2)), useIndonesian: true);

// Parse date string
final parsedDate = EwaDateTimeConverter.parse("2023-12-25");

// Calculate age
final age = EwaDateTimeConverter.calculateAge(DateTime(1990, 1, 1));

// Get Indonesian day/month names
final dayName = EwaDateTimeConverter.getIndonesianDayName(DateTime.now());
final monthName = EwaDateTimeConverter.getIndonesianMonthName(DateTime.now());
```

### HTTP Client

Advanced HTTP client with token management, retry logic, and file download capabilities:

```dart
final httpClient = EwaHttpClient();

// Initialize with base URL and default headers
httpClient.init(
  baseUrl: 'https://api.example.com',
  defaultHeaders: {'Content-Type': 'application/json'},
);

// Set up token refresh callback
httpClient.refreshTokenCallback = () async {
  // Refresh tokens and return true if successful
  return true;
};

// Set up logout callback
httpClient.onLogout = () {
  // Handle logout when token refresh fails
};

// Make GET request
final response = await httpClient.get('/users/1');

// Make POST request
final response = await httpClient.post('/users', data: {'name': 'John'});

// Download file
final filePath = await httpClient.downloadFile(
  'https://example.com/image.jpg',
  '/path/to/save/image.jpg',
  onProgress: (received, total) {
    // Handle progress updates
  },
);

// Download file with resume capability
final filePath = await httpClient.downloadFileWithResume(
  'https://example.com/large-file.zip',
  '/path/to/save/large-file.zip',
  onProgress: (received, total) {
    // Handle progress updates
  },
);
```

### Logging

Colored logging utility for debugging:

```dart
// Info log
EwaLogger.info('This is an info message');

// Warning log
EwaLogger.warn('This is a warning message');

// Error log
EwaLogger.error('This is an error message');

// Debug log
EwaLogger.debug('This is a debug message');
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
  formatter: (value) {},               // Optional: Text formatter function
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

      // Currency field
      EwaTextField.primary(
        hintText: 'Amount',
        formatter: (value) => EwaFormatters.currencyFormatter(value),
        keyboardType: TextInputType.number,
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
- `dio` - HTTP client
- `path_provider` - File system access

These are automatically installed when you add EWA Kit to your project.

## License

This project is licensed under the MIT License.

## Support

For issues, questions, or contributions, please contact the development team.
