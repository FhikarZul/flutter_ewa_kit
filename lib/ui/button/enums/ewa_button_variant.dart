import 'package:ewa_kit/foundations/size/size.dart';
import 'package:ewa_kit/ui/button/data/data.dart';
import 'package:flutter/material.dart';

enum EwaButtonVariant {
  primary,
  secondary,
  tertiary,
  danger;

  ButtonVariantData data(BuildContext context) => switch (this) {
    primary => ButtonVariantData(
      backgroundColor: EwaColorFoundation.getPrimary(context),
      outlineBgColor: Colors.transparent,
      outlineBorderColor: EwaColorFoundation.getPrimary(context),
      borderColor: EwaColorFoundation.getPrimary(context),
      outlineFgColor: EwaColorFoundation.getPrimary(context),
      foregroundColor: Theme.of(
        context,
      ).colorScheme.onPrimary, // Adapts to ColorScheme
    ),
    secondary => ButtonVariantData(
      backgroundColor: EwaColorFoundation.getSecondary(context),
      outlineBgColor: Colors.transparent,
      outlineBorderColor: EwaColorFoundation.getSecondary(context),
      borderColor: EwaColorFoundation.getSecondary(context),
      outlineFgColor: EwaColorFoundation.getSecondary(context),
      foregroundColor: Theme.of(
        context,
      ).colorScheme.onSecondary, // Adapts to ColorScheme
    ),
    tertiary => ButtonVariantData(
      backgroundColor: EwaColorFoundation.resolveColor(
        context,
        EwaColorFoundation.neutral200,
        EwaColorFoundation.neutral700,
      ),
      outlineBgColor: Colors.transparent,
      outlineBorderColor: EwaColorFoundation.resolveColor(
        context,
        EwaColorFoundation.neutral300,
        EwaColorFoundation.neutral600,
      ),
      borderColor: EwaColorFoundation.resolveColor(
        context,
        EwaColorFoundation.neutral400,
        EwaColorFoundation.neutral500,
      ),
      outlineFgColor: EwaColorFoundation.resolveColor(
        context,
        EwaColorFoundation.neutral600,
        EwaColorFoundation.neutral300,
      ),
      foregroundColor: EwaColorFoundation.resolveColor(
        context,
        EwaColorFoundation.neutral800,
        EwaColorFoundation.neutral200,
      ),
    ),
    danger => ButtonVariantData(
      backgroundColor: EwaColorFoundation.getError(context),
      outlineBgColor: Colors.transparent,
      outlineBorderColor: EwaColorFoundation.getError(context),
      borderColor: EwaColorFoundation.getError(context),
      outlineFgColor: EwaColorFoundation.getError(context),
      foregroundColor: Theme.of(
        context,
      ).colorScheme.onError, // Adapts to ColorScheme
    ),
  };
}
