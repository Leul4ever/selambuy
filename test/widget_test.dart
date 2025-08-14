// This is a basic Flutter widget test for the Gebiya eCommerce app.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gebiya/main.dart';

void main() {
  testWidgets('App should start with splash page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the splash page is displayed
    expect(find.text('GEBIYA'), findsOneWidget);

    // Wait for navigation to onboarding
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Verify that we're on the onboarding page
    expect(find.text('Explore Fashion Trends with Gebiya'), findsOneWidget);
  });

  testWidgets('Navigation should work correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Wait for navigation to onboarding
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Navigate to main navigation
    await tester.tap(find.text('Let\'s Get Started'));
    await tester.pumpAndSettle();

    // Verify that bottom navigation is present
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    // Verify that home tab is selected by default
    expect(find.text('Welcome to Gebiya'), findsOneWidget);
  });
}
