import 'package:flutter/material.dart';
import 'package:desafio_guia_motel/components/widget_components/text_component.dart';
import 'package:desafio_guia_motel/constants/fontsize_constants.dart';
import 'package:desafio_guia_motel/constants/padding_constants.dart';
import 'package:desafio_guia_motel/constants/radius_constants.dart';
import 'package:desafio_guia_motel/constants/theme_color.dart';

/// A stateless widget representing a reservation popup.
class ReservationPopup extends StatelessWidget {
  /// Holds reservation period details.
  final Map<String, dynamic> period;

  /// Constructor for ReservationPopup.
  const ReservationPopup({super.key, required this.period});

  @override
  Widget build(BuildContext context) {
    /// Extract values from the period map.
    double valorSuite = period['valor'] ?? 0.0;
    double totalReserva = period['valorTotal'] ?? 0.0;
    double desconto = period['desconto'] is Map
        ? (period['desconto']['desconto'] ?? 0.0)
        : (period['desconto'] ?? 0.0);

    /// Calculate the amount to be paid initially (10% of total).
    double valorEntrada = totalReserva * 0.1;

    /// Calculate the remaining amount to be paid at the motel.
    double valorRestante = totalReserva - valorEntrada;

    /// Main dialog structure.
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: ThemeColor.whiteColor,
          borderRadius: BorderRadius.circular(kRadiusMedium),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kPaddingLarge),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Close button at the top-right corner.
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      size: kFontsizeXXLarge * 0.6,
                      color: ThemeColor.greyColor,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                /// Display the reservation period header.
                _buildHeader(period['tempoFormatado'] ?? ''),
                const SizedBox(height: kPaddingLarge),

                /// Display payment details.
                _buildPaymentDetails(valorSuite, totalReserva, desconto),
                const SizedBox(height: kPaddingLarge),

                /// Show payment steps.
                _buildPaymentSteps(valorEntrada, valorRestante),
                const SizedBox(height: kPaddingMedium),

                /// Reservation button.
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Reserva realizada com sucesso!"),
                          backgroundColor: ThemeColor.greenColor,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColor.redColor,
                      padding: const EdgeInsets.symmetric(vertical: kPaddingSM),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kRadiusMedium),
                      ),
                    ),
                    child: const TextComponent(
                      data: "Reservar agora",
                      fontSize: kFontsizeStandard,
                      color: ThemeColor.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the header section displaying the reservation period.
  Widget _buildHeader(String periodo) {
    return Column(
      children: [
        TextComponent(
          data: "Início do período",
          fontSize: kFontsizeStandard,
          color: ThemeColor.secundaryColor,
        ),
        const SizedBox(height: kPaddingMedium * 0.4),
        TextComponent(
          data: "IMEDIATO",
          fontSize: kFontsizeLarge,
          fontWeight: FontWeight.bold,
          color: ThemeColor.secundaryColor,
        ),
        const SizedBox(height: kPaddingMedium * 0.5),
        Icon(Icons.arrow_downward,
            color: ThemeColor.secundaryColor, size: kFontsizeXLarge),
        const SizedBox(height: kPaddingMedium * 0.5),
        TextComponent(
          data: "Período",
          fontSize: kFontsizeStandard,
          color: ThemeColor.secundaryColor,
        ),
        const SizedBox(height: kPaddingMedium * 0.4),
        TextComponent(
          data: periodo,
          fontSize: kFontsizeLarge,
          fontWeight: FontWeight.bold,
          color: ThemeColor.secundaryColor,
        ),
      ],
    );
  }

  /// Builds the container displaying price details.
  Widget _buildPaymentDetails(double suite, double total, double desconto) {
    return Container(
      padding: const EdgeInsets.all(kPaddingMedium),
      decoration: BoxDecoration(
        color: ThemeColor.whiteColor,
        borderRadius: BorderRadius.circular(kRadiusSmall),
        border: Border.all(color: ThemeColor.greyColor),
      ),
      child: Column(
        children: [
          _buildPriceRow("Valor da suíte", suite),
          if (desconto > 0)
            _buildPriceRow("Desconto", -desconto, color: ThemeColor.greenColor),
          _buildPriceRow("Valor total", total,
              isBold: true, color: ThemeColor.greenColor),
        ],
      ),
    );
  }

  /// Builds the container displaying payment steps.
  Widget _buildPaymentSteps(double entrada, double restante) {
    return Container(
      padding: const EdgeInsets.all(kPaddingMedium),
      decoration: BoxDecoration(
        color: ThemeColor.whiteColor,
        borderRadius: BorderRadius.circular(kRadiusSmall),
        border: Border.all(color: ThemeColor.greyColor),
      ),
      child: Column(
        children: [
          _buildPaymentStep(1, "Pague agora para reservar (10%)", entrada),
          Divider(color: ThemeColor.greyColor, thickness: kPaddingMedium * 0.1),
          _buildPaymentStep(2, "Pague o restante no motel", restante),
        ],
      ),
    );
  }

  /// Builds a row displaying a price with its label.
  Widget _buildPriceRow(String label, double value,
      {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kPaddingSM - 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextComponent(
            data: label,
            fontSize: kFontsizeMedium,
            color: ThemeColor.greyColor,
          ),
          TextComponent(
            data: "R\$ ${value.toStringAsFixed(2)}",
            fontSize: kFontsizeMedium,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: color ?? ThemeColor.secundaryColor,
          ),
        ],
      ),
    );
  }

  /// Builds a payment step displaying a number, label, and value.
  Widget _buildPaymentStep(int step, String label, double value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: kPaddingStandard,
          backgroundColor: ThemeColor.greyColor,
          child: TextComponent(
            data: "$step",
            fontSize: kFontsizeStandard,
            color: ThemeColor.whiteColor,
          ),
        ),
        const SizedBox(width: kPaddingSmall),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextComponent(
                data: label,
                fontSize: kFontsizeMedium,
                color: ThemeColor.greyColor,
                maxLines: 2,
                overflow: TextOverflow.visible,
              ),
              const SizedBox(height: kPaddingMedium * 0.4),
              TextComponent(
                data: "R\$ ${value.toStringAsFixed(2)}",
                fontSize: kFontsizeMedium,
                fontWeight: FontWeight.bold,
                color: ThemeColor.secundaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
