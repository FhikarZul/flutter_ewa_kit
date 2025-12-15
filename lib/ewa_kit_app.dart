import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EwaApp extends StatelessWidget {
  final Widget? child;
  final Size designSize;
  final bool minTextAdapt;
  final bool splitScreenMode;

  const EwaApp({
    super.key,
    this.child,
    this.designSize = const Size(375, 812), // Standard iPhone X size
    this.minTextAdapt = true,
    this.splitScreenMode = true,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: designSize,
      minTextAdapt: minTextAdapt,
      splitScreenMode: splitScreenMode,
      child: child,
    );
  }
}
