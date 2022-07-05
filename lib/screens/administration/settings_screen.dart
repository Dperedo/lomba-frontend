import 'package:flutter/material.dart';
import 'package:front_lomba/helpers/preferences.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import 'package:front_lomba/screens/profile_screen.dart';
import 'package:front_lomba/widgets/lomba_sidemenu.dart';
import 'package:front_lomba/widgets/lomba_titlepage.dart';
import 'package:front_lomba/widgets/lomba_appbar.dart';
import 'package:front_lomba/widgets/lomba_sized_screen.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  static const appTitle = 'Lomba';
  @override
  State<Settings> createState() => _SettingsState(title: appTitle);
}

class _SettingsState extends State<Settings> {
  _SettingsState({ required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const breakpoint = 1200.0;
    if (screenWidth <= breakpoint) {
      return SmallScreen(title: title, principal: SettingBody(context));
    } else {
      return BigScreen(title: title, principal: SettingBody(context));
    }
    /*return Scaffold(
      appBar: LombaAppBar(title: title),
      body: SettingBody(context),
      //backgroundColor: Styles.defaultGreengroundColor,
      drawer: const LombaSideMenu(),
    );*/
  }

  Padding SettingBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LombaTitlePage(
              title: "Configuración",
              subtitle: "Administración / Configuración",
            ),
            const Divider(),
            SwitchListTile.adaptive(
                value: Preferences.isDarkmode,
                title: const Text('Modo oscuro'),
                onChanged: (value) {
                  Preferences.isDarkmode = value;
                  final themeProvider =
                      Provider.of<ThemeProvider>(context, listen: false);

                  value
                      ? themeProvider.setDarkmode()
                      : themeProvider.setLightMode();

                  setState(() {});
                }),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
