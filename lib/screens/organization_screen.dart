import 'package:flutter/material.dart';

import 'package:front_lomba/screens/permit_screen.dart';
import 'package:front_lomba/screens/user_screen.dart';
import 'package:front_lomba/styles/styles.dart';

//void main() => runApp(const Permisos());

class Organization extends StatelessWidget {
  const Organization({Key? key}) : super(key: key);

  static const appTitle = 'Organizaciones';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: OrganizationPage(title: appTitle),
    );
  }
}

class OrganizationPage extends StatelessWidget {
  const OrganizationPage({ Key? key, required this.title }) : super(key: key);

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
            CircularProgressIndicator(),
            Divider(),
            Text('Organizaciones!',style: Theme.of(context).textTheme.headline3,),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => Permit()));
              },
            ),
          ],
        ),
      ),
    );
  }
}