import 'package:flutter/material.dart';

import 'package:front_lomba/screens/home_screen.dart';
import 'package:front_lomba/screens/permit_screen.dart';
import 'package:front_lomba/screens/user_screen.dart';
import 'package:front_lomba/screens/organization_screen.dart';
import 'package:front_lomba/screens/alert_screen.dart';
import 'package:front_lomba/screens/login_screen.dart';

class MenuOption {

  final String route;
  final IconData icon;
  final String name;
  final Widget screen;

  MenuOption({
    required this.route,
    required this.icon,
    required this.name,
    required this.screen
  });

}

class AppRoutes {

  static const initialRoute = '/home';

  static final menuOptions = <MenuOption>[
    
    MenuOption(route: '/permisos', name: 'permisos', screen: const Permit(), icon: Icons.list_alt ),
    MenuOption(route: '/usuarios', name: 'usuarios', screen: const User(), icon: Icons.list_alt ),
    MenuOption(route: '/organizaciones', name: 'organizaciones', screen: const Organization(), icon: Icons.list_alt ),
    MenuOption(route: '/login', name: 'login', screen: const Login(), icon: Icons.list_alt ),
  ];


  static Map<String, Widget Function(BuildContext)> getAppRoutes() {

    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({ '/home' : ( BuildContext context ) => const Home() });

    for (final option in menuOptions ) {
      appRoutes.addAll({ option.route : ( BuildContext context ) => option.screen });
    }

    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute( RouteSettings settings) {        
      return MaterialPageRoute(
          builder: (context) => const AlertScreen(),
      );
  }

}