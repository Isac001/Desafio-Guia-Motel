import 'package:desafio_guia_motel/components/widget_components/text_component.dart';
import 'package:desafio_guia_motel/constants/fontsize_constants.dart';
import 'package:desafio_guia_motel/constants/padding_constants.dart';
import 'package:flutter/material.dart';

class BarItensSuiteComponent extends StatelessWidget {
  final List<Map<String, String>> items;
  final double iconSize;
  final String suiteName;

  const BarItensSuiteComponent({
    super.key,
    required this.items,
    required this.suiteName,
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
        borderRadius: BorderRadius.circular(kPaddingStandard),
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
                  onTap: () => _showPopup(context),
                  child: Icon(
                    Icons.more_horiz,
                    color: Colors.grey,
                    size: iconSize + kPaddingSmall,
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
                          size: kFontsizeLarge,
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

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kPaddingMedium),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height *
                  0.8, // Máximo 80% da tela
              minWidth:
                  MediaQuery.of(context).size.width * 0.6, // Largura mínima
            ),
            child: Padding(
              padding: const EdgeInsets.all(kPaddingMedium),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Título
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: kPaddingMedium),
                    child: Center(
                      child: TextComponent(
                        maxLines: 4,
                        textAlign: TextAlign.center,
                        data: "Itens disponíveis da $suiteName",
                        fontSize: kFontsizeLarge,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),

                  // Conteúdo com Scroll
                  Flexible(
                    child: SingleChildScrollView(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 itens por linha
                          crossAxisSpacing: kPaddingMedium,
                          mainAxisSpacing: kPaddingMedium,
                          childAspectRatio: 1, // Mantém proporção equilibrada
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 50.0,
                                width: 50.0,
                                child: Image.network(
                                  item['icone'] ?? '',
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                    Icons.device_unknown,
                                    size: kFontsizeLarge,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(height: kPaddingSmall),
                              TextComponent(
                                data: item['nome'] ?? '',
                                fontSize: kFontsizeStandard,
                                color: Colors.grey.shade800,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: kPaddingMedium),

                  // Botão Fechar
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kPaddingSmall),
                        ),
                      ),
                      child: const TextComponent(
                        data: "Fechar",
                        fontSize: kFontsizeStandard,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
