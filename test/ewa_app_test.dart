import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ewa_kit/ewa_kit_app.dart';
import 'package:ewa_kit/foundations/config/ewa_kit_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  group('EwaApp', () {
    tearDown(() {
      EwaKitConfig.resetToDefaults();
    });

    testWidgets('should render child', (tester) async {
      await tester.pumpWidget(
        EwaApp(
          child: MaterialApp(
            home: Scaffold(
              body: Text('Test', key: Key('test_text')),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(Key('test_text')), findsOneWidget);
    });

    testWidgets('should use EwaKitConfig.designSize when designSize is null',
        (tester) async {
      EwaKitConfig.designSize = const Size(414, 896);

      await tester.pumpWidget(
        EwaApp(
          child: MaterialApp(
            home: Scaffold(body: SizedBox()),
          ),
        ),
      );

      final screenUtilInit = tester.widget<ScreenUtilInit>(
        find.byType(ScreenUtilInit),
      );
      expect(screenUtilInit.designSize, const Size(414, 896));
    });

    testWidgets('should use provided designSize when specified', (tester) async {
      await tester.pumpWidget(
        EwaApp(
          designSize: const Size(320, 568),
          child: MaterialApp(
            home: Scaffold(body: SizedBox()),
          ),
        ),
      );

      final screenUtilInit = tester.widget<ScreenUtilInit>(
        find.byType(ScreenUtilInit),
      );
      expect(screenUtilInit.designSize, const Size(320, 568));
    });
  });
}
