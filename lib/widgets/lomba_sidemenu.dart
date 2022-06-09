import 'package:flutter/material.dart';
import 'package:front_lomba/helpers/route_animation.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import 'package:front_lomba/screens/administration/allusers_screen.dart';
import 'package:front_lomba/screens/administration/organization_screen.dart';
import 'package:front_lomba/screens/administration/permissions_screen.dart';
import 'package:front_lomba/screens/administration/settings_screen.dart';
import 'package:front_lomba/screens/democolors_screen.dart';
import 'package:front_lomba/screens/home_screen.dart';
import 'package:front_lomba/screens/login_screen.dart';
import 'package:provider/provider.dart';

class LombaSideMenu extends StatelessWidget {
  const LombaSideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> menu = [];
    menu.add(DrawerHeader(
            decoration: BoxDecoration(
              color: Provider.of<ThemeProvider>(context).getPrimaryColor(),
            ),
            child: Text('Menú principal',
                style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).getTextColor())),
          ),);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Provider.of<ThemeProvider>(context).getPrimaryColor(),
            ),
            child: Text('Menú principal',
                style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).getTextColor())),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context)
                  .push(RouteAnimation.animatedTransition(Home()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.business_center),
            title: const Text('Organizaciones'),
            onTap: () {
              Navigator.of(context)
                  .push(RouteAnimation.animatedTransition(Organizations()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.people_outline),
            title: const Text('Todos los usuarios'),
            onTap: () {
              Navigator.of(context)
                  .push(RouteAnimation.animatedTransition(AllUsers()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.key_outlined),
            title: const Text('Permisos'),
            onTap: () {
              Navigator.of(context)
                  .push(RouteAnimation.animatedTransition(Permissions()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () {
              Navigator.of(context)
                  .push(RouteAnimation.animatedTransition(Settings()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.colorize),
            title: const Text('Colores'),
            onTap: () {
              Navigator.of(context)
                  .push(RouteAnimation.animatedTransition(DemoColors()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.keyboard_arrow_left),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.of(context)
                  .push(RouteAnimation.animatedTransition(LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
