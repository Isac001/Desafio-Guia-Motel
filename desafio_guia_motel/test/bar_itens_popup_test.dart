import 'package:desafio_guia_motel/components/fields_components/popup_itens_suite_component.dart';
import 'package:desafio_guia_motel/components/widget_components/text_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Grouping tests related to PopupItensComponent
  group('PopupItensComponent', () {
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
        {'icone': 'https://via.placeholder.com/50', 'nome': 'Piscina'},
      ];
    });

    // Test: Verifies that the popup renders correctly with the suite name and main items
    testWidgets(
        'Renderiza corretamente o nome da suíte e a seção "Principais Itens"',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PopupItensComponent(
              suiteName: testSuiteName,
              items: testItems,
            ),
          ),
        ),
      );

      // Checks if the suite name is displayed in uppercase
      expect(find.text(testSuiteName.toUpperCase()), findsOneWidget);

      // Checks if the "Principais Itens" section is displayed
      expect(find.text("PRINCIPAIS ITENS"), findsOneWidget);

      // Ensures that up to 3 main item images are displayed
      expect(find.byType(Image), findsNWidgets(3));

      // Ensures that at least 3 TextComponent widgets are rendered
      expect(find.byType(TextComponent), findsAtLeastNWidgets(3));
    });

    // Test: Ensures the "Tem também" section is displayed correctly with additional items
    testWidgets('Exibe a seção "Tem também" e os itens extras', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PopupItensComponent(
              suiteName: testSuiteName,
              items: testItems,
            ),
          ),
        ),
      );

      // Checks if the "Tem também" section is displayed
      expect(find.text("TEM TAMBÉM"), findsOneWidget);

      // Ensures that items beyond the first three appear in the "Tem também" section
      expect(find.text("Piscina"), findsOneWidget);
    });

    // Test: Ensures that the popup closes when the "Fechar" button is clicked
    testWidgets('Fecha o popup ao clicar no botão "Fechar"', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PopupItensComponent(
              suiteName: testSuiteName,
              items: testItems,
            ),
          ),
        ),
      );

      // Finds the "Fechar" button within the popup
      final closeButtonFinder = find.widgetWithText(ElevatedButton, 'Fechar');
      expect(closeButtonFinder, findsOneWidget);

      // Simulates clicking the "Fechar" button
      await tester.tap(closeButtonFinder);
      await tester.pumpAndSettle();

      // Ensures that the popup is closed (should no longer exist in the widget tree)
      expect(find.byType(PopupItensComponent), findsNothing);
    });
  });
}
