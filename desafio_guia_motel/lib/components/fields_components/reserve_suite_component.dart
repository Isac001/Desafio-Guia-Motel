import 'package:desafio_guia_motel/components/fields_components/reserve_popup_component.dart';
import 'package:desafio_guia_motel/constants/radius_constants.dart';
import 'package:desafio_guia_motel/constants/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:desafio_guia_motel/components/widget_components/text_component.dart';
import 'package:desafio_guia_motel/constants/fontsize_constants.dart';
import 'package:desafio_guia_motel/constants/padding_constants.dart';

/// A stateless widget that displays a list of reservation periods.
/// Each period is shown as a card that can be tapped to open a reservation popup.
class ReserveListComponent extends StatelessWidget {
  // List of reservation periods with details
  final List<Map<String, dynamic>> periods;

  // Constructor requiring a list of periods
  const ReserveListComponent({super.key, required this.periods});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: periods.asMap().entries.map((entry) {
        // Extracting the period data
        final period = entry.value;
        final String tempo = period['tempoFormatado'] ?? '';

        return Padding(
          // Adds spacing between period cards
          padding: const EdgeInsets.only(bottom: kPaddingSmall - 4),
          child: GestureDetector(
            // Opens the reservation popup when tapped
            onTap: () => _showReservationPopup(context, period),
            child: IntrinsicHeight(
              // Ensures consistent height for all period cards
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01,
                  horizontal: MediaQuery.of(context).size.height * 0.02,
                ),
                decoration: BoxDecoration(
                  // White background with rounded corners
                  color: ThemeColor.whiteColor,
                  borderRadius: BorderRadius.circular(kRadiusStandard),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Expands to take available width
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // Prevents unnecessary expansion
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Displays formatted time for the reservation
                          Row(
                            children: [
                              TextComponent(
                                maxLines: 5,
                                data: tempo,
                                fontSize: kFontsizeLarge,
                                fontWeight: FontWeight.bold,
                                color: ThemeColor.secundaryColor,
                              ),
                              if (tempo.contains("12 horas"))
                                TextComponent(
                                  data: " (Pernoite)",
                                  fontSize: kFontsizeLarge,
                                  fontWeight: FontWeight.bold,
                                  color: ThemeColor.secundaryColor,
                                ),
                            ],
                          ),
                          const SizedBox(height: kPaddingSmall),
                          // Displays reservation price and discount if available
                          Row(
                            children: [
                              // Shows discounted price if there's a discount
                              if (period['desconto'] != null)
                                TextComponent(
                                  data: "R\$ ${period['valorTotal']?.toStringAsFixed(2)}",
                                  fontSize: kFontsizeMedium,
                                  maxLines: 5,
                                  color: ThemeColor.greenColor,
                                ),
                              if (period['desconto'] != null)
                                const SizedBox(width: kPaddingSmall),
                              TextComponent(
                                data: "R\$ ${period['valor']?.toStringAsFixed(2)}",
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
                    // Forward arrow button to open reservation popup
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
          ),
        );
      }).toList(),
    );
  }

  /// Displays a reservation popup when a period is selected
  void _showReservationPopup(BuildContext context, Map<String, dynamic> period) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReservationPopup(period: period);
      },
    );
  }
}
