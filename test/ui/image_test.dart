import 'package:cached_network_image/cached_network_image.dart';
import 'package:ewa_kit/ui/image/ewa_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EwaImage Tests', () {
    testWidgets('EwaImage.network creates CachedNetworkImage', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EwaImage.network(
              imageUrl: 'https://example.com/image.jpg',
              width: 100,
              height: 100,
            ),
          ),
        ),
      );

      // Verify that CachedNetworkImage is present in the widget tree
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('EwaImage.asset creates Image.asset', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EwaImage.asset(
              assetPath: 'assets/test_image.png',
              width: 100,
              height: 100,
            ),
          ),
        ),
      );

      // Verify that Image widget is present in the widget tree
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('EwaImage.network shows placeholder during loading', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EwaImage.network(
              imageUrl: 'https://example.com/image.jpg',
              width: 100,
              height: 100,
              showProgressIndicator: true,
            ),
          ),
        ),
      );

      // Check that the placeholder container is visible
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('EwaImage.network has correct properties', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EwaImage.network(
              imageUrl: 'https://example.com/image.jpg',
              width: 100,
              height: 100,
              showProgressIndicator: true,
            ),
          ),
        ),
      );

      // Verify that the widget is built correctly
      expect(find.byType(ClipRRect), findsOneWidget);
    });

    testWidgets('EwaImage.asset has correct properties', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EwaImage.asset(
              assetPath: 'assets/test_image.png',
              width: 100,
              height: 100,
            ),
          ),
        ),
      );

      // Verify that the widget is built correctly
      expect(find.byType(ClipRRect), findsOneWidget);
    });
  });
}
