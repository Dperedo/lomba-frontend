import 'package:flutter/material.dart';
import 'package:lomba_frontend/features/login/presentation/pages/home_page.dart';
import 'package:lomba_frontend/features/login/presentation/pages/login_page.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({
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
            child: Text('Opciones'),
          ),
          ListTile(
            leading: const Icon(Icons.business_center),
            title: const Text('Organizaciones'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.people_outline),
            title: const Text('Usuarios'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.key_outlined),
            title: const Text('Roles'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.login_outlined),
            title: const Text('Iniciar sesión'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
