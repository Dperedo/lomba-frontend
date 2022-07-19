import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_lomba/screens/administration/allusers_screen.dart';
import 'package:front_lomba/screens/administration/organization_screen.dart';
import 'package:front_lomba/screens/administration/organization_userslist_screen.dart';
import 'package:front_lomba/screens/administration/permissions_screen.dart';
import 'package:front_lomba/screens/administration/user_edit_screen.dart';
import 'package:front_lomba/screens/democolors_screen.dart';
import 'package:front_lomba/screens/home_screen.dart';
import 'package:front_lomba/screens/login_screen.dart';
import 'package:front_lomba/screens/profile_screen.dart';
import 'package:front_lomba/services/organization_service.dart';
import 'package:front_lomba/services/permission_service.dart';
import 'package:front_lomba/services/organization_userslist_services.dart';
import 'package:front_lomba/services/alluser_service.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'package:front_lomba/helpers/preferences.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import 'package:front_lomba/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:front_lomba/providers/url_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  /*SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]).then((_){
           runApp(MyApp());
           });*/

  await Preferences.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => ThemeProvider(isDarkmode: Preferences.isDarkmode)),
      ChangeNotifierProvider(create: (_) => AuthService()),
      ChangeNotifierProvider(create: (_) => PermissionsService()),
      ChangeNotifierProvider(create: (_) => OrganizationService()),
      ChangeNotifierProvider(create: (_) => OrganizationUserslistService()),
      ChangeNotifierProvider(create: (_) => UserService()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lomba App',
      initialRoute: '/login',
      routes: <String, WidgetBuilder>{
        '/home': (context) => const Home(),
        '/organizations': (context) => const Organizations(),
        '/allusers': (context) => const AllUsers(),
        '/permissions': (context) => const Permissions(),
        //'/organizations_userlist': (context) => const OrganizationUsersList(),
        //'/user_edit': (context) => const UserEdit(),
        '/user_profile': (context) => const UserProfile(),
        '/democolors': (context) => const DemoColors(),
        '/login': (context) => LoginScreen(),
      },
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}
