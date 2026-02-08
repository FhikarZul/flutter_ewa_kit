import 'package:ewa_kit/foundations/config/ewa_kit_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EwaApp extends StatelessWidget {
  final Widget? child;
  final Size? designSize;
  final bool minTextAdapt;
  final bool splitScreenMode;

  const EwaApp({
    super.key,
    this.child,
    this.designSize,
    this.minTextAdapt = true,
    this.splitScreenMode = true,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: designSize ?? EwaKitConfig.designSize,
      minTextAdapt: minTextAdapt,
      splitScreenMode: splitScreenMode,
      ensureScreenSize: true,
      child: child,
    );
  }
}
