import 'package:desafio_guia_motel/components/text_component.dart';
import 'package:desafio_guia_motel/constans/fontsize_constants.dart';
import 'package:desafio_guia_motel/constans/paddigns_constans.dart';
import 'package:flutter/material.dart';

class BarItensSuiteComponent extends StatelessWidget {
  final List<Map<String, String>> items;
  final double iconSize;

  const BarItensSuiteComponent({
    super.key,
    required this.items,
    this.iconSize = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    final maxVisibleItems = 3;
    final bool hasMoreItems = items.length > maxVisibleItems;

    final itemsToShow = hasMoreItems
        ? [
            ...items.take(2),
            {'icone': 'ver_todos', 'nome': 'Ver todos'}
          ]
        : items.take(maxVisibleItems).toList();

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: kPaddingSmall,
        horizontal: kPaddingMedium,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: itemsToShow.map((item) {
          final isMoreButton = item['icone'] == 'ver_todos';

          return isMoreButton
              ? GestureDetector(
                  onTap: () => _showAllIconsPopup(context),
                  child: Row(
                    children: [
                      Icon(
                        Icons.more_horiz,
                        color: Colors.grey,
                        size: iconSize + 8, // Tamanho ajustado
                      ),
                      const SizedBox(width: kPaddingSmall),
                      TextWidget(
                        data: "Ver todos",
                        fontSize: kFontsizeStandard,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: iconSize,
                      width: iconSize,
                      child: Image.network(
                        item['icone'] ?? '',
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.device_unknown,
                          size: 30,
                          color: Colors.grey,
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

  void _showAllIconsPopup(BuildContext context) {
    const double popupIconSize = 35.0;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final int rows = (items.length / 3).ceil();
              final double calculatedHeight = rows * (popupIconSize + 48) + 200;

              return Container(
                padding: const EdgeInsets.all(kPaddingMedium),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                constraints: BoxConstraints(
                  maxHeight: calculatedHeight.clamp(200, constraints.maxHeight),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: TextWidget(
                        data: "Itens disponíveis",
                        fontSize: kFontsizeLarge,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: kPaddingSmall),
                    const TextWidget(
                      data: "Todos os itens disponíveis",
                      fontSize: kFontsizeStandard,
                      color: Colors.grey,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: kPaddingMedium),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: kPaddingSmall,
                          mainAxisSpacing: kPaddingSmall,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: popupIconSize,
                                width: popupIconSize,
                                child: Image.network(
                                  item['icone'] ?? '',
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                    Icons.device_unknown,
                                    size: 30,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(height: kPaddingSmall),
                              TextWidget(
                                data: item['nome'] ?? '',
                                fontSize: kFontsizeStandard,
                                textAlign: TextAlign.center,
                                color: Colors.grey.shade800,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: kPaddingMedium),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const TextWidget(
                          data: "Fechar",
                          fontSize: kFontsizeStandard,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
