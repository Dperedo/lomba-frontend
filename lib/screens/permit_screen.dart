import 'package:flutter/material.dart';
import 'package:front_lomba/model/listpermission.dart';
import 'package:front_lomba/model/models.dart';
import 'package:front_lomba/widgets/lomba_sidemenu.dart';
import 'package:provider/provider.dart';
import 'package:front_lomba/providers/theme_provider.dart';

class Permission extends StatelessWidget {
  const Permission({Key? key}) : super(key: key);

  static const appTitle = 'Lomba';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: PermissionPage(title: appTitle),
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}

class PermissionPage extends StatelessWidget {
  const PermissionPage({Key? key, required this.title}) : super(key: key);

  final String title;

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
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
      ),
      drawer: LombaSideMenu(),
    );
  }
}
