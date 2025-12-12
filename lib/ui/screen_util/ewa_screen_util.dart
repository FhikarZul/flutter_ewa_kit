import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// EWA Kit Screen Util Wrapper
///
/// This widget wraps the ScreenUtilInit to provide responsive design capabilities
/// while encapsulating the screenutil dependency.
///
/// Usage:
/// ```dart
/// return EwaScreenUtilInit(
///   child: MaterialApp(
///     // Your app content
///   ),
/// );
/// ```
class EwaScreenUtilInit extends StatelessWidget {
  final Widget? child;
  final Size designSize;
  final bool minTextAdapt;
  final bool splitScreenMode;

  const EwaScreenUtilInit({
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
