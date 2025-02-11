import 'package:desafio_guia_motel/components/fields_components/reserve_popup_component.dart';
import 'package:desafio_guia_motel/constants/radius_constants.dart';
import 'package:desafio_guia_motel/constants/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:desafio_guia_motel/components/widget_components/text_component.dart';
import 'package:desafio_guia_motel/constants/fontsize_constants.dart';
import 'package:desafio_guia_motel/constants/padding_constants.dart';

/// A stateless widget that displays a list of reservation periods.
/// Each item can be tapped to open a reservation popup.
class ReserveListComponent extends StatelessWidget {
  /// List of reservation periods containing formatted time, price, and discounts.
  final List<Map<String, dynamic>> periods;

  /// Constructor for ReservationListComponent
  const ReserveListComponent({super.key, required this.periods});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: periods.asMap().entries.map((entry) {
        /// Extract the period data from the list.
        final period = entry.value;

        /// Get the formatted time of the reservation period.
        final String tempo = period['tempoFormatado'] ?? '';

        /// Wrap each reservation item in padding.
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
                color: ThemeColor.whiteColor,
                borderRadius: BorderRadius.circular(kRadiusMedium),
                border: Border.all(
                  color: ThemeColor.greyColor,
                  width: 0,
                ),
              ),
              child: Row(
                children: [
                  /// Expanded to ensure text takes available space.
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            /// Displays the reservation time.
                            TextComponent(
                              maxLines: 5,
                              data: tempo,
                              fontSize: kFontsizeLarge,
                              fontWeight: FontWeight.bold,
                              color: ThemeColor.secundaryColor,
                            ),

                            /// If the time is "12 horas", add "(Pernoite)".
                            if (tempo.contains("12 horas"))
                              TextComponent(
                                data: " (Pernoite)",
                                fontSize: kFontsizeLarge,
                                fontWeight: FontWeight.bold,
                                color: ThemeColor.secundaryColor,
                              ),
                          ],
                        ),

                        /// Adds space between elements.
                        const SizedBox(height: kPaddingSmall),

                        Row(
                          children: [
                            /// If a discount exists, show the discounted price.
                            if (period['desconto'] != null)
                              TextComponent(
                                data:
                                    "R\$ ${period['valorTotal']?.toStringAsFixed(2)}",
                                fontSize: kFontsizeMedium,
                                maxLines: 5,
                                color: ThemeColor.greenColor,
                              ),

                            /// Adds spacing between prices.
                            if (period['desconto'] != null)
                              const SizedBox(width: kPaddingSmall),

                            /// Displays the original price, strikethrough if discounted.
                            TextComponent(
                              data:
                                  "R\$ ${period['valor']?.toStringAsFixed(2)}",
                              fontSize: kFontsizeMedium,
                              maxLines: 5,
                              color: period['desconto'] != null
                                  ? ThemeColor.redColor
                                  : ThemeColor.secundaryColor,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              decoration: period['desconto'] != null
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              decorationColor: ThemeColor.redColor,
                              decorationThickness: 2.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// Button to open the reservation popup.
                  IconButton(
                    onPressed: () => _showReservationPopup(context, period),
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: ThemeColor.greyColor,
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

  /// Function to show the reservation popup when an item is tapped.
  void _showReservationPopup(
      BuildContext context, Map<String, dynamic> period) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReservationPopup(period: period);
      },
    );
  }
}
