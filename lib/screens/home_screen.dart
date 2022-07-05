import 'package:flutter/material.dart';

import 'package:front_lomba/providers/theme_provider.dart';
import 'package:front_lomba/widgets/lomba_appbar.dart';
import 'package:front_lomba/widgets/lomba_appmenu.dart';
import 'package:front_lomba/widgets/lomba_sidemenu.dart';
import 'package:front_lomba/widgets/lomba_titlepage.dart';
import 'package:front_lomba/widgets/lomba_sized_screen.dart';
import 'package:front_lomba/helpers/preferences.dart';
import 'package:provider/provider.dart';

//void main() => runApp(const Home());

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static const appTitle = 'Lomba';
  static const pageTitle = 'Home';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '$appTitle - $pageTitle',
      home: const MyHomePage(title: '$appTitle - $pageTitle'),
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final int breakpoint = Preferences.maxScreen;
    if (screenWidth <= breakpoint) {
      return SmallScreen(title: title, principal: const HomePrincipal());
    } else {
      return BigScreen(title: title, principal: const HomePrincipal());
    }
  }
}

class HomePrincipal extends StatelessWidget {
  const HomePrincipal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          LombaTitlePage(
            title: "Inicio",
            subtitle: "Home",
          ),
          Divider(),
          //Text('Organizaciones!',style: Theme.of(context).textTheme.headline3,),
        ],
      ),
    );
  }
}
