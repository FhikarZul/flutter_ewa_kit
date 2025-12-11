import 'package:ewa_kit/foundations/size/ewa_border_radius.dart';
import 'package:ewa_kit/foundations/size/ewa_dimension.dart';
import 'package:ewa_kit/ui/button/data/data.dart';
import 'package:ewa_kit/ui/typography/typography.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum EwaButtonSize {
  xs,
  sm,
  md,
  lg,
  xl;

  ButtonSizeData get data => switch (this) {
    xs => ButtonSizeData(
      padding: EdgeInsets.symmetric(
        vertical: EwaDimension.size8.h,
        horizontal: EwaDimension.size8.w,
      ),
      borderRadius: EwaBorderRadius.xs,
      textStyle: EwaTypography.bodyXs(fontWeight: FontWeight.w600),
      width: 34.w,
      height: 32.h,
    ),
    sm => ButtonSizeData(
      padding: EdgeInsets.symmetric(
        vertical: EwaDimension.size8.h,
        horizontal: EwaDimension.size12.w,
      ),
      borderRadius: EwaBorderRadius.sm,
      textStyle: EwaTypography.bodySm(fontWeight: FontWeight.w600),
      width: 40.w,
      height: 36.h,
    ),
    md => ButtonSizeData(
      padding: EdgeInsets.symmetric(
        vertical: EwaDimension.size8.h,
        horizontal: EwaDimension.size12.w,
      ),
      borderRadius: EwaBorderRadius.sm,
      textStyle: EwaTypography.bodySm(fontWeight: FontWeight.w600),
      width: 48.w,
      height: 40.h,
    ),
    lg => ButtonSizeData(
      padding: EdgeInsets.symmetric(
        vertical: EwaDimension.size12.h,
        horizontal: EwaDimension.size16.w,
      ),
      borderRadius: EwaBorderRadius.md,
      textStyle: EwaTypography.bodySm(fontWeight: FontWeight.w600),
      width: 64.w,
      height: 48.h,
    ),
    xl => ButtonSizeData(
      padding: EdgeInsets.all(EwaDimension.size16.r),
      borderRadius: EwaBorderRadius.md,
      textStyle: EwaTypography.body(fontWeight: FontWeight.w600),
      width: 120.sw,
      height: 56.h,
    ),
  };
}
