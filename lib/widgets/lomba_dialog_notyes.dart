import 'package:flutter/material.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:front_lomba/services/permission_service.dart';

class LombaDialogNotYes extends StatefulWidget {
  const LombaDialogNotYes({
    Key? key,
    required this.itemName,
    required this.titleMessage,
    required this.dialogMessage,
  }) : super(key: key);

  final String itemName;
  final String titleMessage;
  final String dialogMessage;

  @override
  State<LombaDialogNotYes> createState() => _LombaDialogNotYesState(
        itemName: itemName,
        titleMessage: titleMessage,
        dialogMessage: dialogMessage,
      );
}

class _LombaDialogNotYesState extends State<LombaDialogNotYes> {
  final String itemName;
  final String titleMessage;
  final String dialogMessage;

  _LombaDialogNotYesState({
    required this.itemName,
    required this.titleMessage,
    required this.dialogMessage,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Builder(
        builder: (context) => GestureDetector(
            onTap: () {},
            child: AlertDialog(
              title: Text(this.titleMessage),
              content: Text(this.dialogMessage),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, ''),
                  child: const Text('No'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith(getBackgroundColor),
                      foregroundColor:
                          MaterialStateProperty.resolveWith(getTextColor)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, 'Sí');
                  },
                  key: const Key("button_yes"),
                  child: const Text('Sí'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith(getBackgroundColor),
                      foregroundColor:
                          MaterialStateProperty.resolveWith(getTextColor)),
                ),
              ],
            )),
      ),
    );
  }

  final Set<MaterialState> _interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };

  Color getBackgroundColor(Set<MaterialState> states) {
    if (states.any(_interactiveStates.contains)) {
      return Provider.of<ThemeProvider>(context).currentTheme.indicatorColor;
    }
    return Provider.of<ThemeProvider>(context).currentTheme.primaryColor;
  }

  Color getTextColor(Set<MaterialState> states) {
    if (states.any(_interactiveStates.contains)) {
      return Provider.of<ThemeProvider>(context)
          .currentTheme
          .secondaryHeaderColor;
    }
    return Provider.of<ThemeProvider>(context).currentTheme.backgroundColor;
  }
}
