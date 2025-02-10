import 'package:desafio_guia_motel/components/fields_components/bar_itens_suite_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BarItensSuiteComponent', () {
    late List<Map<String, String>> testItems;
    late String testSuiteName;

    setUp(() {
      testSuiteName = 'Suíte Luxo';
      testItems = [
        {'icone': 'https://via.placeholder.com/50', 'nome': 'TV'},
        {'icone': 'https://via.placeholder.com/50', 'nome': 'Wi-Fi'},
        {'icone': 'https://via.placeholder.com/50', 'nome': 'Banheira'},
      ];
    });

    testWidgets('Renderiza corretamente com os itens fornecidos',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarItensSuiteComponent(
              items: testItems,
              suiteName: testSuiteName,
            ),
          ),
        ),
      );

      expect(
          find.text(testSuiteName), findsNothing); 

      expect(find.byType(Image), findsNWidgets(3)); 
    });

    testWidgets('Exibe botão "Ver todos" quando há mais de 3 itens',
        (WidgetTester tester) async {
      final extendedItems = List<Map<String, String>>.from(testItems)
        ..add({'icone': 'https://via.placeholder.com/50', 'nome': 'Piscina'});

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarItensSuiteComponent(
              items: extendedItems,
              suiteName: testSuiteName,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.more_horiz), findsOneWidget);
    });

    testWidgets('Exibe popup ao clicar no botão "Ver todos"',
        (WidgetTester tester) async {
      final extendedItems = List<Map<String, String>>.from(testItems)
        ..add({'icone': 'https://via.placeholder.com/50', 'nome': 'Piscina'});

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BarItensSuiteComponent(
              items: extendedItems,
              suiteName: testSuiteName,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.more_horiz));
      await tester.pumpAndSettle();

      expect(find.text("Itens disponíveis da Suíte Luxo"), findsOneWidget);
    });
  });
}
