import 'package:desafio_guia_motel/components/fields_components/reserve_popup_component.dart';
import 'package:flutter/material.dart';
import 'package:desafio_guia_motel/components/widget_components/text_component.dart';
import 'package:desafio_guia_motel/constants/fontsize_constants.dart';
import 'package:desafio_guia_motel/constants/padding_constants.dart';

class ReservationListComponent extends StatelessWidget {
  final List<Map<String, dynamic>> periods;

  const ReservationListComponent({super.key, required this.periods});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: periods.asMap().entries.map((entry) {
        final period = entry.value;
        final String tempo = period['tempoFormatado'] ?? '';

        return Padding(
          padding: const EdgeInsets.only(bottom: kPaddingSmall - 4),
          child: GestureDetector(
            onTap: () => _showReservationPopup(context, period),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: kPaddingSM,
                horizontal: kPaddingLarge,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(kPaddingMedium),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 0,
                ),
              ),
              child: Row(
                children: [
                  // 🔹 Expanded para empurrar o botão para a direita
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            TextComponent(
                              maxLines: 5,
                              data: tempo,
                              fontSize: kFontsizeLarge,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            if (tempo.contains(
                                "12 horas")) // 🔹 Exibe "(Pernoite)" se for 12 horas
                              TextComponent(
                                data: " (Pernoite)",
                                fontSize: kFontsizeLarge,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                          ],
                        ),
                        const SizedBox(height: kPaddingSmall),
                        Row(
                          children: [
                            if (period['desconto'] != null)
                              TextComponent(
                                data:
                                    "R\$ ${period['valorTotal']?.toStringAsFixed(2)}",
                                fontSize: kFontsizeMedium,
                                maxLines: 5,
                                color: Colors.green,
                              ),
                            if (period['desconto'] != null)
                              const SizedBox(width: kPaddingSmall),
                            TextComponent(
                              data:
                                  "R\$ ${period['valor']?.toStringAsFixed(2)}",
                              fontSize: kFontsizeMedium,
                              maxLines: 5,
                              color: period['desconto'] != null
                                  ? Colors.red
                                  : Colors.black,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              decoration: period['desconto'] != null
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              decorationColor: Colors.red,
                              decorationThickness: 2.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // 🔹 O botão agora sempre fica alinhado à direita
                  IconButton(
                    onPressed: () => _showReservationPopup(context, period),
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.grey,
                      size: kFontsizeXLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  /// 🔹 Método para exibir o popup de reserva
  void _showReservationPopup(
      BuildContext context, Map<String, dynamic> period) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReservationPopup(period: period); // Usa o popup corretamente
      },
    );
  }
}
