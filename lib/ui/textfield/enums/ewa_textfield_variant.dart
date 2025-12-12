import 'package:ewa_kit/foundations/color/ewa_color_foundation.dart';
import 'package:flutter/material.dart';

/// Enum representing different TextField variants
enum EwaTextFieldVariant {
  primary,
  secondary,
  tertiary,
  danger;

  /// Returns the color data for this variant based on the current theme
  TextFieldVariantData data(BuildContext context) => switch (this) {
        primary => TextFieldVariantData(
              enabledBorderColor: EwaColorFoundation.getPrimary(context),
              focusedBorderColor: EwaColorFoundation.getPrimary(context),
              fillColor: EwaColorFoundation.resolveColor(
                context,
                EwaColorFoundation.neutral50,
                EwaColorFoundation.neutral800,
              ),
              textColor: EwaColorFoundation.getText(context),
              hintColor: EwaColorFoundation.resolveColor(
                context,
                EwaColorFoundation.neutral500,
                EwaColorFoundation.neutral400,
              ),
            ),
        secondary => TextFieldVariantData(
              enabledBorderColor: EwaColorFoundation.getSecondary(context),
              focusedBorderColor: EwaColorFoundation.getSecondary(context),
              fillColor: EwaColorFoundation.resolveColor(
                context,
                EwaColorFoundation.neutral50,
                EwaColorFoundation.neutral800,
              ),
              textColor: EwaColorFoundation.getText(context),
              hintColor: EwaColorFoundation.resolveColor(
                context,
                EwaColorFoundation.neutral500,
                EwaColorFoundation.neutral400,
              ),
            ),
        tertiary => TextFieldVariantData(
              enabledBorderColor: EwaColorFoundation.resolveColor(
                context,
                EwaColorFoundation.neutral300,
                EwaColorFoundation.neutral600,
              ),
              focusedBorderColor: EwaColorFoundation.resolveColor(
                context,
                EwaColorFoundation.neutral600,
                EwaColorFoundation.neutral300,
              ),
              fillColor: EwaColorFoundation.resolveColor(
                context,
                EwaColorFoundation.neutral50,
                EwaColorFoundation.neutral800,
              ),
              textColor: EwaColorFoundation.getText(context),
              hintColor: EwaColorFoundation.resolveColor(
                context,
                EwaColorFoundation.neutral500,
                EwaColorFoundation.neutral400,
              ),
            ),
        danger => TextFieldVariantData(
              enabledBorderColor: EwaColorFoundation.getError(context),
              focusedBorderColor: EwaColorFoundation.getError(context),
              fillColor: EwaColorFoundation.resolveColor(
                context,
                EwaColorFoundation.neutral50,
                EwaColorFoundation.neutral800,
              ),
              textColor: EwaColorFoundation.getText(context),
              hintColor: EwaColorFoundation.resolveColor(
                context,
                EwaColorFoundation.neutral500,
                EwaColorFoundation.neutral400,
              ),
            ),
      };
}

/// Data class holding color information for TextField variants
@immutable
class TextFieldVariantData {
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color fillColor;
  final Color textColor;
  final Color hintColor;

  const TextFieldVariantData({
    required this.enabledBorderColor,
    required this.focusedBorderColor,
    required this.fillColor,
    required this.textColor,
    required this.hintColor,
  });
}