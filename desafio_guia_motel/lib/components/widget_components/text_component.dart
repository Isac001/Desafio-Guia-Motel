import 'package:desafio_guia_motel/constants/fontsize_constants.dart';
import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  // Texto a ser exibido
  final String data;

  // Tamanho da fonte
  final double fontSize;

  // Peso da fonte
  final FontWeight fontWeight;

  // Cor do texto
  final Color? color;

  // Número máximo de linhas
  final int maxLines;

  // Overflow do texto
  final TextOverflow? overflow;

  // Alinhamento do texto
  final TextAlign? textAlign;

  // Nome da família da fonte
  final String? fontFamily;

  // Decoração (sublinhado, riscado, etc.)
  final TextDecoration? decoration;

  // Cor da decoração (linha riscada, sublinhada, etc.)
  final Color? decorationColor;

  // Espessura da decoração (linha riscada ou sublinhada)
  final double? decorationThickness;

  const TextComponent({
    super.key,
    required this.data,
    this.maxLines = 1,
    this.color,
    this.fontSize = kFontsizeMedium, // Agora usa a constante
    this.fontWeight = FontWeight.normal,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.start,
    this.fontFamily, // Novo parâmetro para definir a fonte
    this.decoration,
    this.decorationColor,
    this.decorationThickness,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      softWrap: true,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        overflow: overflow,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontFamily: fontFamily, // Define a fonte personalizada
        decoration: decoration,
        decorationColor: decorationColor,
        decorationThickness: decorationThickness,
      ),
    );
  }
}
