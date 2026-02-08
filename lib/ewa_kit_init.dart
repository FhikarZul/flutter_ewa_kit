import 'dart:async';

import 'package:ewa_kit/foundations/config/ewa_kit_config.dart';
import 'package:ewa_kit/utils/ewa_logger.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';

/// EWA Kit initialization wrapper
///
/// This class handles all necessary initializations for the EWA Kit to function properly.
/// It encapsulates dependencies like screenutil and intl so the main app doesn't need
/// to manage them directly.
///
/// Usage:
/// ```dart
/// void main() async {
///   await EwaKit.initialize(() {
///     runApp(const MyApp());
///   });
/// }
/// ```
class EwaKit {
  EwaKit._();

  /// Initializes all required dependencies for EWA Kit.
  /// Returns a Future that completes when initialization is done.
  /// Uses [EwaKitConfig.defaultLocale] for date formatting.
  static Future<void> initialize(void Function() startApp) async {
    runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();

        await initializeDateFormatting(
          EwaKitConfig.defaultLocale,
          null,
        );

        FlutterError.onError = (details) {
          FlutterError.presentError(details);
          EwaLogger.error(
            "Flutter Error: ",
            error: details.exception,
            stackTrace: details.stack,
          );
        };

        startApp();
      },
      (error, stack) {
        EwaLogger.error("Unhandled Error: ", error: error, stackTrace: stack);
      },
    );
  }
}
