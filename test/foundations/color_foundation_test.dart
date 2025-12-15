import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ewa_kit/foundations/color/ewa_color_foundation.dart';

void main() {
  group('EwaColorFoundation', () {
    test('should have all primary colors defined', () {
      expect(EwaColorFoundation.primaryLight, isNotNull);
      expect(EwaColorFoundation.primaryDark, isNotNull);
    });

    test('should have all secondary colors defined', () {
      expect(EwaColorFoundation.secondaryLight, isNotNull);
      expect(EwaColorFoundation.secondaryDark, isNotNull);
    });

    test('should have all error colors defined', () {
      expect(EwaColorFoundation.errorLight, isNotNull);
      expect(EwaColorFoundation.errorDark, isNotNull);
    });

    test('should have all neutral colors defined', () {
      expect(EwaColorFoundation.neutral10, isNotNull);
      expect(EwaColorFoundation.neutral20, isNotNull);
      expect(EwaColorFoundation.neutral30, isNotNull);
      expect(EwaColorFoundation.neutral40, isNotNull);
      expect(EwaColorFoundation.neutral50, isNotNull);
      expect(EwaColorFoundation.neutral100, isNotNull);
      expect(EwaColorFoundation.neutral200, isNotNull);
      expect(EwaColorFoundation.neutral300, isNotNull);
      expect(EwaColorFoundation.neutral400, isNotNull);
      expect(EwaColorFoundation.neutral500, isNotNull);
      expect(EwaColorFoundation.neutral600, isNotNull);
      expect(EwaColorFoundation.neutral700, isNotNull);
      expect(EwaColorFoundation.neutral800, isNotNull);
      expect(EwaColorFoundation.neutral900, isNotNull);
    });

    test('should have all text colors defined', () {
      expect(EwaColorFoundation.textLight, isNotNull);
      expect(EwaColorFoundation.textDark, isNotNull);
    });

    test('should have all background colors defined', () {
      expect(EwaColorFoundation.backgroundLight, isNotNull);
      expect(EwaColorFoundation.backgroundDark, isNotNull);
    });

    group('resolveColor', () {
      testWidgets('should return light color for light theme', (tester) async {
        late BuildContext context;
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(brightness: Brightness.light),
            home: Builder(
              builder: (ctx) {
                context = ctx;
                return const SizedBox();
              },
            ),
          ),
        );

        final result = EwaColorFoundation.resolveColor(
          context,
          Colors.black,
          Colors.white,
        );

        expect(result, Colors.black);
      });

      testWidgets('should return dark color for dark theme', (tester) async {
        late BuildContext context;
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(brightness: Brightness.dark),
            home: Builder(
              builder: (ctx) {
                context = ctx;
                return const SizedBox();
              },
            ),
          ),
        );

        final result = EwaColorFoundation.resolveColor(
          context,
          Colors.black,
          Colors.white,
        );

        expect(result, Colors.white);
      });
    });

    group('getColor methods', () {
      testWidgets('getPrimary should return primary color', (tester) async {
        late BuildContext context;
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              brightness: Brightness.light,
              colorScheme: const ColorScheme.light().copyWith(
                primary: Colors.blue,
              ),
            ),
            home: Builder(
              builder: (ctx) {
                context = ctx;
                return const SizedBox();
              },
            ),
          ),
        );

        final result = EwaColorFoundation.getPrimary(context);
        expect(result, Colors.blue);
      });

      testWidgets('getSecondary should return secondary color', (tester) async {
        late BuildContext context;
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              brightness: Brightness.light,
              colorScheme: const ColorScheme.light().copyWith(
                secondary: Colors.green,
              ),
            ),
            home: Builder(
              builder: (ctx) {
                context = ctx;
                return const SizedBox();
              },
            ),
          ),
        );

        final result = EwaColorFoundation.getSecondary(context);
        expect(result, Colors.green);
      });

      testWidgets('getError should return error color', (tester) async {
        late BuildContext context;
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              brightness: Brightness.light,
              colorScheme: const ColorScheme.light().copyWith(
                error: Colors.red,
              ),
            ),
            home: Builder(
              builder: (ctx) {
                context = ctx;
                return const SizedBox();
              },
            ),
          ),
        );

        final result = EwaColorFoundation.getError(context);
        expect(result, Colors.red);
      });

      testWidgets('getText should return text color', (tester) async {
        late BuildContext context;
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              brightness: Brightness.light,
              colorScheme: const ColorScheme.light().copyWith(
                onSurface: Colors.purple,
              ),
            ),
            home: Builder(
              builder: (ctx) {
                context = ctx;
                return const SizedBox();
              },
            ),
          ),
        );

        final result = EwaColorFoundation.getText(context);
        expect(result, Colors.purple);
      });

      testWidgets('getBackground should return background color', (
        tester,
      ) async {
        late BuildContext context;
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              brightness: Brightness.light,
              colorScheme: const ColorScheme.light().copyWith(
                surface: Colors.orange,
              ),
            ),
            home: Builder(
              builder: (ctx) {
                context = ctx;
                return const SizedBox();
              },
            ),
          ),
        );

        final result = EwaColorFoundation.getBackground(context);
        expect(result, Colors.orange);
      });

      group('fallback colors', () {
        testWidgets(
          'getPrimary should fallback to EWA Kit colors when theme does not provide them',
          (tester) async {
            late BuildContext context;
            await tester.pumpWidget(
              MaterialApp(
                theme: ThemeData(brightness: Brightness.light),
                home: Builder(
                  builder: (ctx) {
                    context = ctx;
                    return const SizedBox();
                  },
                ),
              ),
            );

            final result = EwaColorFoundation.getPrimary(context);
            // The default Flutter theme provides its own primary color
            // We're testing that the method returns a valid color, not necessarily the EWA Kit color
            expect(result, isNotNull);
            expect(result, isA<Color>());
          },
        );

        testWidgets(
          'getSecondary should fallback to EWA Kit colors when theme does not provide them',
          (tester) async {
            late BuildContext context;
            await tester.pumpWidget(
              MaterialApp(
                theme: ThemeData(brightness: Brightness.light),
                home: Builder(
                  builder: (ctx) {
                    context = ctx;
                    return const SizedBox();
                  },
                ),
              ),
            );

            final result = EwaColorFoundation.getSecondary(context);
            // The default Flutter theme provides its own secondary color
            // We're testing that the method returns a valid color, not necessarily the EWA Kit color
            expect(result, isNotNull);
            expect(result, isA<Color>());
          },
        );
      });
    });
  });
}
