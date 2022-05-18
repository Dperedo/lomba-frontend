import 'package:flutter/material.dart';
import 'package:front_lomba/model/models.dart';

import 'package:front_lomba/screens/permit_screen.dart';
import 'package:front_lomba/screens/user_screen.dart';
import 'package:front_lomba/screens/organization_screen.dart';
import 'package:front_lomba/styles/styles.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  static const appTitle = 'Menu';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: ProfilePage(title: appTitle),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({ Key? key, required this.title }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ProfileSection(),
            ],
          ),
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