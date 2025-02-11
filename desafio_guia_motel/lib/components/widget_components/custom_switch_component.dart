import 'package:desafio_guia_motel/components/widget_components/text_component.dart';
import 'package:desafio_guia_motel/constants/fontsize_constants.dart';
import 'package:desafio_guia_motel/constants/padding_constants.dart';
import 'package:desafio_guia_motel/constants/radius_constants.dart';
import 'package:desafio_guia_motel/constants/theme_color.dart';
import 'package:flutter/material.dart';

/// A custom switch component that allows the user to toggle between two options.
class CustomSwitchComponent extends StatefulWidget {
  /// Constructor for the CustomSwitchComponent.
  const CustomSwitchComponent({super.key});

  /// Creates the state for the switch component.
  @override
  CustomSwitchComponentState createState() => CustomSwitchComponentState();
}

/// State class for CustomSwitchComponent.
class CustomSwitchComponentState extends State<CustomSwitchComponent> {
  /// Boolean to track the selected state.
  /// `true` means "Go Now" is selected, `false` means "Go Another Day" is selected.
  bool isNow = true;

  /// Fixed width for the switch component.
  final double switchWidth = 260;

  @override
  Widget build(BuildContext context) {
    /// Main container that wraps the switch component.
    return Container(
      height: kPaddingXXLarge - kPaddingSmall,
      width: switchWidth,
      decoration: BoxDecoration(
        color: ThemeColor.whiteColor,
        borderRadius: BorderRadius.circular(kRadiusLarge),
        border: Border.all(
          color: ThemeColor.primaryColor,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// "Go Now" Button - When selected, changes the color and updates the state.
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isNow = true;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isNow ? ThemeColor.redColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(kRadiusLarge),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: kPaddingSmall),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Flash icon for "Go Now" button
                    Icon(
                      Icons.flash_on,
                      color:
                          isNow ? ThemeColor.whiteColor : ThemeColor.redColor,
                      size: kFontsizeStandard,
                    ),
                    const SizedBox(width: kPaddingSmall),

                    /// Text for "Go Now" button
                    TextComponent(
                      data: "ir agora",
                      fontSize: kFontsizeStandard,
                      fontWeight: FontWeight.bold,
                      color:
                          isNow ? ThemeColor.whiteColor : ThemeColor.redColor,
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// "Go Another Day" Button - When selected, changes the color and updates the state.
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isNow = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: !isNow ? ThemeColor.redColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(kRadiusLarge),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: kPaddingSmall),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Calendar icon for "Go Another Day" button
                    Icon(
                      Icons.calendar_today,
                      color:
                          !isNow ? ThemeColor.whiteColor : ThemeColor.redColor,
                      size: kFontsizeStandard,
                    ),
                    const SizedBox(width: kPaddingSmall),

                    /// Text for "Go Another Day" button
                    TextComponent(
                      data: "ir outro dia",
                      fontSize: kFontsizeStandard,
                      fontWeight: FontWeight.bold,
                      color:
                          !isNow ? ThemeColor.whiteColor : ThemeColor.redColor,
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
