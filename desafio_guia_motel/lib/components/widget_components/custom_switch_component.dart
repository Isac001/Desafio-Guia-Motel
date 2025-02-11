import 'package:desafio_guia_motel/components/widget_components/text_component.dart';
import 'package:desafio_guia_motel/constants/fontsize_constants.dart';
import 'package:desafio_guia_motel/constants/padding_constants.dart';
import 'package:flutter/material.dart';

class CustomSwitchComponent extends StatefulWidget {
  const CustomSwitchComponent({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomSwitchComponentState createState() => _CustomSwitchComponentState();
}

class _CustomSwitchComponentState extends State<CustomSwitchComponent> {
  bool isNow = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kPaddingXXLarge - kPaddingSmall, // Ajuste de altura
      width: 260, // Comprimento ajustado
      decoration: BoxDecoration(
        color: Colors.white, // Fundo branco
        borderRadius:
            BorderRadius.circular(kPaddingLarge), // Bordas arredondadas
        border: Border.all(
          color: Colors.red.shade700, // Cor da borda
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Botão "Ir Agora"
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isNow = true;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isNow ? Colors.red.shade700 : Colors.transparent,
                  borderRadius: BorderRadius.circular(kPaddingLarge),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: kPaddingSmall),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.flash_on,
                      color: isNow ? Colors.white : Colors.red.shade700,
                      size: kFontsizeStandard, // Ajuste do tamanho do ícone
                    ),
                    const SizedBox(width: kPaddingSmall),
                    TextComponent(
                      data: "ir agora",
                      fontSize: kFontsizeStandard,
                      fontWeight: FontWeight.bold,
                      color: isNow ? Colors.white : Colors.red.shade700,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Botão "Ir Outro Dia"
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isNow = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: !isNow ? Colors.red.shade700 : Colors.transparent,
                  borderRadius: BorderRadius.circular(kPaddingLarge),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: kPaddingSmall),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: !isNow ? Colors.white : Colors.red.shade700,
                      size: kFontsizeStandard, // Ajuste do tamanho do ícone
                    ),
                    const SizedBox(width: kPaddingSmall),
                    TextComponent(
                      data: "ir outro dia",
                      fontSize: kFontsizeStandard,
                      fontWeight: FontWeight.bold,
                      color: !isNow ? Colors.white : Colors.red.shade700,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
