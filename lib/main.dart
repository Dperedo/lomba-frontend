import 'package:flutter/material.dart';
import 'package:front_lomba/screens/democolors_screen.dart';
import 'package:provider/provider.dart';

import 'package:front_lomba/model/models.dart';
import 'package:front_lomba/model/preferences.dart';
import 'package:front_lomba/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => ThemeProvider(isDarkmode: Preferences.isDarkmode))
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lomba App',
      initialRoute: '/home',
      routes: {
        '/home': (context) => const Home(),
        '/organizations': (context) => const Organizations(),
        '/allusers': (context) => const AllUsers(),
        '/organizations_userlist': (context) => const OrganizationUsersList(),
        '/user_edit': (context) => UserEdit(),
        '/profile': (context) => Profile(),
        '/colors': (context) => DemoColors(),
      },
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}
