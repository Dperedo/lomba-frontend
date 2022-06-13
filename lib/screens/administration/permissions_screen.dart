import 'package:flutter/material.dart';
import 'package:front_lomba/helpers/snackbars.dart';
import 'package:front_lomba/widgets/lomba_appbar.dart';
import 'package:front_lomba/widgets/lomba_dialog_notyes.dart';
import 'package:front_lomba/widgets/lomba_filterlistpage.dart';
import 'package:front_lomba/widgets/lomba_sidemenu.dart';
import 'package:front_lomba/widgets/lomba_titlepage.dart';
import 'package:provider/provider.dart';
import 'package:front_lomba/providers/theme_provider.dart';

class Permissions extends StatelessWidget {
  const Permissions({Key? key}) : super(key: key);

  static const appTitle = 'Lomba';
  static const pageTitle = 'Permisos';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '$appTitle - $pageTitle',
      home: const PermissionsPage(title: '$appTitle - $pageTitle'),
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}

class PermissionsPage extends StatelessWidget {
  const PermissionsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LombaAppBar(title: title),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LombaTitlePage(
              title: "Permisos",
              subtitle: "Administración / Permisos",
            ),
            const LombaFilterListPage(),
            const Divider(),
            PermissionListItem(permission: "Permiso 1"),
            const Divider(),
            PermissionListItem(permission: "Permiso 2"),
            const Divider(),
            PermissionListItem(permission: "Permiso 3"),
            const Divider(),
            //Text('Organizaciones!',style: Theme.of(context).textTheme.headline3,),
          ],
        ),
      ),
      drawer: const LombaSideMenu(),
    );
  }
}

class PermissionListItem extends StatelessWidget {
  final String permission;

  const PermissionListItem({Key? key, required this.permission})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          const Icon(Icons.key),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Center(
            child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  child: Text(
                    permission,
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 1.4),
                  ),
                  onPressed: () {},
                )),
          )),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              //showdDelete(context);
              showDialog<String>(
                context: context,
                builder: (context) => GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: LombaDialogNotYes(
                    itemName: permission,
                    titleMessage: 'Desactivar',
                    dialogMessage: '¿Desea desactivar el permiso?',
                  ),
                ),
              ).then((value) => {
                    if (value == 'Sí')
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBarGenerator.getNotificationMessage(
                                'Se ha desactivado el permiso'))
                      },
                  });
            },
            tooltip: 'Desactivar permiso',
            child: const Icon(Icons.do_not_disturb_on),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}