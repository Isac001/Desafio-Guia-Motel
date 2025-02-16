// Importing necessary packages and components
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desafio_guia_motel/components/fields_components/reserve_suite_component.dart';

void main() {
  // Grouping tests related to the ReservationListComponent
  group('ReservationListComponent', () {
    // Variable to store test periods
    late List<Map<String, dynamic>> testPeriods;

    // Setup function to initialize test data before each test
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

    // Test to check if periods and values are displayed correctly
    testWidgets('Renders periods and values correctly',
        (WidgetTester tester) async {
      // Pumping the widget into the test environment
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReserveListComponent(periods: testPeriods),
          ),
        ),
      );

      // Checking if the period texts are displayed on screen
      expect(find.text('2h'), findsOneWidget);
      expect(find.text('4h'), findsOneWidget);
      expect(find.text('12 horas'), findsOneWidget);

      // 🔹 Checking if "Pernoite" is present, regardless of exact format
      expect(find.textContaining('Pernoite'), findsOneWidget);

      // Checking if financial values and discounts are displayed correctly
      expect(find.text('R\$ 100.00'), findsOneWidget);
      expect(find.text('R\$ 80.00'), findsOneWidget);
      expect(find.text('R\$ 150.00'), findsOneWidget);
      expect(find.text('R\$ 200.00'), findsOneWidget);
      expect(find.text('R\$ 180.00'), findsOneWidget);
    });

    // Test to check if the reservation popup opens when tapping on a period
    testWidgets('Opens reservation popup when tapping a period',
        (WidgetTester tester) async {
      // Pumping the widget into the test environment
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReserveListComponent(periods: testPeriods),
          ),
        ),
      );

      // Simulating a tap on the first period ("2h")
      await tester.tap(find.text('2h'));
      await tester.pumpAndSettle();

      // Checking if the reservation popup opens
      expect(find.byType(Dialog), findsOneWidget);

      // Closing the popup
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      // Expectation: The popup should be closed
      expect(find.byType(Dialog), findsNothing);
    });

    // Test to check if the popup opens when clicking the arrow button
    testWidgets('Opens popup when clicking the arrow button',
        (WidgetTester tester) async {
      // Pumping the widget into the test environment
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReserveListComponent(periods: testPeriods),
          ),
        ),
      );

      // Simulating a tap on the first arrow button "→"
      await tester.tap(find.byIcon(Icons.arrow_forward).first);
      await tester.pumpAndSettle();

      // Checking if the popup opens
      expect(find.byType(Dialog), findsOneWidget);

      // Closing the popup
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      // xpectation: The popup should be closed
      expect(find.byType(Dialog), findsNothing);
    });
  });
}
