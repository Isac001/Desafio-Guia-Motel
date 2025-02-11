import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desafio_guia_motel/components/fields_components/reserve_list_component.dart';

void main() {
  group('ReservationListComponent', () {
    late List<Map<String, dynamic>> testPeriods;

    setUp(() {
      testPeriods = [
        {
          'tempoFormatado': '2h',
          'valor': 100.0,
          'valorTotal': 80.0,
          'desconto': 20.0,
        },
        {
          'tempoFormatado': '4h',
          'valor': 150.0,
          'valorTotal': 150.0,
          'desconto': null,
        },
        {
          'tempoFormatado': '12 horas',
          'valor': 200.0,
          'valorTotal': 180.0,
          'desconto': 20.0,
        }
      ];
    });

    testWidgets('Renderiza corretamente os períodos e valores',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReserveListComponent(periods: testPeriods),
          ),
        ),
      );

      // Verifica se os textos dos períodos estão na tela
      expect(find.text('2h'), findsOneWidget);
      expect(find.text('4h'), findsOneWidget);
      expect(find.text('12 horas'), findsOneWidget);

      // 🔹 Verifica se "Pernoite" está presente, independentemente do formato exato
      expect(find.textContaining('Pernoite'), findsOneWidget);

      // Verifica os valores e descontos
      expect(find.text('R\$ 100.00'), findsOneWidget);
      expect(find.text('R\$ 80.00'), findsOneWidget);
      expect(find.text('R\$ 150.00'), findsOneWidget);
      expect(find.text('R\$ 200.00'), findsOneWidget);
      expect(find.text('R\$ 180.00'), findsOneWidget);
    });

    testWidgets('Abre o popup de reserva ao tocar em um período',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReserveListComponent(periods: testPeriods),
          ),
        ),
      );

      // Simula um toque no primeiro período ("2h")
      await tester.tap(find.text('2h'));
      await tester.pumpAndSettle();

      // 🔹 Verifica se o popup de reserva foi aberto
      expect(find.byType(Dialog), findsOneWidget);

      // Fecha o popup
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.byType(Dialog), findsNothing);
    });

    testWidgets('Abre o popup ao clicar no botão de seta',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReserveListComponent(periods: testPeriods),
          ),
        ),
      );

      // 🔹 Toca apenas no primeiro botão de seta "→"
      await tester.tap(find.byIcon(Icons.arrow_forward).first);
      await tester.pumpAndSettle();

      // 🔹 Verifica se o popup foi aberto
      expect(find.byType(Dialog), findsOneWidget);

      // Fecha o popup
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.byType(Dialog), findsNothing);
    });
  });
}
