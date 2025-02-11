import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desafio_guia_motel/components/fields_components/reserve_popup_component.dart';

void main() {
  group('ReservationPopup', () {
    late Map<String, dynamic> testPeriod;

    setUp(() {
      testPeriod = {
        'tempoFormatado': '12 horas',
        'valor': 200.0,
        'valorTotal': 180.0,
        'desconto': 20.0,
      };
    });

    testWidgets('Renderiza corretamente as informações da reserva', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReservationPopup(period: testPeriod),
          ),
        ),
      );

      // 🔹 Depuração: imprime todos os textos na tela se falhar
      final allTexts = find.byType(Text);
      final textWidgets = tester.widgetList<Text>(allTexts);
      for (final text in textWidgets) {
        debugPrint("Encontrado texto: ${text.data}");
      }

      // 🔹 Verifica se o período é exibido corretamente
      expect(find.text('Início do período'), findsOneWidget);
      expect(find.text('IMEDIATO'), findsOneWidget);
      expect(find.text('Período'), findsOneWidget);
      expect(find.text('12 horas'), findsOneWidget);

      // 🔹 Verifica se os valores financeiros aparecem corretamente
      expect(find.text('R\$ 200.00'), findsOneWidget);
      expect(find.text('R\$ 180.00'), findsOneWidget);

      // 🔹 Verifica se o desconto aparece corretamente (novo método flexível)
      expect(
        find.byWidgetPredicate((widget) =>
            widget is Text &&
            widget.data != null &&
            widget.data!.contains("R\$ 20")),
        findsOneWidget,
      );

      // 🔹 Verifica se as etapas de pagamento aparecem corretamente
      expect(find.textContaining('Pague agora para reservar'), findsOneWidget);
      expect(find.textContaining('Pague o restante no motel'), findsOneWidget);
    });

    testWidgets('Fecha o popup ao clicar no botão de fechar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReservationPopup(period: testPeriod),
          ),
        ),
      );

      // 🔹 Simula um clique no botão de fechar
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      // 🔹 O popup deve desaparecer da tela
      expect(find.byType(Dialog), findsNothing);
    });

    testWidgets('Fecha o popup ao clicar no botão "Reservar agora"', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReservationPopup(period: testPeriod),
          ),
        ),
      );

      // 🔹 Garante que o botão "Reservar agora" esteja visível antes de clicar
      final reservarButton = find.text('Reservar agora');
      await tester.ensureVisible(reservarButton);

      // 🔹 Simula um clique no botão "Reservar agora"
      await tester.tap(reservarButton);
      await tester.pumpAndSettle();

      // 🔹 O popup deve desaparecer da tela
      expect(find.byType(Dialog), findsNothing);
    });
  });
}
