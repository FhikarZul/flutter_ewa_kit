import 'package:ewa_kit/ui/typography/ewa_typography_token.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EwaTypography {
  const EwaTypography._();

  static TextStyle _base({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextDecoration? decoration,
    List<FontFeature>? fontFeatures,
    double? height,
    double? letterSpacing,
    double? wordSpacing,
  }) {
    final baseSize = fontSize ?? EwaTypographyToken.body.fontSize;
    final scaledSize = baseSize * 1.sp;
    final safeFontSize =
        scaledSize.isFinite && scaledSize > 0 ? scaledSize : baseSize;
    return GoogleFonts.poppins(
      fontSize: safeFontSize,
      color: color,
      fontWeight: fontWeight ?? EwaTypographyToken.body.fontWeight,
      decoration: decoration,
      height: height,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      fontFeatures: fontFeatures,
    );
  }

  static TextStyle heading3Xl({
    Color? color,
    TextDecoration? decoration,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    List<FontFeature>? fontFeatures,
    double? wordSpacing,
  }) => _base(
    fontSize: EwaTypographyToken.heading3Xl.fontSize,
    color: color,
    height: height,
    fontWeight: fontWeight ?? EwaTypographyToken.heading3Xl.fontWeight,
    wordSpacing: wordSpacing,
    fontFeatures: fontFeatures,
    letterSpacing: letterSpacing,
  );

  static TextStyle heading2Xl({
    Color? color,
    TextDecoration? decoration,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    double? wordSpacing,
    List<FontFeature>? fontFeatures,
  }) => _base(
    fontSize: EwaTypographyToken.heading2Xl.fontSize,
    color: color,
    height: height,
    fontWeight: fontWeight ?? EwaTypographyToken.heading2Xl.fontWeight,
    wordSpacing: wordSpacing,
    fontFeatures: fontFeatures,
    letterSpacing: letterSpacing,
  );

  static TextStyle headingXl({
    Color? color,
    TextDecoration? decoration,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    double? wordSpacing,
    List<FontFeature>? fontFeatures,
  }) => _base(
    fontSize: EwaTypographyToken.headingXl.fontSize,
    color: color,
    height: height,
    fontWeight: fontWeight ?? EwaTypographyToken.headingXl.fontWeight,
    wordSpacing: wordSpacing,
    letterSpacing: letterSpacing,
    fontFeatures: fontFeatures,
  );

  static TextStyle headingLg({
    Color? color,
    TextDecoration? decoration,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    double? wordSpacing,
    List<FontFeature>? fontFeatures,
  }) => _base(
    fontSize: EwaTypographyToken.headingLg.fontSize,
    color: color,
    height: height,
    fontWeight: fontWeight ?? EwaTypographyToken.headingLg.fontWeight,
    wordSpacing: wordSpacing,
    letterSpacing: letterSpacing,
    fontFeatures: fontFeatures,
  );

  static TextStyle heading({
    Color? color,
    TextDecoration? decoration,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    double? wordSpacing,
    List<FontFeature>? fontFeatures,
  }) => _base(
    fontSize: EwaTypographyToken.heading.fontSize,
    color: color,
    height: height,
    fontWeight: fontWeight ?? EwaTypographyToken.heading.fontWeight,
    wordSpacing: wordSpacing,
    letterSpacing: letterSpacing,
    fontFeatures: fontFeatures,
  );

  static TextStyle headingSm({
    Color? color,
    TextDecoration? decoration,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    double? wordSpacing,
    List<FontFeature>? fontFeatures,
  }) => _base(
    fontSize: EwaTypographyToken.headingSm.fontSize,
    color: color,
    height: height,
    fontWeight: fontWeight ?? EwaTypographyToken.headingSm.fontWeight,
    wordSpacing: wordSpacing,
    letterSpacing: letterSpacing,
    fontFeatures: fontFeatures,
  );

  static TextStyle headingXs({
    Color? color,
    FontWeight? fontWeight,
    TextDecoration? decoration,
    double? height,
    double? letterSpacing,
    double? wordSpacing,
    List<FontFeature>? fontFeatures,
  }) => _base(
    fontSize: EwaTypographyToken.headingXs.fontSize,
    color: color,
    height: height,
    fontWeight: fontWeight ?? EwaTypographyToken.headingXs.fontWeight,
    wordSpacing: wordSpacing,
    letterSpacing: letterSpacing,
    fontFeatures: fontFeatures,
  );

  static TextStyle bodyLg({
    Color? color,
    FontWeight? fontWeight,
    TextDecoration? decoration,
    double? height,
    double? letterSpacing,
    double? wordSpacing,
    List<FontFeature>? fontFeatures,
  }) => _base(
    fontSize: EwaTypographyToken.bodyLg.fontSize,
    color: color,
    height: height,
    fontWeight: fontWeight ?? EwaTypographyToken.bodyLg.fontWeight,
    wordSpacing: wordSpacing,
    letterSpacing: letterSpacing,
    fontFeatures: fontFeatures,
  );

  static TextStyle body({
    Color? color,
    FontWeight? fontWeight,
    TextDecoration? decoration,
    double? height,
    double? letterSpacing,
    double? wordSpacing,
    List<FontFeature>? fontFeatures,
  }) => _base(
    color: color,
    height: height,
    fontWeight: fontWeight,
    wordSpacing: wordSpacing,
    letterSpacing: letterSpacing,
    fontFeatures: fontFeatures,
  );

  static TextStyle bodySm({
    Color? color,
    FontWeight? fontWeight,
    TextDecoration? decoration,
    double? height,
    double? letterSpacing,
    double? wordSpacing,
    List<FontFeature>? fontFeatures,
  }) => _base(
    fontSize: EwaTypographyToken.bodySm.fontSize,
    color: color,
    height: height,
    fontWeight: fontWeight ?? EwaTypographyToken.bodySm.fontWeight,
    wordSpacing: wordSpacing,
    letterSpacing: letterSpacing,
    fontFeatures: fontFeatures,
  );

  static TextStyle bodyXs({
    Color? color,
    FontWeight? fontWeight,
    TextDecoration? decoration,
    double? height,
    double? letterSpacing,
    double? wordSpacing,
    List<FontFeature>? fontFeatures,
  }) => _base(
    fontSize: EwaTypographyToken.bodyXs.fontSize,
    color: color,
    height: height,
    fontWeight: fontWeight ?? EwaTypographyToken.bodyXs.fontWeight,
    wordSpacing: wordSpacing,
    letterSpacing: letterSpacing,
    fontFeatures: fontFeatures,
  );
}
