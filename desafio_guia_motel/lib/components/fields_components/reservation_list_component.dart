import 'package:desafio_guia_motel/components/widget_components/text_component.dart';
import 'package:desafio_guia_motel/constants/fontsize_constants.dart';
import 'package:desafio_guia_motel/constants/padding_constants.dart';
import 'package:flutter/material.dart';

class ReservationListComponent extends StatelessWidget {
  final List<Map<String, dynamic>> periods;
  final void Function(int index) onReserveTap;

  const ReservationListComponent({
    super.key,
    required this.periods,
    required this.onReserveTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: periods.asMap().entries.map((entry) {
        final index = entry.key;
        final period = entry.value;

        return Padding(
          padding: const EdgeInsets.only(
              bottom: kPaddingSmall - 4), // Padding menor entre os cards
          child: GestureDetector(
            onTap: () => onReserveTap(index),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: kPaddingSM, // Aumenta o padding interno do card
                horizontal: kPaddingLarge, // Ajuste horizontal maior
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                    kPaddingMedium), // Bordas arredondadas maiores
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 0, // Borda mais visível
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Informações de tempo e preço
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título com tempo
                        TextComponent(
                          data: period['tempoFormatado'] ?? '',
                          fontSize: kFontsizeLarge, // Fonte maior
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        const SizedBox(height: kPaddingSmall),

                        // Preços
                        Row(
                          children: [
                            // Preço com desconto (verde)
                            if (period['desconto'] != null)
                              TextComponent(
                                data:
                                    "R\$ ${period['valorTotal']?.toStringAsFixed(2)}",
                                fontSize: kFontsizeMedium, // Tamanho ajustado
                                color: Colors.green,
                              ),
                            if (period['desconto'] != null)
                              const SizedBox(width: kPaddingSmall),

                            // Preço original (vermelho, riscado)
                            TextComponent(
                              data:
                                  "R\$ ${period['valor']?.toStringAsFixed(2)}",
                              fontSize: kFontsizeMedium, // Tamanho ajustado
                              color: period['desconto'] != null
                                  ? Colors.red
                                  : Colors.black,
                              textAlign: TextAlign.start,
                              // Linha vermelha no preço original
                              overflow: TextOverflow.ellipsis,
                              decoration: period['desconto'] != null
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              decorationColor: Colors.red, // Linha vermelha
                              decorationThickness: 2.0, // Espessura da linha
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Ícone de seta (maior)
                  IconButton(
                    onPressed: () => onReserveTap(index),
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.grey,
                      size: kFontsizeXLarge, // Tamanho maior do ícone
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
}
