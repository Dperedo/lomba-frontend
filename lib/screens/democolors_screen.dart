import 'package:flutter/material.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import 'package:front_lomba/widgets/lomba_appbar.dart';
import 'package:front_lomba/widgets/lomba_sidemenu.dart';
import 'package:front_lomba/widgets/lomba_titlepage.dart';
import 'package:provider/provider.dart';

class DemoColors extends StatefulWidget {
  const DemoColors({Key? key}) : super(key: key);
  static const appTitle = 'Lomba';
  static const pageTitle = 'Permisos';

  @override
  State<DemoColors> createState() => _DemoColorsState();
}

class _DemoColorsState extends State<DemoColors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LombaAppBar(title: 'Demo Colores'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LombaTitlePage(
                title: "Demo de colores",
                subtitle: "Administración / Colores",
              ),
              const Divider(),
              TextButton(
                onPressed: () {},
                child: const Text('Demo de color'),
              ),
              const Divider(),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith(getBackgroundColor),
                    foregroundColor:
                        MaterialStateProperty.resolveWith(getTextColor)),
                child: const Text('No botón'),
              ),
              const Divider(),
              ElevatedButton(
                onPressed: () {},
                style: const ButtonStyle(),
                child: const Text('Hola sí'),
              )
            ],
          ),
        ),
      ),
      //backgroundColor: Styles.defaultGreengroundColor,
      drawer: const LombaSideMenu(),
    );
  }

  Color getBackgroundColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Provider.of<ThemeProvider>(context).currentTheme.indicatorColor;
    }
    return Provider.of<ThemeProvider>(context).currentTheme.primaryColor;
  }

  Color getTextColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Provider.of<ThemeProvider>(context)
          .currentTheme
          .secondaryHeaderColor;
    }
    return Provider.of<ThemeProvider>(context).currentTheme.backgroundColor;
  }
}
