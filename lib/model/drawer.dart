import 'package:flutter/material.dart';

import 'package:front_lomba/model/models.dart';

class DrawerSection extends StatelessWidget {
  const DrawerSection({
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
            child: Text('Cuenta'),
          ),
          ListTile(
            leading: const Icon(Icons.business_center),
            title: const Text('Organizaciones'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Organization()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.people_outline),
            title: const Text('Usuarios'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const UserScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.key_outlined),
            title: const Text('Permisos'),
            onTap: () {
              Navigator.of(context).push(_createPermissionRoute());
            },
          ),
        ],
      ),
    );
  }

  Route _createPermissionRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const Permission(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
