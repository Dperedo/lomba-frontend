import 'package:flutter/material.dart';

import 'package:front_lomba/model/models.dart';

//void main() => runApp(const Permisos());

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  static const appTitle = 'Lomba';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: UserListPage(title: appTitle),
    );
  }
}

class UserListPage extends StatelessWidget {
  const UserListPage({ Key? key, required this.title }) : super(key: key);

  final String title;

  //Array organizacion = ['organizacion 1','organizacion 2','organizacion 3'] as Array<NativeType>,

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
            TitleSection(title: "Usuarios de Lomba",subtitle: "Organizaciones / Lomba / Usuarios",),
            ListSection(user: "user 1",),
            ListSection(user: "user 2",),
            ListSection(user: "user 3",),
            //Text('Organizaciones!',style: Theme.of(context).textTheme.headline3,),
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