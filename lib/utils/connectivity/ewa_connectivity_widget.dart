import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'ewa_connectivity_checker.dart';
import '../../foundations/color/ewa_color_foundation.dart';
import '../../ui/typography/ewa_typography.dart';

/// A widget that displays the current connectivity status with visual indicators
///
/// This widget automatically listens to connectivity changes and updates the UI accordingly.
///
/// Example:
/// ```dart
/// EwaConnectivityWidget(
///   showIcon: true,
///   showText: true,
///   useIndonesian: true,
/// )
/// ```
class EwaConnectivityWidget extends StatefulWidget {
  /// Whether to show the connection icon
  final bool showIcon;

  /// Whether to show the connection status text
  final bool showText;

  /// Use Indonesian language for status text
  final bool useIndonesian;

  /// Custom widget to show when connected
  final Widget? connectedWidget;

  /// Custom widget to show when disconnected
  final Widget? disconnectedWidget;

  /// Callback when connectivity status changes
  final ValueChanged<EwaConnectivityStatus>? onStatusChanged;

  /// Compact mode (smaller display)
  final bool compact;

  const EwaConnectivityWidget({
    super.key,
    this.showIcon = true,
    this.showText = true,
    this.useIndonesian = false,
    this.connectedWidget,
    this.disconnectedWidget,
    this.onStatusChanged,
    this.compact = false,
  });

  @override
  State<EwaConnectivityWidget> createState() => _EwaConnectivityWidgetState();
}

class _EwaConnectivityWidgetState extends State<EwaConnectivityWidget> {
  EwaConnectivityStatus _currentStatus = EwaConnectivityStatus.offline;

  @override
  void initState() {
    super.initState();
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    // Initialize the connectivity checker
    await EwaConnectivityChecker.instance.initialize();

    // Set initial status
    setState(() {
      _currentStatus = EwaConnectivityChecker.instance.currentStatus;
    });

    // Listen to connectivity changes
    EwaConnectivityChecker.instance.connectivityStream.listen((status) {
      if (mounted) {
        setState(() {
          _currentStatus = status;
        });
        widget.onStatusChanged?.call(status);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use custom widgets if provided
    if (_isConnected && widget.connectedWidget != null) {
      return widget.connectedWidget!;
    }
    if (!_isConnected && widget.disconnectedWidget != null) {
      return widget.disconnectedWidget!;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: widget.compact ? 12.w : 16.w,
        vertical: widget.compact ? 6.h : 8.h,
      ),
      decoration: BoxDecoration(
        color: _getStatusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(widget.compact ? 6.r : 8.r),
        border: Border.all(color: _getStatusColor.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showIcon) ...[
            Icon(
              _getStatusIcon,
              color: _getStatusColor,
              size: widget.compact ? 16.sp : 20.sp,
            ),
            if (widget.showText) SizedBox(width: 8.w),
          ],
          if (widget.showText)
            Text(
              EwaConnectivityChecker.instance.getStatusDescription(
                _currentStatus,
                useIndonesian: widget.useIndonesian,
              ),
              style: widget.compact
                  ? EwaTypography.bodySm(color: _getStatusColor)
                  : EwaTypography.body(color: _getStatusColor),
            ),
        ],
      ),
    );
  }

  bool get _isConnected =>
      _currentStatus != EwaConnectivityStatus.offline &&
      _currentStatus != EwaConnectivityStatus.noInternet;

  IconData get _getStatusIcon {
    switch (_currentStatus) {
      case EwaConnectivityStatus.wifi:
        return Icons.wifi;
      case EwaConnectivityStatus.mobile:
        return Icons.signal_cellular_alt;
      case EwaConnectivityStatus.ethernet:
        return Icons.cable;
      case EwaConnectivityStatus.vpn:
        return Icons.vpn_lock;
      case EwaConnectivityStatus.bluetooth:
        return Icons.bluetooth;
      case EwaConnectivityStatus.noInternet:
        return Icons.wifi_off;
      case EwaConnectivityStatus.offline:
        return Icons.cloud_off;
    }
  }

  Color get _getStatusColor {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (_currentStatus) {
      case EwaConnectivityStatus.wifi:
      case EwaConnectivityStatus.mobile:
      case EwaConnectivityStatus.ethernet:
      case EwaConnectivityStatus.vpn:
      case EwaConnectivityStatus.bluetooth:
        return isDark
            ? EwaColorFoundation.successDark
            : EwaColorFoundation.successLight;
      case EwaConnectivityStatus.noInternet:
        return isDark
            ? EwaColorFoundation.warningDark
            : EwaColorFoundation.warningLight;
      case EwaConnectivityStatus.offline:
        return isDark
            ? EwaColorFoundation.errorDark
            : EwaColorFoundation.errorLight;
    }
  }
}

/// A banner that automatically shows/hides based on connectivity status
///
/// This widget displays a banner at the top or bottom of the screen when
/// the device loses internet connection.
///
/// Example:
/// ```dart
/// Scaffold(
///   body: EwaConnectivityBanner(
///     child: YourContent(),
///   ),
/// )
/// ```
class EwaConnectivityBanner extends StatefulWidget {
  /// The child widget to display
  final Widget child;

  /// Whether to show banner at the top (true) or bottom (false)
  final bool showAtTop;

  /// Use Indonesian language for banner text
  final bool useIndonesian;

  /// Custom banner widget
  final Widget? customBanner;

  /// Whether to show only when offline (true) or also when no internet (false)
  final bool onlyShowWhenOffline;

  const EwaConnectivityBanner({
    super.key,
    required this.child,
    this.showAtTop = true,
    this.useIndonesian = false,
    this.customBanner,
    this.onlyShowWhenOffline = false,
  });

  @override
  State<EwaConnectivityBanner> createState() => _EwaConnectivityBannerState();
}

class _EwaConnectivityBannerState extends State<EwaConnectivityBanner> {
  EwaConnectivityStatus _currentStatus = EwaConnectivityStatus.offline;
  bool _showBanner = false;

  @override
  void initState() {
    super.initState();
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    await EwaConnectivityChecker.instance.initialize();

    setState(() {
      _currentStatus = EwaConnectivityChecker.instance.currentStatus;
      _updateBannerVisibility();
    });

    EwaConnectivityChecker.instance.connectivityStream.listen((status) {
      if (mounted) {
        setState(() {
          _currentStatus = status;
          _updateBannerVisibility();
        });
      }
    });
  }

  void _updateBannerVisibility() {
    if (widget.onlyShowWhenOffline) {
      _showBanner = _currentStatus == EwaConnectivityStatus.offline;
    } else {
      _showBanner =
          _currentStatus == EwaConnectivityStatus.offline ||
          _currentStatus == EwaConnectivityStatus.noInternet;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.showAtTop && _showBanner) _buildBanner(),
        Expanded(child: widget.child),
        if (!widget.showAtTop && _showBanner) _buildBanner(),
      ],
    );
  }

  Widget _buildBanner() {
    if (widget.customBanner != null) {
      return widget.customBanner!;
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = _currentStatus == EwaConnectivityStatus.offline
        ? (isDark
              ? EwaColorFoundation.errorDark
              : EwaColorFoundation.errorLight)
        : (isDark
              ? EwaColorFoundation.warningDark
              : EwaColorFoundation.warningLight);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _currentStatus == EwaConnectivityStatus.offline
                ? Icons.cloud_off
                : Icons.wifi_off,
            color: Colors.white,
            size: 20.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            EwaConnectivityChecker.instance.getStatusDescription(
              _currentStatus,
              useIndonesian: widget.useIndonesian,
            ),
            style: EwaTypography.body(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
