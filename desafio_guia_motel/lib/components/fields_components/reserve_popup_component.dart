import 'package:flutter/material.dart';
import 'package:desafio_guia_motel/components/widget_components/text_component.dart';
import 'package:desafio_guia_motel/constants/fontsize_constants.dart';
import 'package:desafio_guia_motel/constants/padding_constants.dart';

class ReservationPopup extends StatelessWidget {
  final Map<String, dynamic> period;

  const ReservationPopup({super.key, required this.period});

  @override
  Widget build(BuildContext context) {
    double valorSuite = period['valor'] ?? 0.0;
    double totalReserva = period['valorTotal'] ?? 0.0;
    double desconto = period['desconto'] is Map
        ? (period['desconto']['desconto'] ?? 0.0)
        : (period['desconto'] ?? 0.0);

    double valorEntrada = totalReserva * 0.1;
    double valorRestante = totalReserva - valorEntrada;

    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kPaddingMedium),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kPaddingLarge),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close,
                        size: 28,
                        color: Colors.grey.shade700), // 🔹 Cinza uniforme
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                _buildHeader(period['tempoFormatado'] ?? ''),
                const SizedBox(height: kPaddingLarge),
                _buildPaymentDetails(valorSuite, totalReserva, desconto),
                const SizedBox(height: kPaddingLarge),
                _buildPaymentSteps(valorEntrada, valorRestante),
                const SizedBox(height: kPaddingMedium),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Reserva realizada com sucesso!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kPaddingMedium),
                      ),
                    ),
                    child: const TextComponent(
                      data: "Reservar agora",
                      fontSize: kFontsizeStandard,
                      color: Colors.white,
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

  Widget _buildHeader(String periodo) {
    return Column(
      children: [
        TextComponent(
            data: "Início do período",
            fontSize: kFontsizeStandard,
            color: Colors.black // 🔹 Cinza uniforme
            ),
        const SizedBox(height: 4),
        TextComponent(
          data: "IMEDIATO",
          fontSize: kFontsizeLarge,
          fontWeight: FontWeight.bold,
          color: Colors.black, // 🔹 Cinza uniforme
        ),
        const SizedBox(height: 8),
        Icon(Icons.arrow_downward,
            color: Colors.black, size: 24), // 🔹 Ícone cinza
        const SizedBox(height: 8),
        TextComponent(
          data: "Período",
          fontSize: kFontsizeStandard,
          color: Colors.black, // 🔹 Cinza uniforme
        ),
        const SizedBox(height: 4),
        TextComponent(
          data: periodo,
          fontSize: kFontsizeLarge,
          fontWeight: FontWeight.bold,
          color: Colors.black, // 🔹 Cinza uniforme
        ),
      ],
    );
  }

  Widget _buildPaymentDetails(double suite, double total, double desconto) {
    return Container(
      padding: const EdgeInsets.all(kPaddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kPaddingSmall),
        border: Border.all(color: Colors.grey.shade700), // 🔹 Cinza uniforme
      ),
      child: Column(
        children: [
          _buildPriceRow("Valor da suíte", suite),
          if (desconto > 0)
            _buildPriceRow("Desconto", -desconto, color: Colors.green),
          _buildPriceRow("Valor total", total,
              isBold: true, color: Colors.green),
        ],
      ),
    );
  }

  Widget _buildPaymentSteps(double entrada, double restante) {
    return Container(
      padding: const EdgeInsets.all(kPaddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kPaddingSmall),
        border: Border.all(color: Colors.grey.shade700), // 🔹 Cinza uniforme
      ),
      child: Column(
        children: [
          _buildPaymentStep(1, "Pague agora para reservar (10%)", entrada),
          Divider(color: Colors.grey.shade700, thickness: 1), // 🔹 Linha cinza
          _buildPaymentStep(2, "Pague o restante no motel", restante),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double value,
      {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextComponent(
            data: label,
            fontSize: kFontsizeMedium,
            color: Colors.grey.shade700, // 🔹 Cinza uniforme
          ),
          TextComponent(
            data: "R\$ ${value.toStringAsFixed(2)}",
            fontSize: kFontsizeMedium,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: color ?? Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentStep(int step, String label, double value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: Colors.grey.shade700, // 🔹 Fundo do círculo cinza
          child: TextComponent(
            data: "$step",
            fontSize: kFontsizeStandard,
            color: Colors.white, // 🔹 Número em branco para contraste
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
                color: Colors.grey.shade700, // 🔹 Cinza uniforme
                maxLines: 2,
                overflow: TextOverflow.visible,
              ),
              const SizedBox(height: 4),
              TextComponent(
                data: "R\$ ${value.toStringAsFixed(2)}",
                fontSize: kFontsizeMedium,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
