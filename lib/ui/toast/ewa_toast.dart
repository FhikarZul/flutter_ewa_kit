import 'package:ewa_kit/foundations/color/color.dart';
import 'package:ewa_kit/foundations/size/size.dart';
import 'package:ewa_kit/ui/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A utility class for showing toast notifications in the EWA Kit.
///
/// Example:
/// ```dart
/// EwaToast.showSuccess(context, 'Operation completed successfully');
/// EwaToast.showError(context, 'Something went wrong');
/// ```
class EwaToast {
  /// Shows a success toast notification
  static void showSuccess(BuildContext context, String message) {
    _showToast(context, message, EwaToastType.success);
  }

  /// Shows an error toast notification
  static void showError(BuildContext context, String message) {
    _showToast(context, message, EwaToastType.error);
  }

  /// Shows an info toast notification
  static void showInfo(BuildContext context, String message) {
    _showToast(context, message, EwaToastType.info);
  }

  /// Shows a warning toast notification
  static void showWarning(BuildContext context, String message) {
    _showToast(context, message, EwaToastType.warning);
  }

  /// Shows a custom toast notification
  static void showCustom({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showToast(
      context,
      message,
      EwaToastType.custom,
      backgroundColor: backgroundColor,
      textColor: textColor,
      icon: icon,
      duration: duration,
    );
  }

  /// Internal method to show toast notification
  static void _showToast(
    BuildContext context,
    String message,
    EwaToastType type, {
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        type: type,
        backgroundColor: backgroundColor,
        textColor: textColor,
        icon: icon,
        onDismiss: () => overlayEntry.remove(),
        duration: duration,
      ),
    );

    overlay.insert(overlayEntry);

    // Auto dismiss after duration
    Future.delayed(duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}

/// Enum defining the different types of toast notifications
enum EwaToastType { success, error, info, warning, custom }

/// Internal widget for displaying the toast
class _ToastWidget extends StatefulWidget {
  final String message;
  final EwaToastType type;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final VoidCallback onDismiss;
  final Duration duration;

  const _ToastWidget({
    required this.message,
    required this.type,
    required this.onDismiss,
    required this.duration,
    this.backgroundColor,
    this.textColor,
    this.icon,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Future delayedDismissal;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    // Start animation
    _animationController.forward();

    // Schedule dismissal
    delayedDismissal = Future.delayed(widget.duration, _dismiss);
  }

  @override
  void dispose() {
    // Cancel the delayed dismissal to prevent calling _dismiss after disposal
    delayedDismissal.ignore();
    _animationController.dispose();
    super.dispose();
  }

  void _dismiss() {
    // Check if the widget is still mounted before trying to animate
    if (mounted) {
      _animationController.reverse().then((_) {
        widget.onDismiss();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60.h,
      left: 16.w,
      right: 16.w,
      child: SafeArea(
        child: SlideTransition(
          position: _slideAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: _getBackgroundColor(context),
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8.r,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_getIcon() != null) ...[
                    Icon(
                      _getIcon(),
                      color: _getTextColor(context),
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                  ],
                  Expanded(
                    child: Text(
                      widget.message,
                      style: EwaTypography.bodySm().copyWith(
                        color: _getTextColor(context),
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: _dismiss,
                    child: Icon(
                      Icons.close,
                      color: _getTextColor(context),
                      size: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Get background color based on toast type
  Color _getBackgroundColor(BuildContext context) {
    if (widget.backgroundColor != null) {
      return widget.backgroundColor!;
    }

    switch (widget.type) {
      case EwaToastType.success:
        return EwaColorFoundation.primaryLight;
      case EwaToastType.error:
        return EwaColorFoundation.errorLight;
      case EwaToastType.info:
        return EwaColorFoundation.neutral100;
      case EwaToastType.warning:
        return EwaColorFoundation.secondaryLight;
      case EwaToastType.custom:
        return EwaColorFoundation.neutral50;
    }
  }

  /// Get text color based on toast type
  Color _getTextColor(BuildContext context) {
    if (widget.textColor != null) {
      return widget.textColor!;
    }

    switch (widget.type) {
      case EwaToastType.success:
        return EwaColorFoundation.primaryDark;
      case EwaToastType.error:
        return EwaColorFoundation.errorDark;
      case EwaToastType.info:
        return EwaColorFoundation.neutral800;
      case EwaToastType.warning:
        return EwaColorFoundation.secondaryDark;
      case EwaToastType.custom:
        return EwaColorFoundation.neutral800;
    }
  }

  /// Get icon based on toast type
  IconData? _getIcon() {
    if (widget.icon != null) {
      return widget.icon;
    }

    switch (widget.type) {
      case EwaToastType.success:
        return Icons.check_circle_outline;
      case EwaToastType.error:
        return Icons.error_outline;
      case EwaToastType.info:
        return Icons.info_outline;
      case EwaToastType.warning:
        return Icons.warning_amber_outlined;
      case EwaToastType.custom:
        return null;
    }
  }
}
