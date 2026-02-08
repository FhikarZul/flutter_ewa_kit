import 'package:ewa_kit/utils/connectivity/ewa_connectivity_checker.dart';
import 'package:ewa_kit/utils/network/ewa_http_client.dart';

/// Override registry for EWA Kit services — enables dependency injection and testing.
///
/// Replace default implementations with mocks or custom implementations without
/// changing consuming code.
///
/// Example (testing):
/// ```dart
/// setUp(() {
///   EwaKitOverrides.httpClient = MockHttpClient();
///   EwaKitOverrides.connectivityChecker = MockConnectivityChecker();
/// });
/// tearDown(() {
///   EwaKitOverrides.reset();
/// });
/// ```
///
/// Example (custom implementation):
/// ```dart
/// void main() {
///   EwaKitOverrides.httpClient = MyCustomHttpClient();
///   runApp(MyApp());
/// }
/// ```
class EwaKitOverrides {
  EwaKitOverrides._();

  /// Override the default HTTP client. When set, [EwaHttpClient()] returns this instance.
  static set httpClient(EwaHttpClient? client) {
    EwaHttpClient.override = client;
  }

  /// Override the default connectivity checker. When set, [EwaConnectivityChecker.instance] returns this.
  static set connectivityChecker(EwaConnectivityChecker? checker) {
    EwaConnectivityChecker.override = checker;
  }

  /// Reset all overrides to default. Call in test tearDown.
  static void reset() {
    EwaHttpClient.clearOverride();
    EwaConnectivityChecker.clearOverride();
  }
}
