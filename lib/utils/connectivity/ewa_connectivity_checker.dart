import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Enum representing the type of network connectivity
enum EwaConnectivityStatus {
  /// Connected to WiFi and has internet access
  wifi,

  /// Connected to mobile data and has internet access
  mobile,

  /// Connected to Ethernet and has internet access
  ethernet,

  /// Connected to VPN and has internet access
  vpn,

  /// Bluetooth connection
  bluetooth,

  /// Has network connection but no internet access
  noInternet,

  /// No network connection at all
  offline,
}

/// A comprehensive connectivity checker that monitors real-time network status
///
/// This class provides:
/// - Real-time connectivity monitoring
/// - Stream-based status updates
/// - Differentiation between network connection and actual internet access
/// - Helper methods to check connectivity status
///
/// Example:
/// ```dart
/// // Listen to connectivity changes
/// EwaConnectivityChecker.instance.connectivityStream.listen((status) {
///   if (status == EwaConnectivityStatus.offline) {
///     print('Device is offline');
///   } else if (status == EwaConnectivityStatus.wifi) {
///     print('Connected via WiFi');
///   }
/// });
///
/// // Check current status
/// final isConnected = await EwaConnectivityChecker.instance.hasConnection;
/// final hasInternet = await EwaConnectivityChecker.instance.hasInternetAccess;
/// ```
class EwaConnectivityChecker {
  // Singleton pattern
  EwaConnectivityChecker._();
  static final EwaConnectivityChecker _instance = EwaConnectivityChecker._();
  static EwaConnectivityChecker get instance => _instance;

  // Dependencies
  final Connectivity _connectivity = Connectivity();
  final InternetConnection _internetChecker = InternetConnection();

  // Stream controllers
  final StreamController<EwaConnectivityStatus> _connectivityController =
      StreamController<EwaConnectivityStatus>.broadcast();

  // Current status
  EwaConnectivityStatus _currentStatus = EwaConnectivityStatus.offline;
  EwaConnectivityStatus get currentStatus => _currentStatus;

  // Subscriptions
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  StreamSubscription<InternetStatus>? _internetSubscription;

  bool _isInitialized = false;

  /// Stream that emits connectivity status changes
  Stream<EwaConnectivityStatus> get connectivityStream =>
      _connectivityController.stream;

  /// Initialize the connectivity checker and start monitoring
  Future<void> initialize() async {
    if (_isInitialized) return;

    // Listen to connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      results,
    ) async {
      await _updateConnectivityStatus(results);
    });

    // Listen to internet connection changes
    _internetSubscription = _internetChecker.onStatusChange.listen((
      internetStatus,
    ) async {
      // Re-check connectivity status when internet status changes
      final connectivityResults = await _connectivity.checkConnectivity();
      await _updateConnectivityStatus(connectivityResults);
    });

    // Check initial status
    final initialResults = await _connectivity.checkConnectivity();
    await _updateConnectivityStatus(initialResults);

    _isInitialized = true;
  }

  /// Update connectivity status based on connectivity results
  Future<void> _updateConnectivityStatus(
    List<ConnectivityResult> results,
  ) async {
    // If no connection at all
    if (results.isEmpty || results.contains(ConnectivityResult.none)) {
      _setStatus(EwaConnectivityStatus.offline);
      return;
    }

    // Check if we have actual internet access
    final hasInternet = await _internetChecker.hasInternetAccess;

    if (!hasInternet) {
      _setStatus(EwaConnectivityStatus.noInternet);
      return;
    }

    // Determine the type of connection
    // Priority: WiFi > Ethernet > VPN > Mobile > Bluetooth
    if (results.contains(ConnectivityResult.wifi)) {
      _setStatus(EwaConnectivityStatus.wifi);
    } else if (results.contains(ConnectivityResult.ethernet)) {
      _setStatus(EwaConnectivityStatus.ethernet);
    } else if (results.contains(ConnectivityResult.vpn)) {
      _setStatus(EwaConnectivityStatus.vpn);
    } else if (results.contains(ConnectivityResult.mobile)) {
      _setStatus(EwaConnectivityStatus.mobile);
    } else if (results.contains(ConnectivityResult.bluetooth)) {
      _setStatus(EwaConnectivityStatus.bluetooth);
    } else {
      _setStatus(EwaConnectivityStatus.offline);
    }
  }

  /// Set the current status and notify listeners
  void _setStatus(EwaConnectivityStatus status) {
    if (_currentStatus != status) {
      _currentStatus = status;
      _connectivityController.add(status);
    }
  }

  /// Check if device has any network connection
  Future<bool> get hasConnection async {
    final results = await _connectivity.checkConnectivity();
    return results.isNotEmpty && !results.contains(ConnectivityResult.none);
  }

  /// Check if device has actual internet access
  Future<bool> get hasInternetAccess async {
    return await _internetChecker.hasInternetAccess;
  }

  /// Check if connected via WiFi
  Future<bool> get isWifi async {
    final results = await _connectivity.checkConnectivity();
    return results.contains(ConnectivityResult.wifi);
  }

  /// Check if connected via mobile data
  Future<bool> get isMobile async {
    final results = await _connectivity.checkConnectivity();
    return results.contains(ConnectivityResult.mobile);
  }

  /// Check if connected via Ethernet
  Future<bool> get isEthernet async {
    final results = await _connectivity.checkConnectivity();
    return results.contains(ConnectivityResult.ethernet);
  }

  /// Check if connected via VPN
  Future<bool> get isVPN async {
    final results = await _connectivity.checkConnectivity();
    return results.contains(ConnectivityResult.vpn);
  }

  /// Check if device is offline
  Future<bool> get isOffline async {
    return !await hasConnection;
  }

  /// Get a human-readable description of the current connectivity status
  String getStatusDescription(
    EwaConnectivityStatus status, {
    bool useIndonesian = false,
  }) {
    if (useIndonesian) {
      switch (status) {
        case EwaConnectivityStatus.wifi:
          return 'Terhubung ke WiFi';
        case EwaConnectivityStatus.mobile:
          return 'Terhubung ke Data Seluler';
        case EwaConnectivityStatus.ethernet:
          return 'Terhubung ke Ethernet';
        case EwaConnectivityStatus.vpn:
          return 'Terhubung ke VPN';
        case EwaConnectivityStatus.bluetooth:
          return 'Terhubung ke Bluetooth';
        case EwaConnectivityStatus.noInternet:
          return 'Tidak Ada Koneksi Internet';
        case EwaConnectivityStatus.offline:
          return 'Offline';
      }
    } else {
      switch (status) {
        case EwaConnectivityStatus.wifi:
          return 'Connected to WiFi';
        case EwaConnectivityStatus.mobile:
          return 'Connected to Mobile Data';
        case EwaConnectivityStatus.ethernet:
          return 'Connected to Ethernet';
        case EwaConnectivityStatus.vpn:
          return 'Connected to VPN';
        case EwaConnectivityStatus.bluetooth:
          return 'Connected to Bluetooth';
        case EwaConnectivityStatus.noInternet:
          return 'No Internet Connection';
        case EwaConnectivityStatus.offline:
          return 'Offline';
      }
    }
  }

  /// Dispose resources and stop monitoring
  void dispose() {
    _connectivitySubscription?.cancel();
    _internetSubscription?.cancel();
    _connectivityController.close();
    _isInitialized = false;
  }
}
