import 'package:flutter/material.dart';
import 'package:front_lomba/model/listpermission.dart';
import 'package:front_lomba/model/models.dart';
import 'package:front_lomba/router/app_routes.dart';

class Permission extends StatelessWidget {
  const Permission({Key? key}) : super(key: key);

  static const appTitle = 'Lomba';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: PermissionPage(title: appTitle),
    );
  }
}

class PermissionPage extends StatelessWidget {
  const PermissionPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final menuOptions = AppRoutes.menuOptions;

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
              title: "Permisos",
              subtitle: "Administración / Permisos",
            ),
            FilterSection(),
            Divider(),
            ListPermissionSection(permission: "Permiso 1"),
            Divider(),
            ListPermissionSection(permission: "Permiso 2"),
            Divider(),
            ListPermissionSection(permission: "Permiso 3"),
            Divider(),
            //Text('Organizaciones!',style: Theme.of(context).textTheme.headline3,),
          ],
        ),
      ),
      backgroundColor: Styles.defaultGreengroundColor,
      drawer: DrawerSection(),
    );
  }
}
