import 'package:flutter/material.dart';

import 'package:front_lomba/screens/user_screen.dart';
import 'package:front_lomba/screens/organization_screen.dart';
import 'package:front_lomba/styles/styles.dart';

class Permit extends StatelessWidget {
  const Permit({Key? key}) : super(key: key);

  static const appTitle = 'Permisos!';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: PermitPage(title: appTitle),
    );
  }
}



class PermitPage extends StatelessWidget {
  const PermitPage({ Key? key, required this.title }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_rounded),
            tooltip: 'Perfil',
            onPressed: () {
            },
          )
        ]
      ),
      body: Center(
        child: Column(
          children: [
            LinearProgressIndicator(),
            Text('Permisos!',style: Theme.of(context).textTheme.headline3,),
          ],
        )
      ),
      
      backgroundColor: Styles.defaultGreengroundColor,
      drawer: Drawer(
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => User()));
              },
            ),
            ListTile(
              title: const Text('Permisos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Permit()));
              },
            ),
          ],
        ),
      ),
    );
  }
}