import 'package:flutter/material.dart';

import 'package:front_lomba/model/models.dart';

class MenuOption {
  final String route;
  final IconData icon;
  final String name;
  final Widget screen;

  MenuOption(
      {required this.route,
      required this.icon,
      required this.name,
      required this.screen});
}

class AppRoutes {
  static const initialRoute = '/organizaciones';

  static final menuOptions = <MenuOption>[
    MenuOption(
        route: '/permisos',
        name: 'permisos',
        screen: const Permission(),
        icon: Icons.list_alt),
    MenuOption(
        route: '/usuarios',
        name: 'usuarios',
        screen: const UserScreen(),
        icon: Icons.account_circle_rounded),
    MenuOption(
        route: '/usuarioslist',
        name: 'usuarios_list',
        screen: const UserList(),
        icon: Icons.list_alt),
    MenuOption(
        route: '/organizaciones',
        name: 'organizaciones',
        screen: const Organization(),
        icon: Icons.business),
    MenuOption(
        route: '/login',
        name: 'login',
        screen: const Login(),
        icon: Icons.list_alt),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({'/home': (BuildContext context) => const Home()});

    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }

    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const AlertScreen(),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/home',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/home': (context) => const Home(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/organizaciones': (context) => const Organization(),
      },
    ),
  );
}
