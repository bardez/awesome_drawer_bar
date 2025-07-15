import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AwesomeDrawerBar Swipe Control Tests', () {
    testWidgets('should create drawer with swipe control properties',
        (WidgetTester tester) async {
      final controller = AwesomeDrawerBarController();

      await tester.pumpWidget(
        MaterialApp(
          home: AwesomeDrawerBar(
            controller: controller,
            mainScreen: Container(color: Colors.blue),
            menuScreen: Container(color: Colors.red),
            isSwipeEnabled: false,
            swipeEnabledRoutes: ['/home', '/profile'],
          ),
        ),
      );

      // Check if the widget was created correctly
      expect(find.byType(AwesomeDrawerBar), findsOneWidget);
    });

    testWidgets('should create drawer with default swipe control values',
        (WidgetTester tester) async {
      final controller = AwesomeDrawerBarController();

      await tester.pumpWidget(
        MaterialApp(
          home: AwesomeDrawerBar(
            controller: controller,
            mainScreen: Container(color: Colors.blue),
            menuScreen: Container(color: Colors.red),
          ),
        ),
      );

      // Check if the widget was created correctly
      expect(find.byType(AwesomeDrawerBar), findsOneWidget);
    });

    testWidgets('should create drawer with custom swipe control values',
        (WidgetTester tester) async {
      final controller = AwesomeDrawerBarController();

      await tester.pumpWidget(
        MaterialApp(
          home: AwesomeDrawerBar(
            controller: controller,
            mainScreen: Container(color: Colors.blue),
            menuScreen: Container(color: Colors.red),
            isSwipeEnabled: true,
            swipeEnabledRoutes: ['/home', '/profile', '/settings'],
          ),
        ),
      );

      // Check if the widget was created correctly
      expect(find.byType(AwesomeDrawerBar), findsOneWidget);
    });
  });
}
