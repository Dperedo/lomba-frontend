import 'package:flutter/material.dart';
import 'package:lomba_frontend/presentation/design/widgets/sharmia_colors.dart';
import 'package:lomba_frontend/presentation/design/widgets/sharmia_icons.dart';
import 'package:lomba_frontend/presentation/design/widgets/sharmia_text_styles.dart';

class SharmiaSideMenuSelectTheme extends StatelessWidget {
  const SharmiaSideMenuSelectTheme({
    super.key,
    required this.primaryColor,
    required this.borderColor,
  });
  final Color primaryColor;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Acción a realizar al hacer clic en el botón
      },
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        shape: const CircleBorder(), // Forma circular
        backgroundColor: primaryColor, // Fondo blanco
        side: BorderSide(
          color: borderColor, // Borde verde
          width: 2.0, // Grosor del borde
        ),
      ),
      child: null,
    );
  }
}

class SharmiaSideMenuDropdown extends StatelessWidget {
  SharmiaSideMenuDropdown({
    super.key,
    required this.optionsDropdown,
    this.selectedOption,
  });
  final List<String> optionsDropdown;
  String? selectedOption;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      height: 39,
      decoration: BoxDecoration(
        color: SharmiaColors.sharmiaGreenLight,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: DropdownButton(
        value: selectedOption,
        items: optionsDropdown.map((String value) {
          return DropdownMenuItem(
            value: value,
            child: Container(
              padding:
                  const EdgeInsets.only(left: 6, top: 4, bottom: 4, right: 6),
              child: Text(
                value,
                style: SharmiaTextStyles.textButtonLabel(
                    SharmiaColors.sharmiaBlack),
              ),
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          if (newValue != selectedOption) {
            selectedOption = newValue as String?;
          }
        },
        icon: SharmiaIconDropdown(color: SharmiaColors.sharmiaBlack),
        borderRadius: BorderRadius.circular(20),
        dropdownColor: SharmiaColors.sharmiaGreenLight,
        style: SharmiaTextStyles.textButtonLabel(SharmiaColors.sharmiaBlack),
        underline: Container(),
      ),
    );
  }
}

class SharmiaSideMenuSubtitle extends StatelessWidget {
  const SharmiaSideMenuSubtitle({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      child: Text(
        text,
        style: SharmiaTextStyles.textSubtitle(SharmiaColors.sharmiaBlack),
      ),
    );
  }
}

class SharmiaSideMenuInputSearch extends StatelessWidget {
  const SharmiaSideMenuInputSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.bottom,
        style: SharmiaTextStyles.textPlaceholder(SharmiaColors.sharmiaBlack),
        decoration: InputDecoration(
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                width: 1,
                color: SharmiaColors.sharmiaBlack20,
                style: BorderStyle.solid,
              ),
            ),
            fillColor: SharmiaColors.sharmiaWhite,
            alignLabelWithHint: true,
            hintStyle: SharmiaTextStyles.textPlaceholderText(
                SharmiaColors.sharmiaBlack20),
            hintText: 'Buscar',
            suffixIcon: SharmiaIconSearch(color: SharmiaColors.sharmiaBlack20),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                width: 1,
                color: SharmiaColors.sharmiaBlack20,
                style: BorderStyle.solid,
              ),
            )),
      ),
    );
  }
}

class SharmiaSideMenuLargeLogo extends StatelessWidget {
  const SharmiaSideMenuLargeLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0),
      child: Image.asset('assets/sharmia2.png'),
    );
  }
}

class SharmiaSideMenuButton extends StatelessWidget {
  const SharmiaSideMenuButton({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 6, top: 4, bottom: 4, left: 6),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(78, 40),
          shadowColor: Colors.transparent,
          backgroundColor: SharmiaColors.sharmiaGreenLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: SharmiaTextStyles.textButtonLabel(SharmiaColors.sharmiaBlack),
        ),
      ),
    );
  }
}
