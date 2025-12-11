import 'package:ewa_kit/foundations/size/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'button.dart';

/// Constants for EWA Button configuration
class EwaButtonConstants {
  const EwaButtonConstants._();

  /// Default debounce duration to prevent rapid clicks
  static const debounceDuration = Duration(milliseconds: 500);

  /// Default spinner size for loading state
  static const defaultSpinnerSize = 20.0;

  /// Default border width
  static const borderWidth = 1.0;
}

/// A customizable button widget with support for multiple variants,
/// types, and sizes. Automatically adapts to light and dark themes.
///
/// Example:
/// ```dart
/// EwaButton.primary(
///   label: 'Click me',
///   onPressed: () async { ... },
/// )
/// ```
class EwaButton extends StatelessWidget {
  /// Creates an EWA button.
  ///
  /// The [label] parameter is required.
  const EwaButton({
    required this.label,
    this.size = EwaButtonSize.md,
    this.onPressed,
    this.variant = EwaButtonVariant.primary,
    this.type = EwaButtonType.filled,
    this.enable = true,
    this.debounce = true,
    this.wrap = true,
    this.leading,
    this.trailing,
    super.key,
  });

  factory EwaButton.primary({
    required String label,
    EwaButtonType type = EwaButtonType.filled,
    bool enable = true,
    Future<void> Function()? onPressed,
    EwaButtonSize size = EwaButtonSize.md,
    bool debounce = true,
    bool wrap = true,
    Widget? leading,
    Widget? trailing,
  }) => EwaButton(
    label: label,
    size: size,
    type: type,
    enable: enable,
    onPressed: onPressed,
    leading: leading,
    trailing: trailing,
    debounce: debounce,
    wrap: wrap,
  );

  factory EwaButton.secondary({
    required String label,
    EwaButtonType type = EwaButtonType.filled,
    bool enable = true,
    Future<void> Function()? onPressed,
    EwaButtonSize size = EwaButtonSize.md,
    bool debounce = true,
    bool wrap = true,
    Widget? leading,
    Widget? trailing,
  }) => EwaButton(
    variant: EwaButtonVariant.secondary,
    label: label,
    size: size,
    type: type,
    enable: enable,
    onPressed: onPressed,
    leading: leading,
    trailing: trailing,
    debounce: debounce,
    wrap: wrap,
  );

  factory EwaButton.tertiary({
    required String label,
    EwaButtonType type = EwaButtonType.filled,
    bool enable = true,
    Future<void> Function()? onPressed,
    EwaButtonSize size = EwaButtonSize.md,
    bool debounce = true,
    bool wrap = true,
    Widget? leading,
    Widget? trailing,
  }) => EwaButton(
    variant: EwaButtonVariant.tertiary,
    label: label,
    size: size,
    type: type,
    enable: enable,
    onPressed: onPressed,
    leading: leading,
    trailing: trailing,
    debounce: debounce,
    wrap: wrap,
  );

  factory EwaButton.danger({
    required String label,
    EwaButtonType type = EwaButtonType.filled,
    bool enable = true,
    Future<void> Function()? onPressed,
    EwaButtonSize size = EwaButtonSize.md,
    bool debounce = true,
    bool wrap = true,
    Widget? leading,
    Widget? trailing,
  }) => EwaButton(
    variant: EwaButtonVariant.danger,
    label: label,
    size: size,
    type: type,
    enable: enable,
    onPressed: onPressed,
    leading: leading,
    trailing: trailing,
    debounce: debounce,
    wrap: wrap,
  );

  final bool enable;
  final String label;
  final EwaButtonSize size;
  final EwaButtonVariant variant;
  final Future<void> Function()? onPressed;
  final EwaButtonType type;
  final Widget? leading;
  final Widget? trailing;
  final bool debounce;
  final bool wrap;

  @override
  Widget build(BuildContext context) => debounce
      ? TapDebouncer(
          onTap: onPressed,
          cooldown: EwaButtonConstants.debounceDuration,
          waitBuilder: (context, child) => _ButtonWidget(
            enable: false,
            label: label,
            size: size,
            variant: variant,
            type: type,
            leading: SpinKitCircle(
              size:
                  size.data.textStyle.fontSize ??
                  EwaButtonConstants.defaultSpinnerSize.sp,
              color: type.data(context).disabledFgColor,
            ),
            wrap: wrap,
          ),
          builder: (context, onTap) => _ButtonWidget(
            enable: enable,
            label: label,
            size: size,
            variant: variant,
            type: type,
            onPressed: onTap,
            leading: leading,
            trailing: trailing,
            wrap: wrap,
          ),
        )
      : _ButtonWidget(
          enable: enable,
          label: label,
          size: size,
          variant: variant,
          type: type,
          onPressed: onPressed,
          leading: leading,
          trailing: trailing,
          wrap: wrap,
        );
}

class _ButtonWidget extends StatelessWidget {
  const _ButtonWidget({
    required this.enable,
    required this.label,
    required this.size,
    required this.variant,
    required this.type,
    this.onPressed,
    this.leading,
    this.trailing,
    this.wrap = true,
  });

  final bool enable;
  final String label;
  final EwaButtonSize size;
  final EwaButtonVariant variant;
  final Future<void> Function()? onPressed;
  final EwaButtonType type;
  final Widget? leading;
  final Widget? trailing;
  final bool wrap;

  @override
  Widget build(BuildContext context) {
    final child = SizedBox(
      height: size.data.height,
      child: MaterialButton(
        minWidth: size.data.width,
        onPressed: (enable && onPressed != null) ? onPressed : null,
        elevation: 0,
        disabledElevation: 0,
        highlightElevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        height: size.data.height,
        color: _backgroundColor(context),
        disabledColor: type.data(context).disabledBgColor,
        disabledTextColor: type.data(context).disabledFgColor,
        focusColor: Colors.transparent,
        textColor: _textColor(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size.data.borderRadius),
          side: BorderSide(
            color: _borderColor(context),
            width: EwaButtonConstants.borderWidth.sp,
          ),
        ),
        child: Padding(
          padding: size.data.padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leading != null) ...[leading!, const Gap(EwaDimension.size8)],
              Flexible(
                child: Text(
                  label,
                  style: size.data.textStyle,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (trailing != null) ...[
                const Gap(EwaDimension.size8),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
    return wrap ? IntrinsicWidth(child: child) : child;
  }

  Color _backgroundColor(BuildContext context) {
    if (!enable || onPressed == null) {
      return type.data(context).disabledBgColor;
    }

    if (type == EwaButtonType.filled) {
      return variant.data(context).backgroundColor;
    }

    return variant.data(context).outlineBgColor;
  }

  Color _textColor(BuildContext context) {
    // Handle disabled state
    if (!enable || onPressed == null) {
      return type.data(context).disabledFgColor;
    }

    // Handle filled buttons
    if (type == EwaButtonType.filled) {
      return variant.data(context).foregroundColor;
    }

    // Handle outline and ghost buttons
    // Special case for tertiary variant
    if (variant == EwaButtonVariant.tertiary) {
      return EwaColorFoundation.resolveColor(
        context,
        EwaColorFoundation.neutral800,
        EwaColorFoundation.neutral200,
      );
    }

    return variant.data(context).outlineFgColor;
  }

  Color _borderColor(BuildContext context) {
    if (!enable || onPressed == null) {
      return type.data(context).disabledBorderColor;
    }

    if (type == EwaButtonType.outline) {
      return variant.data(context).borderColor;
    }

    return Colors.transparent;
  }
}
