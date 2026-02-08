import 'package:ewa_kit/foundations/color/color.dart';
import 'package:ewa_kit/ui/button/data/data.dart';
import 'package:flutter/material.dart';

enum EwaButtonType {
  filled,
  outline,
  text;

  ButtonStyleData data(BuildContext context) => switch (this) {
    filled => ButtonStyleData(
      disabledBgColor: EwaColorFoundation.resolveColor(
        context,
        EwaColorFoundation.neutral300,
        EwaColorFoundation.neutral600,
      ),
      disabledFgColor: EwaColorFoundation.resolveColor(
        context,
        EwaColorFoundation.neutral500,
        EwaColorFoundation.neutral400,
      ),
      disabledBorderColor: Colors.transparent,
    ),
    outline => ButtonStyleData(
      disabledBgColor: Colors.transparent,
      disabledFgColor: EwaColorFoundation.resolveColor(
        context,
        EwaColorFoundation.neutral500,
        EwaColorFoundation.neutral400,
      ),
      disabledBorderColor: EwaColorFoundation.resolveColor(
        context,
        EwaColorFoundation.neutral300,
        EwaColorFoundation.neutral600,
      ),
    ),
    text => ButtonStyleData(
      disabledBgColor: Colors.transparent,
      disabledFgColor: EwaColorFoundation.resolveColor(
        context,
        EwaColorFoundation.neutral500,
        EwaColorFoundation.neutral400,
      ),
      disabledBorderColor: Colors.transparent,
    ),
  };
}
