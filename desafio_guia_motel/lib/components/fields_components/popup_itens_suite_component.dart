import 'package:desafio_guia_motel/components/widget_components/text_component.dart';
import 'package:desafio_guia_motel/constants/fontsize_constants.dart';
import 'package:desafio_guia_motel/constants/padding_constants.dart';
import 'package:desafio_guia_motel/constants/radius_constants.dart';
import 'package:desafio_guia_motel/constants/theme_color.dart';
import 'package:flutter/material.dart';

// A stateless widget that displays a popup with suite details and item list
class PopupItensComponent extends StatelessWidget {
  // Suite name displayed at the top
  final String suiteName;

  // List of items containing icons and names
  final List<Map<String, String>> items;

  // Constructor requiring suite name and items list
  const PopupItensComponent({
    super.key,
    required this.suiteName,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // Sets the background color of the popup
      backgroundColor: ThemeColor.whiteColor,
      // Defines the popup's rounded shape
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadiusMedium),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          // Limits the popup height to 70% of the screen
          maxHeight: MediaQuery.of(context).size.height * 0.7,
          // Sets a minimum width of 80% of the screen
          minWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Padding(
          padding: const EdgeInsets.all(kPaddingMedium),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Suite name displayed in uppercase with custom styling
                TextComponent(
                  data: suiteName.toUpperCase(),
                  fontSize: kFontsizeLarge,
                  maxLines: 4,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  color: ThemeColor.secundaryColor,
                ),

                const SizedBox(height: kPaddingMedium),

                // "Main Items" section with a title and dividers
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                        child:
                            Divider(thickness: 1, color: ThemeColor.greyColor)),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: kPaddingSmall),
                      child: TextComponent(
                        data: "principais itens".toUpperCase(),
                        fontSize: kFontsizeMedium,
                        fontWeight: FontWeight.bold,
                        maxLines: 4,
                        color: ThemeColor.secundaryColor,
                      ),
                    ),
                    const Expanded(
                        child:
                            Divider(thickness: 1, color: ThemeColor.greyColor)),
                  ],
                ),

                const SizedBox(height: kPaddingMedium),

                // Displays up to 3 main items in a column
                Column(
                  children: items.take(3).map((item) {
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: kPaddingSmall),
                      child: Row(
                        children: [
                          // Displays item icon with a fallback icon in case of an error
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Image.network(
                              item['icone'] ?? '',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                Icons.device_unknown,
                                size: kFontsizeMedium,
                                color: ThemeColor.greyColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: kPaddingSmall),
                          // Displays item name with limited lines
                          Expanded(
                            child: TextComponent(
                              data: item['nome'] ?? '',
                              fontSize: kFontsizeStandard,
                              maxLines: 2,
                              color: ThemeColor.greyColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: kPaddingMedium),

                // "Also Available" section with a title and dividers
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                        child:
                            Divider(thickness: 1, color: ThemeColor.greyColor)),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: kPaddingSmall),
                      child: TextComponent(
                        data: "tem também".toUpperCase(),
                        fontSize: kFontsizeMedium,
                        maxLines: 4,
                        fontWeight: FontWeight.bold,
                        color: ThemeColor.secundaryColor,
                      ),
                    ),
                    const Expanded(
                        child:
                            Divider(thickness: 1, color: ThemeColor.greyColor)),
                  ],
                ),

                const SizedBox(height: kPaddingMedium),

                // Displays remaining items in a single line, separated by commas
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kPaddingSmall),
                  child: TextComponent(
                    data: items.skip(3).map((item) => item['nome']).join(', '),
                    fontSize: kFontsizeStandard,
                    color: ThemeColor.greyColor,
                    maxLines: 7,
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: kPaddingLarge),

                // "Close" button to dismiss the popup
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColor.redColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kRadiusSmall),
                      ),
                    ),
                    child: TextComponent(
                      data: "Fechar",
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
}
