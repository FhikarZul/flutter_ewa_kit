import 'package:ewa_kit/ewa_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  group('EwaSelect', () {
    testWidgets('should render with static items', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              home: Scaffold(
                body: EwaSelect<String>(
                  items: [
                    const EwaSelectItem(value: 'a', label: 'Option A'),
                    const EwaSelectItem(value: 'b', label: 'Option B'),
                  ],
                  value: null,
                  onChanged: (_) {},
                ),
              ),
            );
          },
        ),
      );

      expect(find.text('Pilih'), findsWidgets);
    });

    testWidgets('should display selected value', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              home: Scaffold(
                body: EwaSelect<String>(
                  items: [
                    const EwaSelectItem(value: 'a', label: 'Option A'),
                    const EwaSelectItem(value: 'b', label: 'Option B'),
                  ],
                  value: 'a',
                  onChanged: (_) {},
                ),
              ),
            );
          },
        ),
      );

      expect(find.text('Option A'), findsOneWidget);
    });

    testWidgets('should show options when tapped', (tester) async {
      String? selected;
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              home: Scaffold(
                body: EwaSelect<String>(
                  items: [
                    const EwaSelectItem(value: 'a', label: 'Option A'),
                    const EwaSelectItem(value: 'b', label: 'Option B'),
                  ],
                  value: selected,
                  onChanged: (v) => selected = v,
                ),
              ),
            );
          },
        ),
      );

      await tester.tap(find.text('Pilih').first, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.text('Option A'), findsOneWidget);
      expect(find.text('Option B'), findsOneWidget);
    });
  });
}
