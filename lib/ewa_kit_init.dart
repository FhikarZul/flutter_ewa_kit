import 'package:intl/date_symbol_data_local.dart';

/// EWA Kit initialization wrapper
///
/// This class handles all necessary initializations for the EWA Kit to function properly.
/// It encapsulates dependencies like screenutil and intl so the main app doesn't need
/// to manage them directly.
///
/// Usage:
/// ```dart
/// void main() {
///   EwaKit.initialize().then((_) {
///     runApp(const MyApp());
///   });
/// }
/// ```
class EwaKit {
  EwaKit._();

  /// Initializes all required dependencies for EWA Kit
  ///
  /// This should be called before runApp() to ensure all dependencies are properly
  /// initialized.
  static Future<void> initialize() async {
    // Initialize screenutil
    // Note: ScreenUtilInit widget is still required in the widget tree

    // Initialize intl locale data for Indonesian
    initializeDateFormatting('id_ID', null);

    // Add any other initializations here as needed
  }
}
