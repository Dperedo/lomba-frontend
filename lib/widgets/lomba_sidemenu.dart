import 'package:flutter/material.dart';
import 'package:front_lomba/helpers/route_animation.dart';
import 'package:front_lomba/model/models.dart';
import 'package:front_lomba/screens/administration/settings_screen.dart';

class LombaSideMenu extends StatelessWidget {
  const LombaSideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menú principal'),
          ),
          ListTile(
            leading: const Icon(Icons.business_center),
            title: const Text('Organizaciones'),
            onTap: () {
              Navigator.of(context)
                  .push(RouteAnimation.animatedTransition(Organization()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.people_outline),
            title: const Text('Todos los usuarios'),
            onTap: () {
              Navigator.of(context)
                  .push(RouteAnimation.animatedTransition(UserScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.key_outlined),
            title: const Text('Permisos'),
            onTap: () {
              Navigator.of(context)
                  .push(RouteAnimation.animatedTransition(Permission()));
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
            leading: const Icon(Icons.home),
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
