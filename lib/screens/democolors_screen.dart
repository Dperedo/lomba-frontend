import 'package:flutter/material.dart';
import 'package:front_lomba/model/models.dart';
import 'package:front_lomba/model/preferences.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import 'package:front_lomba/widgets/lomba_sidemenu.dart';
import 'package:provider/provider.dart';

class DemoColors extends StatefulWidget {
  const DemoColors({Key? key}) : super(key: key);
  static const appTitle = 'Lomba';
  @override
  State<DemoColors> createState() => _DemoColorsState();
}

class _DemoColorsState extends State<DemoColors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lomba'), actions: [
        IconButton(
          icon: const Icon(Icons.account_circle_rounded),
          tooltip: 'Perfil',
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Profile()));
          },
        )
      ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleSection(
                title: "Demo de colores",
                subtitle: "Administración / Colores",
              ),
              const Divider(),
              TextButton(
                onPressed: () {},
                child: Text('Demo de color'),
              ),
              const Divider(),
              ElevatedButton(
                onPressed: () {},
                child: const Text('No botón'),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith(getBackgroundColor),
                    foregroundColor:
                        MaterialStateProperty.resolveWith(getTextColor)),
              ),
              const Divider(),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Hola sí'),
                style: ButtonStyle(),
              )
            ],
          ),
        ),
      ),
      //backgroundColor: Styles.defaultGreengroundColor,
      drawer: LombaSideMenu(),
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
