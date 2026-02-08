# EWA Kit

A comprehensive Flutter UI component library with a robust design system that supports dark mode, responsive sizing, and customizable components.

EWA Kit provides a complete set of pre-built, customizable UI components and utilities that follow consistent design principles. It simplifies Flutter development by offering ready-to-use components with built-in functionality, reducing boilerplate code and ensuring design consistency across your application.

## Key Benefits

- **Rapid Development**: Pre-built components reduce development time
- **Consistent Design**: Unified design system across all components
- **Easy Customization**: Highly configurable components to match your brand
- **Responsive Ready**: Built-in support for different screen sizes
- **Dark Mode Support**: Automatic theme adaptation
- **Well Tested**: Comprehensive test coverage for reliability

## Features

- 🎨 **Customizable Buttons** - Multiple variants (primary, secondary, tertiary, danger) with configurable border radius
- 🌓 **Dark Mode Support** - Automatic color adaptation based on app theme
- 📐 **Responsive Design** - Built-in support for different screen sizes using flutter_screenutil
- 🎯 **Multiple Button Types** - Filled, outline, and ghost styles
- 📏 **Flexible Sizing** - Five size options (xs, sm, md, lg, xl)
- ⚡ **Debounce Support** - Prevent multiple rapid clicks with visual feedback
- 🔧 **Highly Configurable** - Extensive customization options for all components
- 🔄 **Custom Border Radius** - Configure corner rounding for buttons and text fields
- ✅ **Built-in Validators** - Reusable validation functions for form fields with customizable error messages
- 💰 **Currency Formatter** - Robust Indonesian currency formatting for financial applications
- 🗓️ **DateTime Converter** - Comprehensive date/time parsing and formatting with Indonesian localization
- 📋 **Dialog Components** - Alert, confirmation, and custom dialogs
- 📝 **Toast Notifications** - Success, error, info, and warning notifications
- ⏳ **Loading Indicators** - Multiple animated loading components
- 📊 **Lazy Load** - Infinite scroll pagination component with pull-to-refresh
- 📤 **HTTP Client** - Advanced networking with Dio, token management, infinite retry logic, file download with resume capability, structured error handling, and optional caching
- 📱 **Bottom Sheets** - Modal bottom sheets with customizable content
- 📚 **Typography System** - Consistent text styles and hierarchy
- 🎨 **Color Foundation** - Light and dark theme color palette with automatic adaptation
- 📦 **Design System Foundations** - Complete design system with spacing, colors, and typography
- 🇮🇩 **Indonesian Market Focus** - Specialized features for Indonesian financial applications and localization
- 🛠️ **Utility Functions** - Comprehensive utilities for logging, date handling, and more
- 🌐 **Connectivity Checker** - Real-time network connectivity monitoring with automatic status updates and UI widgets

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
  - [Images](#images)
  - [Lazy Load](#lazy-load)
  - [Permission Utilities](#permission-utilities)
  - [Connectivity Checker](#connectivity-checker)
- [Foundations](#foundations)
  - [Color System](#color-system)
  - [Typography](#typography)
  - [Spacing System](#spacing-system)
- [Responsive Design](#responsive-design)
- [EwaApp Component](#ewaapp-component)
- [Utilities](#utilities)
  - [DateTime Converter](#datetime-converter)
  - [HTTP Client](#http-client)
  - [Logging](#logging)
  - [Connectivity Checker](#connectivity-checker-1)
- [Customization](#customization)
  - [Color Foundation](#color-foundation)
- [Dark Mode](#dark-mode)
- [Flexible Overrides](#flexible-overrides)
- [Best Practices](#best-practices)
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

Setting up EWA Kit in your Flutter application is straightforward. Follow these steps to integrate EWA Kit components and utilities into your project.

### 1. Import the Package

Import the main EWA Kit package in your Dart files where you want to use the components:

```dart
import 'package:ewa_kit/ewa_kit.dart';
```

Note: EWA Kit internally handles all third-party dependencies like `flutter_screenutil`, so you don't need to import them separately.

### 2. Initialize EWA Kit (Required)

Call `EwaKit.initialize()` before running your app. This is **async** and must be awaited:

```dart
void main() async {
  await EwaKit.initialize(() {
    runApp(const MyApp());
  });
}
```

The `EwaKit.initialize()` method handles:

- Flutter bindings
- Date formatting (uses `EwaKitConfig.defaultLocale`, default: `id_ID`)
- Global error handling and logging

### 3. Wrap with EwaApp (Required)

EWA Kit uses `flutter_screenutil` for responsive design. Wrap your MaterialApp with `EwaApp`:

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EwaApp(
      // designSize is optional - uses EwaKitConfig.designSize if not specified
      child: MaterialApp(
        title: 'Your App',
        theme: EwaTheme.light(),
        darkTheme: EwaTheme.dark(),
        themeMode: ThemeMode.system,
        home: const HomePage(),
      ),
    );
  }
}
```

### 4. Configuration (Optional)

Customize EWA Kit via `EwaKitConfig` **before** `runApp()`:

```dart
void main() async {
  // Optional: Configure before init
  EwaKitConfig.designSize = const Size(414, 896); // iPhone 11 Pro Max
  EwaKitConfig.debounceDuration = const Duration(milliseconds: 300);
  EwaKitConfig.defaultLocale = 'en_US';

  await EwaKit.initialize(() {
    runApp(const MyApp());
  });
}
```

### 5. Theme Integration

Use `EwaTheme` for pre-configured light/dark themes with EWA Kit colors:

```dart
MaterialApp(
  theme: EwaTheme.light(),
  darkTheme: EwaTheme.dark(),
  themeMode: ThemeMode.system,
  home: const HomePage(),
);
```

Or build custom themes with `EwaColorFoundation`:

```dart
MaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: EwaColorFoundation.primaryLight,
      primary: EwaColorFoundation.primaryLight,
    ),
    useMaterial3: true,
  ),
  home: const HomePage(),
);
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

All EWA Kit buttons support customizable border radius, allowing you to create buttons with rounded corners, pill shapes, or sharp square corners. This feature provides flexibility in matching your application's design language:

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

// Subtle rounding (8.0 radius) - default for most buttons
EwaButton.primary(
  label: 'Subtly Rounded',
  borderRadius: 8.0,
  onPressed: () async {},
);

// Fully circular button (height/2 radius)
EwaButton.primary(
  label: 'Circular',
  borderRadius: 24.0, // Half of button height for circular shape
  onPressed: () async {},
);
```

The border radius parameter accepts any double value, giving you complete control over the button's corner appearance. When no border radius is specified, buttons use the default radius defined in their size configuration.

### TextFields

EWA Kit provides customizable TextField components with multiple variants, built-in validation, and specialized formatters for financial applications.

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

#### TextField Custom Colors

Override background and border colors when needed. Use `EwaColorFoundation.resolveColor` for dark mode support:

```dart
EwaTextField.primary(
  hintText: 'Custom styled',
  fillColor: EwaColorFoundation.resolveColor(
    context, EwaColorFoundation.neutral100, EwaColorFoundation.neutral700,
  ),
  enabledBorderColor: EwaColorFoundation.getSecondary(context),
  focusedBorderColor: EwaColorFoundation.getPrimary(context),
);
```

#### TextField Validation

EWA Kit includes a comprehensive set of reusable validators with customizable error messages:

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
  prefixIcon: const Icon(Icons.lock),
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

// Credit card validation
EwaTextField.primary(
  hintText: 'Credit Card Number',
  validator: EwaValidators.creditCard,
);

// URL validation
EwaTextField.primary(
  hintText: 'Website URL',
  validator: EwaValidators.url,
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
- `creditCard` - Validates credit card number using Luhn algorithm
- `combine` - Allows combining multiple validators

#### Currency Formatter

EWA Kit includes a robust currency formatter specifically designed for Indonesian financial applications:

```dart
// Currency formatted TextField
EwaTextField.primary(
  hintText: 'Amount',
  formatter: (value) => EwaFormatters.currencyFormatter(value),
  keyboardType: TextInputType.number,
);

// Custom currency formatter with parameters
EwaTextField.primary(
  hintText: 'USD Amount',
  formatter: (value) => EwaFormatters.currencyFormatter(
    value,
    currencySymbol: '$',
    thousandSeparator: ',',
    decimalSeparator: '.',
    decimalDigits: 2,
  ),
  keyboardType: TextInputType.number,
);
```

The currency formatter is designed to be crash-safe and handles various edge cases in numeric input formatting. It automatically extracts digits from input and formats them according to the specified currency standards.

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

````dart
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

### Images

Display network and asset images with caching, placeholder, and error handling:

```dart
// Network image with caching
EwaImage.network(
  imageUrl: 'https://example.com/image.jpg',
  width: 200,
  height: 200,
  borderRadius: 12.0,
);

// Network image with custom placeholder and error widgets
EwaImage.network(
  imageUrl: 'https://example.com/image.jpg',
  width: 200,
  height: 200,
  placeholder: Container(
    width: 200,
    height: 200,
    color: Colors.grey[300],
    child: const Icon(Icons.image, color: Colors.grey),
  ),
  errorWidget: Container(
    width: 200,
    height: 200,
    color: Colors.red[100],
    child: const Icon(Icons.broken_image, color: Colors.red),
  ),
);

// Asset image
EwaImage.asset(
  assetPath: 'assets/images/placeholder.png',
  width: 150,
  height: 150,
);

// Network image with no progress indicator
EwaImage.network(
  imageUrl: 'https://example.com/image.jpg',
  width: 200,
  height: 200,
  showProgressIndicator: false,
);
````

EwaImage provides:

- **Network image caching**: Automatic caching of network images with CachedNetworkImage
- **Placeholder support**: Customizable loading placeholders
- **Error handling**: Customizable error widgets when images fail to load
- **Progress indicators**: Optional circular progress indicators during loading
- **Border radius**: Configurable border radius for rounded corners
- **Asset support**: Support for local asset images as well as network images
- **Responsive sizing**: Support for responsive width and height using flutter_screenutil

````

### Lazy Load

Infinite scroll pagination component for loading data progressively. Perfect for implementing paginated lists that load more data as the user scrolls:

```dart
EwaLazyLoad(
  page: 1,           // Current page number
  totalPage: 3,      // Total number of pages
  itemCount: 5,      // Number of items on current page
  itemBuilder: (context, index) {
    return ListTile(
      title: Text('Item ${index + 1}'),
      subtitle: Text('Subtitle for item ${index + 1}'),
    );
  },
  onChanged: (page) {
    // Handle page change
    // This callback is triggered when user reaches the end of the list
    // and more data needs to be loaded
    loadData(page);
  },
  isLoading: false,  // Set to true when loading data
  onRefresh: () async {
    // Handle pull-to-refresh
    // Typically used to reload the first page of data
    await refreshData();
  },
  emptyMessage: 'Tidak ada data tersedia', // Message to show when no data is available
);
````

#### Key Features

- **Automatic Pagination**: Automatically detects when user has scrolled to the end and triggers the `onChanged` callback
- **Loading States**: Visual indicators for loading states with customizable loading widgets
- **Pull-to-Refresh**: Built-in support for refreshing the entire list
- **Empty States**: Customizable message for when no data is available
- **Error Handling**: Graceful handling of network errors and data loading failures

#### Usage Tips

1. Set `isLoading` to `true` when fetching data and `false` when complete
2. Update `page`, `totalPage`, and `itemCount` based on API response
3. Use `onRefresh` to implement pull-to-refresh functionality
4. Customize the `emptyMessage` to match your application's language and design
5. Handle errors in your `onChanged` callback and display appropriate UI feedback

````

### Permission Utilities

Request and manage device permissions with built-in UI components for a consistent user experience:

```dart
// Request a single permission with UI
final granted = await EwaPermissionHelper.requestPermission(
  Permission.camera,
  context: context,
  title: 'Camera Permission Required',
  message: 'This app needs access to your camera to take photos',
);

if (granted) {
  // Permission granted, proceed with camera functionality
} else {
  // Permission denied, handle accordingly
}

// Request specific common permissions
final cameraGranted = await EwaPermissionHelper.requestCameraPermission(
  context: context,
);

final storageGranted = await EwaPermissionHelper.requestStoragePermission(
  context: context,
);

final locationGranted = await EwaPermissionHelper.requestLocationPermission(
  context: context,
);

final microphoneGranted = await EwaPermissionHelper.requestMicrophonePermission(
  context: context,
);

final notificationGranted = await EwaPermissionHelper.requestNotificationPermission(
  context: context,
);

// Check permission status
final isCameraGranted = await EwaPermissionHelper.isPermissionGranted(Permission.camera);
final isCameraDenied = await EwaPermissionHelper.isPermissionDenied(Permission.camera);
final isCameraPermanentlyDenied = await EwaPermissionHelper.isPermissionPermanentlyDenied(Permission.camera);
final isCameraRestricted = await EwaPermissionHelper.isPermissionRestricted(Permission.camera);

// Request multiple permissions at once
final results = await EwaPermissionHelper.requestPermissions(
  [Permission.camera, Permission.storage, Permission.location],
  context: context,
);

// Use the permission widget for UI
EwaPermissionWidget(
  permission: Permission.camera,
  title: 'Camera Access',
  description: 'This app needs access to your camera to take photos',
  onStatusChanged: (status) {
    // Handle status change
  },
)

// Use the permissions widget for multiple permissions
EwaPermissionsWidget(
  permissions: [
    EwaPermissionData(
      permission: Permission.camera,
      title: 'Camera',
      description: 'Access to take photos',
    ),
    EwaPermissionData(
      permission: Permission.storage,
      title: 'Storage',
      description: 'Access to save photos',
    ),
  ],
  onStatusChanged: (statuses) {
    // Handle all status changes
  },
)
```

EwaPermissionHelper provides:

- **Permission request helpers**: Simplified methods for requesting common permissions
- **UI integration**: Built-in dialogs for permission requests using EWA Kit design
- **Status checking**: Methods to check current permission status
- **Multiple permission handling**: Request several permissions at once
- **Settings redirection**: Automatically guide users to app settings when permissions are permanently denied
- **Permission widgets**: Ready-to-use UI components for displaying permission status

The permission utilities handle all the complexity of the permission_handler package while providing a consistent UI experience that matches the rest of the EWA Kit components.

````

### Connectivity Checker

Real-time network connectivity monitoring with automatic status updates, UI widgets, and support for both Indonesian and English languages. Monitor WiFi, mobile data, ethernet, VPN, and actual internet access:

```dart
// Initialize connectivity checker (usually in main.dart or app startup)
await EwaConnectivityChecker.instance.initialize();

// Check current connection status
final hasConnection = await EwaConnectivityChecker.instance.hasConnection;
final hasInternet = await EwaConnectivityChecker.instance.hasInternetAccess;

// Check specific connection type
final isWifi = await EwaConnectivityChecker.instance.isWifi;
final isMobile = await EwaConnectivityChecker.instance.isMobile;
final isOffline = await EwaConnectivityChecker.instance.isOffline;

// Listen to real-time connectivity changes
EwaConnectivityChecker.instance.connectivityStream.listen((status) {
  switch (status) {
    case EwaConnectivityStatus.wifi:
      print('Connected via WiFi');
      break;
    case EwaConnectivityStatus.mobile:
      print('Connected via Mobile Data');
      break;
    case EwaConnectivityStatus.offline:
      print('Device is offline');
      break;
    case EwaConnectivityStatus.noInternet:
      print('Connected but no internet access');
      break;
    default:
      print('Other connection type');
  }
});

// Display connectivity status widget (Indonesian)
EwaConnectivityWidget(
  showIcon: true,
  showText: true,
  useIndonesian: true,
  onStatusChanged: (status) {
    print('Status changed to: $status');
  },
)

// Display connectivity status widget (English, compact)
EwaConnectivityWidget(
  showIcon: true,
  showText: true,
  useIndonesian: false,
  compact: true,
)

// Wrap your app with automatic offline banner
Scaffold(
  body: EwaConnectivityBanner(
    showAtTop: true,  // or false for bottom
    useIndonesian: true,
    onlyShowWhenOffline: false,  // also show when no internet
    child: YourContentWidget(),
  ),
)

// Custom banner
EwaConnectivityBanner(
  customBanner: Container(
    color: Colors.red,
    padding: EdgeInsets.all(8),
    child: Text('Custom offline message'),
  ),
  child: YourContent(),
)

// Block actions when offline
EwaButton.primary(
  label: 'Submit',
  onPressed: () async {
    final hasInternet = await EwaConnectivityChecker.instance.hasInternetAccess;

    if (!hasInternet) {
      EwaToast.showError(context, 'Tidak ada koneksi internet!');
      return;
    }

    // Proceed with API call
    await submitData();
  },
)
```

#### Available Connectivity Status

- `EwaConnectivityStatus.wifi` - Connected to WiFi with internet access
- `EwaConnectivityStatus.mobile` - Connected to mobile data with internet access
- `EwaConnectivityStatus.ethernet` - Connected to ethernet with internet access
- `EwaConnectivityStatus.vpn` - Connected to VPN with internet access
- `EwaConnectivityStatus.bluetooth` - Connected via Bluetooth
- `EwaConnectivityStatus.noInternet` - Has network connection but no internet access
- `EwaConnectivityStatus.offline` - No network connection at all

EwaConnectivityChecker provides:

- **Real-time monitoring**: Stream-based connectivity status updates
- **Actual internet check**: Distinguishes between network connection and actual internet access
- **Multiple connection types**: WiFi, Mobile Data, Ethernet, VPN, Bluetooth
- **UI widgets**: Ready-to-use widgets for displaying connection status
- **Automatic banners**: Show/hide banners based on connectivity
- **Bilingual support**: Indonesian and English status descriptions
- **Helper methods**: Convenient methods to check various connection states

````

## Utilities

### DateTime Converter

Comprehensive date/time parsing and formatting utilities with Indonesian localization. Supports both international and Indonesian formatting standards with fallback mechanisms:

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

// Format with various options
final humanReadable = EwaDateTimeConverter.formatToHumanReadable(DateTime.now());
final shortDate = EwaDateTimeConverter.formatToShortDate(DateTime.now());
final timeOnly = EwaDateTimeConverter.formatToTime(DateTime.now());
final iso8601 = EwaDateTimeConverter.formatToIso8601(DateTime.now());

// Indonesian formats
final indoDate = EwaDateTimeConverter.formatToIndonesian(DateTime.now());
final shortIndoDate = EwaDateTimeConverter.formatToShortIndonesian(DateTime.now());
final indoTime = EwaDateTimeConverter.formatToIndonesianTime(DateTime.now());

// Date utilities
final isToday = EwaDateTimeConverter.isToday(DateTime.now());
final isYesterday = EwaDateTimeConverter.isYesterday(DateTime.now());
final startOfDay = EwaDateTimeConverter.startOfDay(DateTime.now());
final endOfDay = EwaDateTimeConverter.endOfDay(DateTime.now());
final age = EwaDateTimeConverter.calculateAge(birthDate);
final durationFormatted = EwaDateTimeConverter.formatDuration(Duration(hours: 2, minutes: 30));
```

The DateTime converter includes robust error handling with automatic fallback to English formatting if Indonesian locale data is not properly initialized.

### HTTP Client

Advanced HTTP client with token management, infinite retry logic for transient failures, file download capabilities, optional caching for offline support, and request cancellation. Built on top of Dio with additional enterprise-grade features.

#### Initialization

Initialize the HTTP client with your API configuration:

```dart
final httpClient = EwaHttpClient();

// Initialize with base URL and default headers
await httpClient.init(
  baseUrl: 'https://api.example.com',
  defaultHeaders: {'Content-Type': 'application/json'},
  enableCaching: true,
  connectTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
  // Optional: Configure retry behavior (defaults: maxRetries=3, retryDelay=1s, maxRetryDuration=2min)
  maxRetries: 5,
  retryDelay: const Duration(seconds: 2),
  maxRetryDuration: const Duration(minutes: 3),
);
```

#### Authentication

Handle token-based authentication with automatic refresh:

```dart
// Set up token refresh callback
httpClient.refreshTokenCallback = () async {
  // Refresh tokens and return true if successful
  // This will be automatically called when a 401 response is received
  return true;
};

// Set up logout callback
httpClient.onLogout = () {
  // Handle logout when token refresh fails
  // This will be called if token refresh also fails
};

// Manually set authentication tokens
httpClient.setTokens('access_token', 'refresh_token');

// Clear authentication tokens
httpClient.clearTokens();
```

#### Making Requests

Perform HTTP requests with cancellation support:

```dart
// Make GET request with cancellation support
final requestId = 'unique_request_id';
final response = await httpClient.get(
  '/users/1',
  requestId: requestId, // Optional: for request cancellation
);

// Cancel a specific request
httpClient.cancelRequest(requestId);

// Cancel all ongoing requests
httpClient.cancelAllRequests();

// Make POST request
final response = await httpClient.post('/users', data: {'name': 'John'});

// Make PUT request
final response = await httpClient.put('/users/1', data: {'name': 'Jane'});

// Make DELETE request
final response = await httpClient.delete('/users/1');
```

#### File Downloads

Download files with progress tracking and resume capability:

```dart
// Download file
final filePath = await httpClient.downloadFile(
  'https://example.com/image.jpg',
  '/path/to/save/image.jpg',
  onProgress: (received, total) {
    // Handle progress updates
    print('Downloaded: ${received}/${total} bytes');
  },
);

// Download file with resume capability
// Automatically resumes from where it left off if the download is interrupted
final filePath = await httpClient.downloadFileWithResume(
  'https://example.com/large-file.zip',
  '/path/to/save/large-file.zip',
  onProgress: (received, total) {
    // Handle progress updates
    print('Downloaded: ${received}/${total} bytes');
  },
);
```

#### Caching

Enable caching for offline support and improved performance:

```dart
// Enable/disable caching dynamically
httpClient.enableCaching();   // Enable caching
httpClient.disableCaching();  // Disable caching
print(httpClient.isCachingEnabled); // Check if caching is enabled

// Clear all cached data
await httpClient.clearCache();

// Configure cache behavior per request
final response = await httpClient.get(
  '/users',
  options: EwaCacheManager().buildCacheOptions(
    policy: CachePolicy.forceCache, // Force use of cache
    maxStale: Duration(days: 1),    // Allow stale data up to 1 day
  ),
);
```

#### Retry Logic

The HTTP client implements configurable retry logic for transient failures with exponential backoff:

- Automatically retries failed requests due to network issues (connection timeout, 5xx errors)
- Configurable via `init()`: `maxRetries` (default: 3), `retryDelay` (default: 1s), `maxRetryDuration` (default: 2 min)
- Implements exponential backoff to avoid overwhelming servers
- Visible retry counters for debugging

#### Error Handling

EWA Kit provides structured error handling for API responses through `EwaResponseException`. This allows you to map HTTP status codes to user-friendly error messages and categorize errors for appropriate handling.

```dart
try {
  final response = await httpClient.get('/users/1');
  // Handle success
} on DioException catch (e) {
  // Convert DioException to structured error
  final ewaException = e.toEwaResponseException();
  ewaException.logError(); // Log for debugging

  // Show user-friendly error message
  showErrorDialog(ewaException.message);

  // Handle specific error types
  switch (ewaException.errorType) {
    case EwaErrorType.unauthorized:
      // Redirect to login
      break;
    case EwaErrorType.network:
      // Show offline message
      break;
    default:
      // Handle other errors
      break;
  }
}
```

The error handling system provides:

- Structured error types for different categories of errors
- User-friendly error messages in Indonesian
- Automatic parsing of API error responses
- Easy logging of detailed error information
- Extension on DioException for seamless integration

### Logging

Colored logging utility for debugging with different log levels and enhanced formatting:

```dart
// Debug log (white) - Detailed information for diagnosing problems
EwaLogger.debug('Processing user data: ${userData.toJson()}');

// Info log (blue) - General information about application progress
EwaLogger.info('User logged in successfully: ${user.id}');

// Warning log (yellow) - Potentially harmful situations
EwaLogger.warn('Low memory warning: ${memoryUsage}%');

// Error log (red) - Error events that might still allow the application to continue running
EwaLogger.error('Failed to load user data', error: e, stackTrace: s);

// Fatal log (bright red) - Very severe error events that will presumably lead the application to abort
EwaLogger.fatal('Critical system failure', error: e, stackTrace: s);

// Trace log (gray) - Fine-grained informational events than the debug level
EwaLogger.trace('Entering function validateUserData');
```

The logger provides colored output for better readability in console logs and includes timestamps for easier debugging. All log messages are automatically prefixed with the log level emoji for quick visual identification.

### Connectivity Checker

Comprehensive real-time network connectivity monitoring with automatic status detection and UI integration. Supports both network connection detection and actual internet access verification:

```dart
// Initialize the connectivity checker
await EwaConnectivityChecker.instance.initialize();

// Get current connectivity status
final currentStatus = EwaConnectivityChecker.instance.currentStatus;

// Check various connection states
final hasConnection = await EwaConnectivityChecker.instance.hasConnection;
final hasInternet = await EwaConnectivityChecker.instance.hasInternetAccess;
final isWifi = await EwaConnectivityChecker.instance.isWifi;
final isMobile = await EwaConnectivityChecker.instance.isMobile;
final isOffline = await EwaConnectivityChecker.instance.isOffline;

// Listen to connectivity changes
EwaConnectivityChecker.instance.connectivityStream.listen((status) {
  print('Connectivity changed to: ${status}');
});

// Get human-readable status description
final description = EwaConnectivityChecker.instance.getStatusDescription(
  EwaConnectivityStatus.wifi,
  useIndonesian: true, // Use Indonesian language
);
// Output: "Terhubung ke WiFi"

// Display connectivity widget
EwaConnectivityWidget(
  showIcon: true,
  showText: true,
  useIndonesian: true,
  compact: false,
  onStatusChanged: (status) {
    // Handle status changes
  },
)

// Use connectivity banner
EwaConnectivityBanner(
  showAtTop: true,
  useIndonesian: true,
  onlyShowWhenOffline: false,
  child: YourWidget(),
)
```

The connectivity checker provides:

- **Real-time monitoring** with stream-based updates
- **Dual-layer detection**: Network connection AND actual internet access
- **Multiple connection types**: WiFi, Mobile Data, Ethernet, VPN, Bluetooth
- **Bilingual support**: Indonesian and English descriptions
- **UI components**: Ready-to-use widgets and banners
- **Singleton pattern**: Consistent state across the app

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
  controller: controller,              // Optional: TextEditingController
  focusNode: focusNode,                // Optional: FocusNode (e.g. for next-field focus)
  labelText: 'Field label',            // Optional: Floating label
  hintText: 'Placeholder text',        // Optional: Placeholder text
  helperText: 'Helper text below',     // Optional: Helper text
  counterText: '0/100',                // Optional: Override counter ('' to hide when maxLength set)
  variant: EwaTextFieldVariant.primary,// Optional: TextField variant
  borderRadius: 8.0,                   // Optional: Custom border radius
  fillColor: Colors.grey.shade100,     // Optional: Override background (use EwaColorFoundation for dark mode)
  enabledBorderColor: Colors.blue,     // Optional: Override border when unfocused
  focusedBorderColor: Colors.blue,     // Optional: Override border when focused
  obscureText: false,                  // Optional: Hide text (passwords)
  enabled: true,                       // Optional: Enable/disable field
  readOnly: false,                     // Optional: Read-only field
  autofocus: false,                    // Optional: Auto-focus on build
  maxLines: 1,                         // Optional: Multi-line support
  maxLength: 100,                      // Optional: Character limit
  textCapitalization: TextCapitalization.none, // Optional: Text capitalization
  inputFormatters: [...],              // Optional: Flutter input formatters
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

### Color Foundation

EWA Kit provides a comprehensive color foundation that supports both light and dark themes:

```dart
// Using EWA Kit colors in your theme
MaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: EwaColorFoundation.primaryLight,
      primary: EwaColorFoundation.primaryLight,
      secondary: EwaColorFoundation.secondaryLight,
      error: EwaColorFoundation.errorLight,
    ),
  ),
  darkTheme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: EwaColorFoundation.primaryDark,
      primary: EwaColorFoundation.primaryDark,
      secondary: EwaColorFoundation.secondaryDark,
      error: EwaColorFoundation.errorDark,
      brightness: Brightness.dark,
    ),
  ),
);

// Using EWA Kit colors directly in widgets
Container(
  color: EwaColorFoundation.resolveColor(
    context,
    EwaColorFoundation.primaryLight,  // Light theme color
    EwaColorFoundation.primaryDark,   // Dark theme color
  ),
  child: Text('Themed Text'),
);

// Using success and warning colors
Container(
  color: EwaColorFoundation.resolveColor(
    context,
    EwaColorFoundation.successLight,
    EwaColorFoundation.successDark,
  ),
  child: Text('Success Message'),
);

Container(
  color: EwaColorFoundation.resolveColor(
    context,
    EwaColorFoundation.warningLight,
    EwaColorFoundation.warningDark,
  ),
  child: Text('Warning Message'),
);
```

The color foundation includes:

- **Primary Colors**: Main brand colors for primary actions
- **Secondary Colors**: Supporting colors for secondary actions
- **Neutral Colors**: Grayscale colors for backgrounds, text, and borders (neutral50 to neutral900)
- **Error Colors**: Colors for error states and destructive actions
- **Success Colors**: Colors for success states and positive actions
- **Warning Colors**: Colors for warning states and cautionary actions
- **Text Colors**: Optimized colors for text in light and dark themes
- **Background Colors**: Surface colors for light and dark themes

All colors automatically adapt to light and dark themes, ensuring consistent appearance across different theme modes.

## Foundations

EWA Kit is built on a robust design system foundation that ensures consistency across all components. The foundations include:

### Color System

A comprehensive color palette that supports both light and dark themes with automatic adaptation:

```dart
// Using EWA Kit colors in your theme
MaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: EwaColorFoundation.primaryLight,
      primary: EwaColorFoundation.primaryLight,
      secondary: EwaColorFoundation.secondaryLight,
      error: EwaColorFoundation.errorLight,
    ),
  ),
  darkTheme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: EwaColorFoundation.primaryDark,
      primary: EwaColorFoundation.primaryDark,
      secondary: EwaColorFoundation.secondaryDark,
      error: EwaColorFoundation.errorDark,
      brightness: Brightness.dark,
    ),
  ),
);
```

### Typography

Consistent text styles and hierarchy for readable content:

```dart
// Using EWA Kit typography
Text(
  'Heading 1',
  style: EwaTypography.heading1,
);

Text(
  'Body text',
  style: EwaTypography.bodyMedium,
);
```

### Spacing System

Consistent spacing using the 8-point grid system:

```dart
// Using EWA Kit spacing
Padding(
  padding: EdgeInsets.all(EwaDimension.size16),
  child: Text('Consistently spaced content'),
);

Gap(EwaDimension.size8); // Using gap package for consistent spacing
```

## Responsive Design

EWA Kit leverages `flutter_screenutil` to provide responsive design capabilities that adapt to different screen sizes and densities:

```dart
// Initialize ScreenUtil in your main.dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EwaApp(
      designSize: const Size(375, 812), // Reference design size (iPhone X)
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'Your App',
        home: const HomePage(),
      ),
    );
  }
}
```

### Using Responsive Units

```dart
// Responsive sizing
Container(
  width: 100.w,  // 100 pixels wide relative to screen width
  height: 50.h,  // 50 pixels high relative to screen height
  child: Text(
    'Responsive Text',
    style: TextStyle(
      fontSize: 16.sp, // Font size that scales with screen density
    ),
  ),
);

// Responsive padding
Padding(
  padding: EdgeInsets.all(16.r), // Padding that scales responsively
  child: Text('Content'),
);
```

## EwaApp Component

The `EwaApp` component initializes `flutter_screenutil` for responsive design:

```dart
EwaApp(
  designSize: const Size(375, 812), // Optional - uses EwaKitConfig.designSize if omitted
  minTextAdapt: true,
  splitScreenMode: true,
  child: MaterialApp(...),
)
```

### Parameters

- `designSize`: Optional. Reference design size (falls back to `EwaKitConfig.designSize`)
- `minTextAdapt`: Adapt text size to screen (default: true)
- `splitScreenMode`: Support split screen mode (default: true)
- `child`: The widget to wrap (typically MaterialApp)

## EwaTheme

Pre-configured themes using EWA Kit colors:

```dart
MaterialApp(
  theme: EwaTheme.light(),
  darkTheme: EwaTheme.dark(),
  themeMode: ThemeMode.system,
  home: const HomePage(),
);
```

## EwaKitConfig

Global configuration for EWA Kit components. Set **before** `EwaKit.initialize()`:

| Property | Default | Description |
|----------|---------|-------------|
| `designSize` | 375×812 | Reference size for responsive scaling |
| `debounceDuration` | 500ms | Button debounce duration |
| `defaultLocale` | id_ID | Locale for date formatting |
| `borderWidth` | 1.0 | Default button border width |
| `spinnerSize` | 20.0 | Loading spinner size |
| `debugMode` | false | Enable debug logging |

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

### Example App

Run the included example app to explore all EWA Kit components interactively:

```bash
cd ewa_kit/example
flutter run
```

The example includes demos for buttons, dialogs, toasts, HTTP client, and more.

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
- `dio_cache_interceptor` - HTTP caching support
- `path_provider` - File system access
- `cached_network_image` - Image caching
- `permission_handler` - Device permissions management
- `connectivity_plus` - Network connectivity monitoring
- `internet_connection_checker_plus` - Internet access verification
- `intl` - Internationalization support
- `logger` - Enhanced logging

These are automatically installed when you add EWA Kit to your project.

## License

This project is licensed under the MIT License.

## Flexible Overrides

Override default services for testing or custom implementations. No changes needed in consuming code.

```dart
// For testing — use mocks
setUp(() {
  EwaKitOverrides.httpClient = MockHttpClient();
  EwaKitOverrides.connectivityChecker = MockConnectivityChecker();
});
tearDown(() {
  EwaKitOverrides.reset();  // or EwaKitConfig.resetToDefaults()
});

// For custom implementation
void main() {
  EwaKitOverrides.httpClient = MyCustomHttpClient();
  runApp(MyApp());
}
```

Supported overrides: `EwaHttpClient`, `EwaConnectivityChecker`

## Best Practices

To get the most out of EWA Kit, follow these best practices:

1. **Initialize Properly**: Always call `EwaKit.initialize()` before running your app
2. **Use Theme Integration**: Leverage EWA Kit's color foundation for consistent theming
3. **Leverage Responsive Design**: Use `flutter_screenutil` for adaptive layouts
4. **Implement Validation**: Use built-in validators for form fields
5. **Handle Errors Gracefully**: Implement proper error handling in HTTP clients
6. **Use Logging**: Utilize `EwaLogger` for debugging and monitoring
7. **Customize Responsibly**: Use customization options to match your brand, not to create inconsistency
8. **Use Overrides for Tests**: Use `EwaKitOverrides` to inject mocks in unit/widget tests

## Support

For issues, questions, or contributions, please contact the development team.
````
