import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:front_lomba/providers/theme_provider.dart';

import 'package:front_lomba/model/models.dart';
import 'package:front_lomba/widgets/lomba_sidemenu.dart';

//void main() => runApp(const Permisos());

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  static const appTitle = 'Lomba';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: UserListPage(title: appTitle),
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}

class UserListPage extends StatelessWidget {
  const UserListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  //Array organizacion = ['organizacion 1','organizacion 2','organizacion 3'] as Array<NativeType>,

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: [
        IconButton(
          icon: const Icon(Icons.account_circle_rounded),
          tooltip: 'Perfil',
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Profile()));
          },
        )
      ]),
      body: Center(
        child: Column(
          children: [
            TitleSection(
              title: "Usuarios de Lomba",
              subtitle: "Organizaciones / Lomba / Usuarios",
            ),
            FilterSection(),
            Divider(),
            ListSection(
              user: "user 1",
            ),
            Divider(),
            ListSection(
              user: "user 2",
            ),
            Divider(),
            ListSection(
              user: "user 3",
            ),
            Divider(),
            //Text('Organizaciones!',style: Theme.of(context).textTheme.headline3,),
          ],
        ),
      ),
      drawer: LombaSideMenu(),
    );
  }
}
