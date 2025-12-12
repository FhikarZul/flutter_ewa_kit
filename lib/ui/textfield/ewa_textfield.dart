import 'package:ewa_kit/foundations/color/ewa_color_foundation.dart';
import 'package:ewa_kit/foundations/size/size.dart';
import 'package:ewa_kit/ui/textfield/enums/ewa_textfield_variant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Constants for EWA TextField configuration
class EwaTextFieldConstants {
  const EwaTextFieldConstants._();

  /// Default border radius
  static const defaultBorderRadius = 8.0;

  /// Default border width
  static const borderWidth = 1.0;

  /// Default content padding
  static const defaultPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 12.0,
  );
}

/// A customizable TextField widget with support for multiple variants
/// that automatically adapts to light and dark themes.
///
/// Example:
/// ```dart
/// EwaTextField.primary(
///   hintText: 'Enter your email',
///   onChanged: (value) { ... },
/// )
/// ```
class EwaTextField extends StatefulWidget {
  /// Creates an EWA TextField.
  const EwaTextField({
    this.controller,
    this.hintText,
    this.variant = EwaTextFieldVariant.primary,
    this.borderRadius = EwaTextFieldConstants.defaultBorderRadius,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    super.key,
  });

  /// Creates a primary variant TextField
  factory EwaTextField.primary({
    TextEditingController? controller,
    String? hintText,
    double borderRadius = EwaTextFieldConstants.defaultBorderRadius,
    bool obscureText = false,
    bool enabled = true,
    bool readOnly = false,
    int maxLines = 1,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    String? Function(String?)? validator,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
  }) => EwaTextField(
    controller: controller,
    hintText: hintText,
    variant: EwaTextFieldVariant.primary,
    borderRadius: borderRadius,
    obscureText: obscureText,
    enabled: enabled,
    readOnly: readOnly,
    maxLines: maxLines,
    onChanged: onChanged,
    onEditingComplete: onEditingComplete,
    onSubmitted: onSubmitted,
    validator: validator,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
  );

  /// Creates a secondary variant TextField
  factory EwaTextField.secondary({
    TextEditingController? controller,
    String? hintText,
    double borderRadius = EwaTextFieldConstants.defaultBorderRadius,
    bool obscureText = false,
    bool enabled = true,
    bool readOnly = false,
    int maxLines = 1,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    String? Function(String?)? validator,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
  }) => EwaTextField(
    controller: controller,
    hintText: hintText,
    variant: EwaTextFieldVariant.secondary,
    borderRadius: borderRadius,
    obscureText: obscureText,
    enabled: enabled,
    readOnly: readOnly,
    maxLines: maxLines,
    onChanged: onChanged,
    onEditingComplete: onEditingComplete,
    onSubmitted: onSubmitted,
    validator: validator,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
  );

  /// Creates a tertiary variant TextField
  factory EwaTextField.tertiary({
    TextEditingController? controller,
    String? hintText,
    double borderRadius = EwaTextFieldConstants.defaultBorderRadius,
    bool obscureText = false,
    bool enabled = true,
    bool readOnly = false,
    int maxLines = 1,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    String? Function(String?)? validator,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
  }) => EwaTextField(
    controller: controller,
    hintText: hintText,
    variant: EwaTextFieldVariant.tertiary,
    borderRadius: borderRadius,
    obscureText: obscureText,
    enabled: enabled,
    readOnly: readOnly,
    maxLines: maxLines,
    onChanged: onChanged,
    onEditingComplete: onEditingComplete,
    onSubmitted: onSubmitted,
    validator: validator,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
  );

  /// Creates a danger variant TextField
  factory EwaTextField.danger({
    TextEditingController? controller,
    String? hintText,
    double borderRadius = EwaTextFieldConstants.defaultBorderRadius,
    bool obscureText = false,
    bool enabled = true,
    bool readOnly = false,
    int maxLines = 1,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    String? Function(String?)? validator,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
  }) => EwaTextField(
    controller: controller,
    hintText: hintText,
    variant: EwaTextFieldVariant.danger,
    borderRadius: borderRadius,
    obscureText: obscureText,
    enabled: enabled,
    readOnly: readOnly,
    maxLines: maxLines,
    onChanged: onChanged,
    onEditingComplete: onEditingComplete,
    onSubmitted: onSubmitted,
    validator: validator,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
  );

  final TextEditingController? controller;
  final String? hintText;
  final EwaTextFieldVariant variant;
  final double borderRadius;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  State<EwaTextField> createState() => _EwaTextFieldState();
}

class _EwaTextFieldState extends State<EwaTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final variantData = widget.variant.data(context);

    return TextFormField(
      controller: _controller,
      obscureText: widget.obscureText,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onSubmitted,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      style: TextStyle(color: variantData.textColor, fontSize: 16.sp),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: variantData.hintColor, fontSize: 16.sp),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        filled: true,
        fillColor: variantData.fillColor,
        contentPadding: EwaTextFieldConstants.defaultPadding,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius.r),
          borderSide: BorderSide(
            color: variantData.enabledBorderColor,
            width: EwaTextFieldConstants.borderWidth.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius.r),
          borderSide: BorderSide(
            color: variantData.focusedBorderColor,
            width: EwaTextFieldConstants.borderWidth.w,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius.r),
          borderSide: BorderSide(
            color: EwaColorFoundation.getError(context),
            width: EwaTextFieldConstants.borderWidth.w,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius.r),
          borderSide: BorderSide(
            color: EwaColorFoundation.getError(context),
            width: EwaTextFieldConstants.borderWidth.w,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius.r),
          borderSide: BorderSide(
            color: EwaColorFoundation.resolveColor(
              context,
              EwaColorFoundation.neutral300,
              EwaColorFoundation.neutral600,
            ),
            width: EwaTextFieldConstants.borderWidth.w,
          ),
        ),
      ),
    );
  }
}
