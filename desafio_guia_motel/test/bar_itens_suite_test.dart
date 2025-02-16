// Importing necessary components and packages
import 'package:desafio_guia_motel/components/fields_components/bar_itens_suite_component.dart';
import 'package:desafio_guia_motel/components/fields_components/popup_itens_suite_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Main function to run widget tests
void main() {
  // Grouping tests for BarItensComponent
  group('BarItensComponent', () {
    // Variables for test data
    late List<Map<String, String>> testItems;
    late String testSuiteName;

    // Setup method to initialize test data before each test
    setUp(() {
      testSuiteName = 'Suíte Luxo';
      testItems = [
        {'icone': 'https://via.placeholder.com/50', 'nome': 'TV'},
        {'icone': 'https://via.placeholder.com/50', 'nome': 'Wi-Fi'},
        {'icone': 'https://via.placeholder.com/50', 'nome': 'Banheira'},
      ];
    });

    // Test: Verifies that BarItensComponent renders correctly with provided items
    testWidgets('Renderiza corretamente com os itens fornecidos', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarItensComponent(
              items: testItems,
              suiteName: testSuiteName,
            ),
          ),
        ),
      );

      // Ensures that all item icons are displayed
      expect(find.byType(Image), findsNWidgets(3));

      // Checks that the suite name is NOT displayed within the component itself
      expect(find.text(testSuiteName), findsNothing);
    });

    // Test: Ensures "Ver todos" button appears when there are more than 3 items
    testWidgets('Exibe botão "Ver todos" quando há mais de 3 itens', (tester) async {
      final extendedItems = [
        ...testItems,
        {'icone': 'https://via.placeholder.com/50', 'nome': 'Piscina'}
      ];

      // Pumping the widget into the test environment
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarItensComponent(
              items: extendedItems,
              suiteName: testSuiteName,
            ),
          ),
        ),
      );

      // Verifies that the "more" button appears
      expect(find.byIcon(Icons.more_horiz), findsOneWidget);
    });

    // Test: Ensures the popup is displayed when clicking the "Ver todos" button
    testWidgets('Exibe popup ao clicar no botão "Ver todos"', (tester) async {
      final extendedItems = [
        ...testItems,
        {'icone': 'https://via.placeholder.com/50', 'nome': 'Piscina'}
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarItensComponent(
              items: extendedItems,
              suiteName: testSuiteName,
            ),
          ),
        ),
      );

      // Simulates a tap on the "Ver todos" button
      await tester.tap(find.byIcon(Icons.more_horiz));
      await tester.pumpAndSettle();

      // Ensures the popup is displayed with the correct suite name
      expect(find.byType(PopupItensComponent), findsOneWidget);
      expect(find.text(testSuiteName.toUpperCase()), findsOneWidget);
    });

    // Test: Ensures the popup closes when clicking the "Fechar" button
    testWidgets('Fechar popup ao clicar no botão "Fechar"', (tester) async {
      final extendedItems = [
        ...testItems,
        {'icone': 'https://via.placeholder.com/50', 'nome': 'Piscina'}
      ];

      // Pumping the widget into the test environment
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarItensComponent(
              items: extendedItems,
              suiteName: testSuiteName,
            ),
          ),
        ),
      );

      // Opens the popup
      await tester.tap(find.byIcon(Icons.more_horiz));
      await tester.pumpAndSettle();

      // Finds and taps the "Fechar" button inside the popup
      final closeButtonFinder = find.widgetWithText(ElevatedButton, 'Fechar');
      expect(closeButtonFinder, findsOneWidget);

      await tester.tap(closeButtonFinder);
      await tester.pumpAndSettle();

      // Confirms that the popup is no longer visible
      expect(find.byType(PopupItensComponent), findsNothing);
    });
  });
}
