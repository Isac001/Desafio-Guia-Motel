// Importing necessary components and packages
import 'package:desafio_guia_motel/components/fields_components/bar_itens_suite_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Main function to run widget tests
void main() {
  // Grouping tests related to BarItensSuiteComponent
  group('BarItensSuiteComponent', () {
    // Variables to store test data
    late List<Map<String, String>> testItems;
    late String testSuiteName;

    // Set up initial values before each test
    setUp(() {
      testSuiteName = 'Suíte Luxo';
      testItems = [
        {'icone': 'https://via.placeholder.com/50', 'nome': 'TV'},
        {'icone': 'https://via.placeholder.com/50', 'nome': 'Wi-Fi'},
        {'icone': 'https://via.placeholder.com/50', 'nome': 'Banheira'},
      ];
    });

    // Test to check if the component renders correctly with the given items
    testWidgets('Renders correctly with provided items',
        (WidgetTester tester) async {
      // Pumping the widget into the test environment
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarItensSwitchComponent(
              items: testItems,
              suiteName: testSuiteName,
            ),
          ),
        ),
      );

      // Expectation: The suite name should not be directly visible
      expect(find.text(testSuiteName), findsNothing);

      // Expectation: Three images (icons) should be found
      expect(find.byType(Image), findsNWidgets(3));
    });

    // Test to check if the "See All" button appears when there are more than 3 items
    testWidgets('Displays "See All" button when more than 3 items exist',
        (WidgetTester tester) async {
      // Adding a fourth item to trigger the "See All" button
      final extendedItems = List<Map<String, String>>.from(testItems)
        ..add({'icone': 'https://via.placeholder.com/50', 'nome': 'Piscina'});

      // Pumping the widget into the test environment
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarItensSwitchComponent(
              items: extendedItems,
              suiteName: testSuiteName,
            ),
          ),
        ),
      );

      // Expectation: The "more" icon should appear when there are more than 3 items
      expect(find.byIcon(Icons.more_horiz), findsOneWidget);
    });

    // Test to check if a popup appears when clicking the "See All" button
    testWidgets('Displays popup when clicking the "See All" button',
        (WidgetTester tester) async {
      // Adding a fourth item to trigger the popup feature
      final extendedItems = List<Map<String, String>>.from(testItems)
        ..add({'icone': 'https://via.placeholder.com/50', 'nome': 'Piscina'});

      // Pumping the widget into the test environment
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarItensSwitchComponent(
              items: extendedItems,
              suiteName: testSuiteName,
            ),
          ),
        ),
      );

      // Simulating a tap on the "See All" button
      await tester.tap(find.byIcon(Icons.more_horiz));
      await tester.pumpAndSettle();

      // Expectation: The popup should display the correct suite name
      expect(find.text("Itens disponíveis da Suíte Luxo"), findsOneWidget);
    });
  });
}
