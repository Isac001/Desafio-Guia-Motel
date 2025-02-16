import 'package:desafio_guia_motel/components/fields_components/popup_itens_suite_component.dart';
import 'package:desafio_guia_motel/constants/fontsize_constants.dart';
import 'package:desafio_guia_motel/constants/padding_constants.dart';
import 'package:desafio_guia_motel/constants/radius_constants.dart';
import 'package:desafio_guia_motel/constants/theme_color.dart';
import 'package:flutter/material.dart';

// A stateless widget that displays a bar with item icons and a "View All" button if necessary
class BarItensComponent extends StatelessWidget {
  // List of items containing icons and names
  final List<Map<String, String>> items;
  
  // Icon size for each item
  final double iconSize;
  
  // Suite name displayed in the popup
  final String suiteName;

  // Constructor requiring items and suite name, with a default icon size
  const BarItensComponent({
    super.key,
    required this.items,
    required this.suiteName,
    this.iconSize = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    // Maximum number of visible items in the bar
    final maxVisibleItems = 3;

    // Determines if there are more items than the visible limit
    final bool hasMoreItems = items.length > maxVisibleItems;

    // If there are more items, show only two and add a "View All" button
    final itemsToShow = hasMoreItems
        ? [
            ...items.take(2),
            {'icone': 'ver_todos', 'nome': 'Ver todos'}
          ]
        : items.take(maxVisibleItems).toList();

    return Container(
      // Padding for the container based on screen size
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.02,
        horizontal: MediaQuery.of(context).size.height * 0.02,
      ),
      // Styling for the container with a white background and rounded corners
      decoration: BoxDecoration(
        color: ThemeColor.whiteColor,
        borderRadius: BorderRadius.circular(kRadiusStandard),
      ),
      // Displaying the items in a row
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: itemsToShow.map((item) {
          // Check if the item is the "View All" button
          final isMoreButton = item['icone'] == 'ver_todos';

          return isMoreButton
              ? GestureDetector(
                  // Show the popup when tapping the "View All" button
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return PopupItensComponent(
                          suiteName: suiteName,
                          items: items,
                        );
                      },
                    );
                  },
                  // Displaying the "More" icon for the button
                  child: Icon(
                    Icons.more_horiz,
                    color: ThemeColor.greyColor,
                    size: iconSize + kPaddingSmall,
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Displaying the item's icon
                    SizedBox(
                      height: iconSize,
                      width: iconSize,
                      child: Image.network(
                        item['icone'] ?? '',
                        // Show a default icon if the image fails to load
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.device_unknown,
                          size: kFontsizeLarge,
                          color: ThemeColor.greyColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: kPaddingSmall),
                  ],
                );
        }).toList(),
      ),
    );
  }
}
