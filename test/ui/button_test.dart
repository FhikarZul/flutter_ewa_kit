import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ewa_kit/ui/button/ewa_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  group('EwaButton', () {
    testWidgets('should render with default properties', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              home: Scaffold(
                body: EwaButton(label: 'Test Button', onPressed: () async {}),
              ),
            );
          },
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(MaterialButton), findsOneWidget);
    });

    testWidgets('should render with primary variant', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              home: Scaffold(
                body: EwaButton.primary(
                  label: 'Primary Button',
                  onPressed: () async {},
                ),
              ),
            );
          },
        ),
      );

      expect(find.text('Primary Button'), findsOneWidget);
      expect(find.byType(MaterialButton), findsOneWidget);
    });

    testWidgets('should render with secondary variant', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              home: Scaffold(
                body: EwaButton.secondary(
                  label: 'Secondary Button',
                  onPressed: () async {},
                ),
              ),
            );
          },
        ),
      );

      expect(find.text('Secondary Button'), findsOneWidget);
      expect(find.byType(MaterialButton), findsOneWidget);
    });

    testWidgets('should render with tertiary variant', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              home: Scaffold(
                body: EwaButton.tertiary(
                  label: 'Tertiary Button',
                  onPressed: () async {},
                ),
              ),
            );
          },
        ),
      );

      expect(find.text('Tertiary Button'), findsOneWidget);
      expect(find.byType(MaterialButton), findsOneWidget);
    });

    testWidgets('should render with danger variant', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              home: Scaffold(
                body: EwaButton.danger(
                  label: 'Danger Button',
                  onPressed: () async {},
                ),
              ),
            );
          },
        ),
      );

      expect(find.text('Danger Button'), findsOneWidget);
      expect(find.byType(MaterialButton), findsOneWidget);
    });

    testWidgets('should be disabled when enable is false', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              home: Scaffold(
                body: EwaButton(
                  label: 'Disabled Button',
                  enable: false,
                  onPressed: () async {},
                ),
              ),
            );
          },
        ),
      );

      final button = tester.widget<MaterialButton>(find.byType(MaterialButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('should call onPressed when tapped', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              home: Scaffold(
                body: EwaButton(
                  label: 'Tap Button',
                  onPressed: () async {
                    tapped = true;
                  },
                ),
              ),
            );
          },
        ),
      );

      await tester.tap(find.text('Tap Button'));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('should not call onPressed when disabled', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              home: Scaffold(
                body: EwaButton(
                  label: 'Disabled Button',
                  enable: false,
                  onPressed: () async {
                    tapped = true;
                  },
                ),
              ),
            );
          },
        ),
      );

      await tester.tap(find.text('Disabled Button'));
      await tester.pumpAndSettle();

      expect(tapped, isFalse);
    });

    testWidgets('should show loading indicator when debouncing', (
      tester,
    ) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              home: Scaffold(
                body: EwaButton(
                  label: 'Loading Button',
                  onPressed: () async {
                    await Future.delayed(const Duration(milliseconds: 100));
                  },
                  debounce: true,
                ),
              ),
            );
          },
        ),
      );

      // Initial state
      expect(find.text('Loading Button'), findsOneWidget);

      // Tap the button
      await tester.tap(find.text('Loading Button'));
      await tester.pump(); // Pump once to start the animation

      // Should show loading indicator (SpinKitCircle)
      expect(find.byType(SpinKitCircle), findsWidgets);

      // Wait for debounce to complete and clean up
      await tester.pumpAndSettle();
    });

    group('EwaButtonConstants', () {
      test('should have correct constant values', () {
        expect(
          EwaButtonConstants.debounceDuration,
          const Duration(milliseconds: 500),
        );
        expect(EwaButtonConstants.defaultSpinnerSize, 20.0);
        expect(EwaButtonConstants.borderWidth, 1.0);
      });
    });
  });
}
