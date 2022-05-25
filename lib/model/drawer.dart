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
            title: const Text('Organizaciones'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Organization()));
            },
          ),
          ListTile(
            title: const Text('Usuarios'),
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => User()));
              Navigator.push(context, MaterialPageRoute(builder: (context) => const UserScreen()));
            },
          ),
          ListTile(
            title: const Text('Permisos'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Permit()));
            },
          ),
        ],
      ),
    );
  }
}