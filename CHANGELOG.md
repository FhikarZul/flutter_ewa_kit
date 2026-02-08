r# Changelog

All notable changes to EWA Kit will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- `EwaTextField`: Optional `labelText`, `helperText`, `counterText`; improved error display (errorStyle, errorMaxLines)
- `EwaTextField`: Optional `fillColor`, `enabledBorderColor`, `focusedBorderColor` for custom colors (falls back to variant when null)
- Login Form example screen in example app (EwaTextField, EwaValidators, focus, loading state)
- `EwaKitOverrides` for flexible dependency injection — override `EwaHttpClient` and `EwaConnectivityChecker` for testing or custom implementations
- Connectivity and Permission demo screens in example app
- Android manifest permissions (camera, photos, notifications) and iOS Info.plist usage descriptions for example app
- `EwaTheme` helper for light/dark theme and `fromSeed()` for brand colors
- `EwaKitConfig.defaultLocale` for date formatting
- Configurable retry params for `EwaHttpClient.init()`: `maxRetries`, `retryDelay`, `maxRetryDuration`
- Optional `designSize` in `EwaApp` (uses `EwaKitConfig.designSize` when null)
- Optional `duration` parameter for toast methods

### Changed

- `EwaToast`: Smoother hide animation (fade + slide, easeOutCubic, 350ms)
- `EwaTextField`: Logging follows Flutter `kDebugMode` (auto in debug, off in release)
- `EwaTextField`: Content padding now responsive (uses `.w` and `.h`)
- `EwaTextField`: Added `focusNode`, `autofocus`, `maxLength`, `textCapitalization`, `inputFormatters`
- `EwaTextField`: `didUpdateWidget` handles controller and focusNode changes
- `EwaTextFieldConstants.defaultPadding` replaced with `defaultPaddingHorizontal` and `defaultPaddingVertical`
- Moved `network/` into `utils/network/` for consistent structure (all non-UI logic under utils)
- `EwaKit.initialize()` is now async and must be awaited
- `EwaHttpClient.init()` returns `Future<void>` and must be awaited
- `EwaButtonConstants` now reads from `EwaKitConfig` (debounceDuration, spinnerSize, borderWidth)
- Toast and dialog UI improvements (dark mode, spacing, overflow handling)
- EwaHttpClient default retry: 3 retries, 1s delay, 2min max duration

### Fixed

- Toast race condition on dismiss (single source of truth)
- Toast `delayedDismissal.ignore()` replaced with flag (Future has no ignore method)
- Permission helper unused okButton/cancelButton parameters

## [0.0.1] - Initial release

### Added

- UI components: Button, TextField, Dialog, Toast, Loading, BottomSheet, Image, LazyLoad
- Foundations: Color, Typography, Size, Config
- Network: EwaHttpClient with Dio, token management, retry, caching
- Utilities: Logger, DateTime converter, Permission helper, Connectivity checker
- EwaApp and EwaKit.initialize for setup
