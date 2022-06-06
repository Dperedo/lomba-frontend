import 'package:flutter/material.dart';

import 'package:front_lomba/model/models.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import 'package:front_lomba/screens/login_screen.dart';
import 'package:front_lomba/styles/styles.dart';
import 'package:front_lomba/widgets/lomba_appbar.dart';
import 'package:front_lomba/widgets/lomba_sidemenu.dart';
import 'package:front_lomba/widgets/lomba_titlepage.dart';
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
      title: appTitle + ' - ' + pageTitle,
      home: MyHomePage(title: appTitle + ' - ' + pageTitle),
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LombaAppBar(title: title),
      body: SingleChildScrollView(
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
      ),
      drawer: const LombaSideMenu(),
    );
  }
}
