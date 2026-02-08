import 'package:ewa_kit/foundations/color/ewa_color_foundation.dart';
import 'package:ewa_kit/ui/textfield/enums/ewa_textfield_variant.dart';
import 'package:ewa_kit/utils/ewa_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Constants for EWA TextField configuration
class EwaTextFieldConstants {
  const EwaTextFieldConstants._();

  /// Default border radius
  static const defaultBorderRadius = 8.0;

  /// Default border width
  static const borderWidth = 1.0;

  /// Default content padding (horizontal)
  static const defaultPaddingHorizontal = 16.0;

  /// Default content padding (vertical)
  static const defaultPaddingVertical = 12.0;
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
    this.focusNode,
    this.hintText,
    this.variant = EwaTextFieldVariant.primary,
    this.borderRadius = EwaTextFieldConstants.defaultBorderRadius,
    this.fillColor,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.formatter,
    super.key,
  });

  /// Creates a primary variant TextField
  factory EwaTextField.primary({
    TextEditingController? controller,
    FocusNode? focusNode,
    String? hintText,
    double borderRadius = EwaTextFieldConstants.defaultBorderRadius,
    Color? fillColor,
    Color? enabledBorderColor,
    Color? focusedBorderColor,
    bool obscureText = false,
    bool enabled = true,
    bool readOnly = false,
    bool autofocus = false,
    int maxLines = 1,
    int? maxLength,
    TextCapitalization textCapitalization = TextCapitalization.none,
    List<TextInputFormatter>? inputFormatters,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    String? Function(String?)? validator,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    String Function(String)? formatter,
  }) => EwaTextField(
    controller: controller,
    focusNode: focusNode,
    hintText: hintText,
    variant: EwaTextFieldVariant.primary,
    borderRadius: borderRadius,
    fillColor: fillColor,
    enabledBorderColor: enabledBorderColor,
    focusedBorderColor: focusedBorderColor,
    obscureText: obscureText,
    enabled: enabled,
    readOnly: readOnly,
    autofocus: autofocus,
    maxLines: maxLines,
    maxLength: maxLength,
    textCapitalization: textCapitalization,
    inputFormatters: inputFormatters,
    onChanged: onChanged,
    onEditingComplete: onEditingComplete,
    onSubmitted: onSubmitted,
    validator: validator,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    formatter: formatter,
  );

  /// Creates a secondary variant TextField
  factory EwaTextField.secondary({
    TextEditingController? controller,
    FocusNode? focusNode,
    String? hintText,
    double borderRadius = EwaTextFieldConstants.defaultBorderRadius,
    Color? fillColor,
    Color? enabledBorderColor,
    Color? focusedBorderColor,
    bool obscureText = false,
    bool enabled = true,
    bool readOnly = false,
    bool autofocus = false,
    int maxLines = 1,
    int? maxLength,
    TextCapitalization textCapitalization = TextCapitalization.none,
    List<TextInputFormatter>? inputFormatters,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    String? Function(String?)? validator,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    String Function(String)? formatter,
  }) => EwaTextField(
    controller: controller,
    focusNode: focusNode,
    hintText: hintText,
    variant: EwaTextFieldVariant.secondary,
    borderRadius: borderRadius,
    fillColor: fillColor,
    enabledBorderColor: enabledBorderColor,
    focusedBorderColor: focusedBorderColor,
    obscureText: obscureText,
    enabled: enabled,
    readOnly: readOnly,
    autofocus: autofocus,
    maxLines: maxLines,
    maxLength: maxLength,
    textCapitalization: textCapitalization,
    inputFormatters: inputFormatters,
    onChanged: onChanged,
    onEditingComplete: onEditingComplete,
    onSubmitted: onSubmitted,
    validator: validator,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    formatter: formatter,
  );

  /// Creates a tertiary variant TextField
  factory EwaTextField.tertiary({
    TextEditingController? controller,
    FocusNode? focusNode,
    String? hintText,
    double borderRadius = EwaTextFieldConstants.defaultBorderRadius,
    Color? fillColor,
    Color? enabledBorderColor,
    Color? focusedBorderColor,
    bool obscureText = false,
    bool enabled = true,
    bool readOnly = false,
    bool autofocus = false,
    int maxLines = 1,
    int? maxLength,
    TextCapitalization textCapitalization = TextCapitalization.none,
    List<TextInputFormatter>? inputFormatters,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    String? Function(String?)? validator,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    String Function(String)? formatter,
  }) => EwaTextField(
    controller: controller,
    focusNode: focusNode,
    hintText: hintText,
    variant: EwaTextFieldVariant.tertiary,
    borderRadius: borderRadius,
    fillColor: fillColor,
    enabledBorderColor: enabledBorderColor,
    focusedBorderColor: focusedBorderColor,
    obscureText: obscureText,
    enabled: enabled,
    readOnly: readOnly,
    autofocus: autofocus,
    maxLines: maxLines,
    maxLength: maxLength,
    textCapitalization: textCapitalization,
    inputFormatters: inputFormatters,
    onChanged: onChanged,
    onEditingComplete: onEditingComplete,
    onSubmitted: onSubmitted,
    validator: validator,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    formatter: formatter,
  );

  /// Creates a danger variant TextField
  factory EwaTextField.danger({
    TextEditingController? controller,
    FocusNode? focusNode,
    String? hintText,
    double borderRadius = EwaTextFieldConstants.defaultBorderRadius,
    Color? fillColor,
    Color? enabledBorderColor,
    Color? focusedBorderColor,
    bool obscureText = false,
    bool enabled = true,
    bool readOnly = false,
    bool autofocus = false,
    int maxLines = 1,
    int? maxLength,
    TextCapitalization textCapitalization = TextCapitalization.none,
    List<TextInputFormatter>? inputFormatters,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    String? Function(String?)? validator,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    String Function(String)? formatter,
  }) => EwaTextField(
    controller: controller,
    focusNode: focusNode,
    hintText: hintText,
    variant: EwaTextFieldVariant.danger,
    borderRadius: borderRadius,
    fillColor: fillColor,
    enabledBorderColor: enabledBorderColor,
    focusedBorderColor: focusedBorderColor,
    obscureText: obscureText,
    enabled: enabled,
    readOnly: readOnly,
    autofocus: autofocus,
    maxLines: maxLines,
    maxLength: maxLength,
    textCapitalization: textCapitalization,
    inputFormatters: inputFormatters,
    onChanged: onChanged,
    onEditingComplete: onEditingComplete,
    onSubmitted: onSubmitted,
    validator: validator,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    formatter: formatter,
  );

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final EwaTextFieldVariant variant;
  final double borderRadius;
  final Color? fillColor;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final int maxLines;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String Function(String)? formatter;

  @override
  State<EwaTextField> createState() => _EwaTextFieldState();
}

