import 'package:flutter/material.dart';
import 'package:front_lomba/helpers/snackbars.dart';

import 'package:front_lomba/model/models.dart';
import 'package:front_lomba/widgets/lomba_appbar.dart';
import 'package:front_lomba/widgets/lomba_dialog_notyes.dart';
import 'package:front_lomba/widgets/lomba_filterlistpage.dart';
import 'package:front_lomba/widgets/lomba_sidemenu.dart';
import 'package:front_lomba/widgets/lomba_titlepage.dart';
import 'package:provider/provider.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import '../../helpers/route_animation.dart';

class AllUsers extends StatelessWidget {
  const AllUsers({Key? key}) : super(key: key);

  static const appTitle = 'Lomba';
  static const pageTitle = 'Todos los usuarios';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle + ' - ' + pageTitle,
      home: AllUsersPage(title: appTitle + ' - ' + pageTitle),
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}

class AllUsersPage extends StatelessWidget {
  const AllUsersPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LombaAppBar(title: title),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LombaTitlePage(
              title: "Todos los usuarios",
              subtitle: "Administrador / Todos los usuarios",
            ),
            LombaFilterListPage(),
            Divider(),
            AllUsersListItem(username: "username 1"),
            Divider(),
            AllUsersListItem(username: "username 2"),
            Divider(),
            AllUsersListItem(username: "username 3"),
            Divider(),
          ],
        ),
      ),
      drawer: LombaSideMenu(),
    );
  }
}

class AllUsersListItem extends StatelessWidget {
  final String username;
  AllUsersListItem({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: new EdgeInsets.all(15.0),
      child: Row(
        children: [
          Icon(Icons.person),
          SizedBox(
            width: 20,
          ),
          Expanded(
              child: Center(
            child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  child: Text(
                    this.username,
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
                                child: UserDetailDialog()),
                          ),
                        ),
                      ),
                    );
                  },
                )),
          )),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            tooltip: 'Organizaciones del usuario',
            onPressed: () {},
            child: Text('1', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            tooltip: 'Desactivar al usuario',
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (context) => GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: LombaDialogNotYes(
                    itemName: username,
                    titleMessage: 'Desactivar',
                    dialogMessage: '¿Desea desactivar al usuario?',
                  ),
                ),
              ).then((value) => {
                    if (value == 'Sí')
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBarGenerator.getNotificationMessage(
                                'Se ha desactivado al usuario'))
                      },
                  });
            },
            child: Icon(Icons.do_not_disturb_on),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            tooltip: 'Editar usuario',
            child: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .push(RouteAnimation.animatedTransition(UserEdit()));
            },
          ),
        ],
      ),
    );
  }
}
