// Importing necessary packages and components
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desafio_guia_motel/components/fields_components/reserve_popup_component.dart';

void main() {
  // Grouping tests related to the ReservationPopup component
  group('ReservationPopup', () {
    // Variable to store test period details
    late Map<String, dynamic> testPeriod;

    // Setup function to initialize test period before each test
    setUp(() {
      testPeriod = {
        'tempoFormatado': '12 horas',
        'valor': 200.0,
        'valorTotal': 180.0,
        'desconto': 20.0,
      };
    });

    // Test to verify that the reservation popup displays correct information
    testWidgets('Renders reservation details correctly',
        (WidgetTester tester) async {
      // Pumping the widget into the test environment
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReservationPopup(period: testPeriod),
          ),
        ),
      );

      // 🔹 Debugging: Prints all text widgets in case of failure
      final allTexts = find.byType(Text);
      final textWidgets = tester.widgetList<Text>(allTexts);
      for (final text in textWidgets) {
        debugPrint("Found text: ${text.data}");
      }

      // 🔹 Checking if the period information is displayed correctly
      expect(find.text('Início do período'), findsOneWidget);
      expect(find.text('IMEDIATO'), findsOneWidget);
      expect(find.text('Período'), findsOneWidget);
      expect(find.text('12 horas'), findsOneWidget);

      // 🔹 Checking if financial values are displayed correctly
      expect(find.text('R\$ 200.00'), findsOneWidget);
      expect(find.text('R\$ 180.00'), findsOneWidget);

      // 🔹 Checking if the discount is displayed correctly
      expect(
        find.byWidgetPredicate((widget) =>
            widget is Text &&
            widget.data != null &&
            widget.data!.contains("R\$ 20")),
        findsOneWidget,
      );

      // 🔹 Checking if payment instructions are displayed correctly
      expect(find.textContaining('Pague agora para reservar'), findsOneWidget);
      expect(find.textContaining('Pague o restante no motel'), findsOneWidget);
    });

    // Test to verify that the popup closes when clicking the close button
    testWidgets('Closes popup when clicking the close button',
        (WidgetTester tester) async {
      // Pumping the widget into the test environment
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReservationPopup(period: testPeriod),
          ),
        ),
      );

      // 🔹 Simulating a tap on the close button
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      // 🔹 Expectation: The popup should no longer be present
      expect(find.byType(Dialog), findsNothing);
    });

    // Test to verify that the popup closes when clicking "Reservar agora" button
    testWidgets('Closes popup when clicking "Reservar agora"',
        (WidgetTester tester) async {
      // Pumping the widget into the test environment
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReservationPopup(period: testPeriod),
          ),
        ),
      );

      // Ensuring the "Reservar agora" button is visible before clicking
      final reservarButton = find.text('Reservar agora');
      await tester.ensureVisible(reservarButton);

      // Simulating a tap on the "Reservar agora" button
      await tester.tap(reservarButton);
      await tester.pumpAndSettle();

      // Expectation: The popup should no longer be present
      expect(find.byType(Dialog), findsNothing);
    });
  });
}
