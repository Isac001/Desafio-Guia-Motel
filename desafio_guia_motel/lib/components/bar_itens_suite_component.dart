import 'package:flutter/material.dart';

class ExpandableIconsRow extends StatelessWidget {
  final List<Map<String, String>> items; // Lista com ícones e nomes
  final double iconSize; // Tamanho dos ícones
  final EdgeInsetsGeometry padding; // Padding para a linha

  const ExpandableIconsRow({
    Key? key,
    required this.items,
    this.iconSize = 30.0,
    this.padding = const EdgeInsets.all(8.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mostra até 3 ícones na linha principal
    final itemsToShow = items.take(3).toList();

    return Padding(
      padding: padding,
      child: Row(
        children: [
          // Ícones visíveis na linha
          ...itemsToShow.map((item) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: SizedBox(
                  height: iconSize,
                  width: iconSize,
                  child: Image.network(
                    item['icone'] ?? '',
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.device_unknown,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )),
          // Botão de expandir, visível apenas se houver mais de 3 itens
          if (items.length > 3)
            GestureDetector(
              onTap: () => _showAllIconsPopup(context),
              child: Container(
                height: iconSize,
                width: iconSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade300,
                ),
                child: Icon(
                  Icons.more_horiz,
                  size: iconSize * 0.6,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Exibe o popup centralizado ocupando espaço adaptável ao número de itens
  void _showAllIconsPopup(BuildContext context) {
    final itemHeight = 60.0; // Altura de cada item (ajustável)
    final maxPopupHeight = MediaQuery.of(context).size.height * 0.8;
    final calculatedHeight =
        (items.length * itemHeight) + 120; // Altura calculada

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width * 0.9,
            height: calculatedHeight > maxPopupHeight
                ? maxPopupHeight // Limita a altura máxima
                : calculatedHeight, // Adapta a altura
            child: Column(
              children: [
                const Text(
                  "Todos os itens",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
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
                            const SizedBox(width: 12),
                            Text(
                              item['nome'] ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Fecha o popup
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Fechar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