class _EwaTextFieldState extends State<EwaTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFormatting = false;
  bool _ownsController = false;
  bool _ownsFocusNode = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _ownsController = widget.controller == null;
    _focusNode = widget.focusNode ?? FocusNode();
    _ownsFocusNode = widget.focusNode == null;

    _focusNode.addListener(_onFocusChange);

    if (widget.formatter != null) {
      _controller.addListener(_formatText);
    }
  }

  @override
  void didUpdateWidget(covariant EwaTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      if (widget.formatter != null) {
        _controller.removeListener(_formatText);
      }
      if (_ownsController) {
        _controller.dispose();
      }
      _controller = widget.controller ?? TextEditingController();
      _ownsController = widget.controller == null;
      if (widget.formatter != null) {
        _controller.addListener(_formatText);
      }
    }

    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode.removeListener(_onFocusChange);
      if (_ownsFocusNode) {
        _focusNode.dispose();
      }
      _focusNode = widget.focusNode ?? FocusNode();
      _ownsFocusNode = widget.focusNode == null;
      _focusNode.addListener(_onFocusChange);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (_ownsFocusNode) {
      _focusNode.dispose();
    }
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  /// Handles focus change events
  void _onFocusChange() {
    if (!kDebugMode) return;
    if (_focusNode.hasFocus) {
      EwaLogger.debug('TextField focused: ${widget.hintText ?? 'Untitled'}');
    } else {
      EwaLogger.debug('TextField unfocused: ${widget.hintText ?? 'Untitled'}');
    }
  }

  /// Applies formatting to the text field content
  void _formatText() {
    if (widget.formatter == null || _isFormatting) return;

    final originalText = _controller.text;
    final formattedText = widget.formatter!(originalText);

    // Only update if the text has changed
    if (originalText != formattedText) {
      setState(() {
        _isFormatting = true;
      });

      try {
        _controller.value = TextEditingValue(
          text: formattedText,
          selection: TextSelection.collapsed(offset: formattedText.length),
        );
      } finally {
        setState(() {
          _isFormatting = false;
        });
      }
    }
  }

  static double _safeFontSize(double scaled) =>
      scaled.isFinite && scaled > 0 ? scaled : 16.0;

  @override
  Widget build(BuildContext context) {
    final variantData = widget.variant.data(context);
    final fontSize = _safeFontSize(16.sp);

    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      obscureText: widget.obscureText,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatters,
      onChanged: (value) {
        if (kDebugMode) {
          EwaLogger.debug('TextField input: $value');
        }
        widget.onChanged?.call(value);
      },
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onSubmitted,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      style: TextStyle(color: variantData.textColor, fontSize: fontSize),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: variantData.hintColor, fontSize: fontSize),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        filled: true,
        fillColor: widget.fillColor ?? variantData.fillColor,
        contentPadding: EdgeInsets.symmetric(
          horizontal: EwaTextFieldConstants.defaultPaddingHorizontal.w,
          vertical: EwaTextFieldConstants.defaultPaddingVertical.h,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius.r),
          borderSide: BorderSide(
            color: widget.enabledBorderColor ?? variantData.enabledBorderColor,
            width: EwaTextFieldConstants.borderWidth.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius.r),
          borderSide: BorderSide(
            color: widget.focusedBorderColor ?? variantData.focusedBorderColor,
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
