import 'package:ewa_kit/foundations/color/color.dart';
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
  static void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    _showToast(context, message, EwaToastType.success, duration: duration);
  }

  /// Shows an error toast notification
  static void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    _showToast(context, message, EwaToastType.error, duration: duration);
  }

  /// Shows an info toast notification
  static void showInfo(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    _showToast(context, message, EwaToastType.info, duration: duration);
  }

  /// Shows a warning toast notification
  static void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    _showToast(context, message, EwaToastType.warning, duration: duration);
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
    if (!context.mounted) return;

    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        type: type,
        backgroundColor: backgroundColor,
        textColor: textColor,
        icon: icon,
        onDismiss: () {
          if (overlayEntry.mounted) overlayEntry.remove();
        },
        duration: duration,
      ),
    );

    overlay.insert(overlayEntry);
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
  bool _isDismissed = false;

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

    // Schedule auto dismissal
    Future.delayed(widget.duration, _dismiss);
  }

  @override
  void dispose() {
    _isDismissed = true;
    _animationController.dispose();
    super.dispose();
  }

  void _dismiss() {
    if (_isDismissed || !mounted) return;
    _isDismissed = true;

    _animationController.reverse().then((_) {
      if (mounted) widget.onDismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final shadowColor = isDark
        ? Colors.black.withValues(alpha: 0.3)
        : Colors.black.withValues(alpha: 0.1);

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
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: 8.r,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_getIcon() != null) ...[
                    Icon(
                      _getIcon(),
                      color: _getTextColor(context),
                      size: 18.sp,
                    ),
                    SizedBox(width: 8.w),
                  ],
                  Expanded(
                    child: Text(
                      widget.message,
                      style: EwaTypography.bodySm().copyWith(
                        color: _getTextColor(context),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _dismiss,
                      borderRadius: BorderRadius.circular(20.r),
                      child: Padding(
                        padding: EdgeInsets.all(6.r),
                        child: Icon(
                          Icons.close,
                          color: _getTextColor(context),
                          size: 16.sp,
                        ),
                      ),
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

  /// Get background color based on toast type (theme-aware)
  Color _getBackgroundColor(BuildContext context) {
    if (widget.backgroundColor != null) {
      return widget.backgroundColor!;
    }

    switch (widget.type) {
      case EwaToastType.success:
        return EwaColorFoundation.resolveColor(
          context,
          EwaColorFoundation.successLight,
          EwaColorFoundation.successLight,
        );
      case EwaToastType.error:
        return EwaColorFoundation.resolveColor(
          context,
          EwaColorFoundation.errorLight,
          EwaColorFoundation.errorLight,
        );
      case EwaToastType.info:
        return EwaColorFoundation.resolveColor(
          context,
          EwaColorFoundation.neutral100,
          EwaColorFoundation.neutral700,
        );
      case EwaToastType.warning:
        return EwaColorFoundation.resolveColor(
          context,
          EwaColorFoundation.warningLight,
          EwaColorFoundation.warningLight,
        );
      case EwaToastType.custom:
        return EwaColorFoundation.resolveColor(
          context,
          EwaColorFoundation.neutral50,
          EwaColorFoundation.neutral700,
        );
    }
  }

  /// Get text color based on toast type (white on colored bg, theme-aware for neutral)
  Color _getTextColor(BuildContext context) {
    if (widget.textColor != null) {
      return widget.textColor!;
    }

    switch (widget.type) {
      case EwaToastType.success:
      case EwaToastType.error:
      case EwaToastType.warning:
        return EwaColorFoundation.textDark;
      case EwaToastType.info:
      case EwaToastType.custom:
        return EwaColorFoundation.resolveColor(
          context,
          EwaColorFoundation.neutral800,
          EwaColorFoundation.neutral100,
        );
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
