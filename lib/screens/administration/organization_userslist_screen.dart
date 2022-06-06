import 'package:flutter/material.dart';
import 'package:front_lomba/helpers/snackbars.dart';
import 'package:front_lomba/widgets/lomba_appbar.dart';
import 'package:front_lomba/widgets/lomba_dialog_notyes.dart';
import 'package:front_lomba/widgets/lomba_filterlistpage.dart';
import 'package:front_lomba/widgets/lomba_titlepage.dart';
import 'package:front_lomba/widgets/userdetail_dialog.dart';
import 'package:provider/provider.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import 'package:front_lomba/widgets/lomba_sidemenu.dart';

class OrganizationUsersList extends StatelessWidget {
  const OrganizationUsersList({Key? key}) : super(key: key);

  static const appTitle = 'Lomba';
  static const pageTitle = 'Usuarios de la Organización';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '$appTitle - $pageTitle',
      home: const OrganizationUsersListPage(title: '$appTitle - $pageTitle'),
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}

class OrganizationUsersListPage extends StatelessWidget {
  const OrganizationUsersListPage({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LombaAppBar(title: title),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            LombaTitlePage(
              title: "Usuarios de la Organización",
              subtitle: "Organizaciones / _ / Usuarios",
            ),
            LombaFilterListPage(),
            Divider(),
            OrganizationUsersListItem(
              user: "user 1",
            ),
            Divider(),
            OrganizationUsersListItem(
              user: "user 2",
            ),
            Divider(),
            OrganizationUsersListItem(
              user: "user 3",
            ),
            Divider(),
            //Text('Organizaciones!',style: Theme.of(context).textTheme.headline3,),
          ],
        ),
      ),
      drawer: const LombaSideMenu(),
    );
  }
}

class OrganizationUsersListItem extends StatelessWidget {
  final String user;

  const OrganizationUsersListItem({Key? key, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          const Icon(Icons.person),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Center(
            child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  child: Text(
                    user,
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 1.4),
                  ),
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (context) => GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Scaffold(
                          backgroundColor: Colors.transparent,
                          body: Builder(
                            builder: (context) => GestureDetector(
                                onTap: () {
                                  //Navigator.of(context).push(_createAlertRoute());
                                },
                                child: const UserDetailDialog()),
                          ),
                        ),
                      ),
                    );
                  },
                )),
          )),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            heroTag: null,
            tooltip: 'Desactivar usuario de la organización',
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (context) => GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: LombaDialogNotYes(
                    itemName: user,
                    titleMessage: 'Desactivar',
                    dialogMessage:
                        '¿Desea desactivar al usuario de la organización?',
                  ),
                ),
              ).then((value) => {
                    if (value == 'Sí')
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBarGenerator.getNotificationMessage(
                                'Se ha desactivado al usuario de la organización'))
                      },
                  });
            },
            child: const Icon(Icons.do_not_disturb_on),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            heroTag: null,
            tooltip: 'Quitar usuario de la organización',
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (context) => GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: LombaDialogNotYes(
                    itemName: user,
                    titleMessage: 'Quitar de la organización',
                    dialogMessage:
                        '¿Desea quitar al usuario de la organización?',
                  ),
                ),
              ).then((value) => {
                    if (value == 'Sí')
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBarGenerator.getNotificationMessage(
                                'Se ha quitado al usuario de la organización'))
                      },
                  });
            },
            child: const Icon(Icons.cancel),
          ),
        ],
      ),
    );
  }
}
