/* import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desafio_guia_motel/components/fields_components/reservation_list_component.dart';

void main() {
  group('ReservationListComponent', () {
    late List<Map<String, dynamic>> testPeriods;
    late int tappedIndex;

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
        }
      ];

      tappedIndex = -1;
    });

    testWidgets('Renderiza corretamente os períodos', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReservationListComponent(
              periods: testPeriods,
              onReserveTap: (index) => tappedIndex = index,
            ),
          ),
        ),
      );

      expect(find.text('2h'), findsOneWidget);
      expect(find.text('4h'), findsOneWidget);
      expect(find.text('R\$ 100.00'), findsOneWidget);
      expect(find.text('R\$ 80.00'), findsOneWidget);
      expect(find.text('R\$ 150.00'), findsOneWidget);
    });

    testWidgets('Chama onReserveTap ao clicar em um item', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReservationListComponent(
              periods: testPeriods,
              onReserveTap: (index) => tappedIndex = index,
            ),
          ),
        ),
      );

      await tester.tap(find.text('2h'));
      await tester.pump();

      expect(tappedIndex, 0);

      await tester.tap(find.text('4h'));
      await tester.pump();

      expect(tappedIndex, 1);
    });
  });
}
*/
