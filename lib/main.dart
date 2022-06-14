import 'package:flutter/material.dart';
import 'package:front_lomba/screens/administration/allusers_screen.dart';
import 'package:front_lomba/screens/administration/organization_screen.dart';
import 'package:front_lomba/screens/administration/organization_userslist_screen.dart';
import 'package:front_lomba/screens/administration/user_edit_screen.dart';
import 'package:front_lomba/screens/democolors_screen.dart';
import 'package:front_lomba/screens/home_screen.dart';
import 'package:front_lomba/screens/login_screen.dart';
import 'package:front_lomba/screens/profile_screen.dart';
import 'package:front_lomba/services/permission_service.dart';
import 'package:provider/provider.dart';

import 'package:front_lomba/helpers/preferences.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import 'package:front_lomba/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => ThemeProvider(isDarkmode: Preferences.isDarkmode)),
      ChangeNotifierProvider(create: (_) => AuthService()),
      ChangeNotifierProvider(create: (_) => PermissionsService()),
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
      initialRoute: '/login',
      routes: {
        '/home': (context) => const Home(),
        '/organizations': (context) => const Organizations(),
        '/allusers': (context) => const AllUsers(),
        '/organizations_userlist': (context) => const OrganizationUsersList(),
        '/user_edit': (context) => const UserEdit(),
        '/user_profile': (context) => const UserProfile(),
        '/democolors': (context) => const DemoColors(),
        '/login': (context) => LoginScreen(),
      },
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}
