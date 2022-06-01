import 'package:flutter/material.dart';
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
      title: 'Material App',
      initialRoute: '/profile_edit',
      routes: {
        '/home': (context) => const Home(),
        '/organizaciones': (context) => const Organization(),
        '/usuarios': (context) => const UserScreen(),
        '/usuarios_list': (context) => const UserList(),
        '/profile_edit': (context) =>  EditProfile(),
        '/profile': (context) =>  Profile(),
      },
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}
