import 'package:flutter/material.dart';
import 'package:front_lomba/helpers/preferences.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import 'package:front_lomba/screens/profile_screen.dart';
import 'package:front_lomba/widgets/lomba_sidemenu.dart';
import 'package:front_lomba/widgets/lomba_titlepage.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  static const appTitle = 'Lomba';
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lomba'), actions: [
        IconButton(
          icon: const Icon(Icons.account_circle_rounded),
          tooltip: 'Perfil',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UserProfile()));
          },
        )
      ]),
      body: Padding(
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
      ),
      //backgroundColor: Styles.defaultGreengroundColor,
      drawer: const LombaSideMenu(),
    );
  }
}
