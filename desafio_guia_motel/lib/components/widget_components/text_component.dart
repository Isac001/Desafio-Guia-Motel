import 'package:desafio_guia_motel/constants/fontsize_constants.dart';
import 'package:flutter/material.dart';

/// A reusable text component with customizable styles.
class TextComponent extends StatelessWidget {
  // The text content to be displayed
  final String data;

  // Font size of the text
  final double fontSize;

  // Font weight for text styling
  final FontWeight fontWeight;

  // Text color (optional)
  final Color? color;

  // Maximum number of lines before truncating text
  final int maxLines;

  // Defines how overflowing text should be handled
  final TextOverflow? overflow;

  // Alignment of text within its container
  final TextAlign? textAlign;

  // Custom font family (optional)
  final String? fontFamily;

  // Text decoration (e.g., underline, strikethrough)
  final TextDecoration? decoration;

  // Color of the text decoration (optional)
  final Color? decorationColor;

  // Thickness of the text decoration (optional)
  final double? decorationThickness;

  /// Constructor with default values for font styling and behavior
  const TextComponent({
    super.key,
    required this.data,
    this.maxLines = 1,
    this.color,
    this.fontSize = kFontsizeMedium,
    this.fontWeight = FontWeight.normal,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.start,
    this.fontFamily,
    this.decoration,
    this.decorationColor,
    this.decorationThickness,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      // The text content displayed
      data,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontFamily: fontFamily,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationThickness: decorationThickness,
        overflow: overflow, 
      ),
    );
  }
}
