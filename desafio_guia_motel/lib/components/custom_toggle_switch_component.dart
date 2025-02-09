import 'package:desafio_guia_motel/components/text_component.dart';
import 'package:desafio_guia_motel/constans/fontsize_constants.dart';
import 'package:desafio_guia_motel/constans/paddigns_constans.dart';
import 'package:flutter/material.dart';

class CustomToggleSwitch extends StatefulWidget {
  const CustomToggleSwitch({super.key});

  @override
  _CustomToggleSwitchState createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  bool isNow = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45, // Altura ajustada
      width: 260, // Comprimento ajustado
      decoration: BoxDecoration(
        color: Colors.white, // Fundo branco
        borderRadius: BorderRadius.circular(22), // Bordas arredondadas
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
                  borderRadius: BorderRadius.circular(22),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: kPaddingSmall),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.flash_on,
                      color: isNow ? Colors.white : Colors.red.shade700,
                      size: kFontsizeMedium, // Ajuste do tamanho do ícone
                    ),
                    const SizedBox(width: kPaddingSmall),
                    TextWidget(
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
                  borderRadius: BorderRadius.circular(22),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: kPaddingSmall),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: !isNow ? Colors.white : Colors.red.shade700,
                      size: kFontsizeMedium, // Ajuste do tamanho do ícone
                    ),
                    const SizedBox(width: kPaddingSmall),
                    TextWidget(
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
