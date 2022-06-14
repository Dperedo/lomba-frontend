import 'package:flutter/material.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:front_lomba/services/permission_service.dart';

class LombaDialogNotYes extends StatefulWidget {
  const LombaDialogNotYes(
      {Key? key,
      required this.itemName,
      required this.titleMessage,
      required this.dialogMessage,
      required this.name,
      required this.habilitado,})
      : super(key: key);
/*
      const LombaDialogNotYes.permission(
      {Key? key,
      required this.itemName,
      required this.titleMessage,
      required this.dialogMessage,
      required this.name,
      required this.habilitado,}):super(key:key);
*/
  final String itemName;
  final String titleMessage;
  final String dialogMessage;
  final String name;
  final bool habilitado;

  @override
  State<LombaDialogNotYes> createState() => _LombaDialogNotYesState(
      itemName: this.itemName,
      titleMessage: this.titleMessage,
      dialogMessage: this.dialogMessage,
      name: this.name,
      habilitado: habilitado);
}

class _LombaDialogNotYesState extends State<LombaDialogNotYes> {
  final String itemName;
  final String titleMessage;
  final String dialogMessage;
  final String name;
  final bool habilitado;

  _LombaDialogNotYesState(
      {required this.itemName,
      required this.titleMessage,
      required this.dialogMessage,
      required this.name,
      required this.habilitado})
      : super();

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
                  onPressed: () async {
                    if(this.dialogMessage == '¿Desea desactivar el permiso?'){
                      final permiService = Provider.of<PermissionsService>(context, listen: false);
                      final bool resp = await permiService.EnableDisable(this.name,this.habilitado);
                    }
                    Navigator.pop(context, 'Sí');
                    },
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
