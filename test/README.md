# EWA Kit Tests

This directory contains unit tests for the EWA Kit Flutter package.

## Test Structure

- `foundations/` - Tests for foundational components (colors, sizes, etc.)
- `ui/` - Tests for UI components (buttons, textfields, etc.)
- `utils/` - Tests for utility classes (datetime converter, logger, etc.)
- `network/` - Tests for network components (HTTP client, etc.)

## Running Tests

To run all tests:

```bash
flutter test
```

To run a specific test file:

```bash
flutter test test/foundations/color_foundation_test.dart
```

To run tests with coverage:

```bash
flutter test --coverage
```

## Test Organization

Each test file focuses on a specific component or utility:

1. **Color Foundation Tests** - `foundations/color_foundation_test.dart`
2. **Border Radius Tests** - `foundations/border_radius_test.dart`
3. **Button Component Tests** - `ui/button_test.dart`
4. **TextField Component Tests** - `ui/textfield_test.dart`
5. **DateTime Converter Tests** - `utils/datetime_converter_test.dart`
6. **Logger Tests** - `utils/logger_test.dart`
7. **HTTP Client Tests** - `network/http_client_test.dart`
8. **Response Exception Tests** - `network/response_exception_test.dart`

The main test file `ewa_kit_test.dart` aggregates all tests for convenient execution.
