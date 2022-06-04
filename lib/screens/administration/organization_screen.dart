import 'package:flutter/material.dart';
import 'package:front_lomba/helpers/route_animation.dart';
import 'package:front_lomba/model/models.dart';
import 'package:provider/provider.dart';
import 'package:front_lomba/widgets/lomba_dialog_notyes.dart';
import 'package:front_lomba/widgets/lomba_appbar.dart';
import 'package:front_lomba/widgets/lomba_filterlistpage.dart';
import 'package:front_lomba/widgets/lomba_sidemenu.dart';
import 'package:front_lomba/widgets/lomba_titlepage.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import 'package:front_lomba/helpers/snackbars.dart';

class Organizations extends StatelessWidget {
  const Organizations({Key? key}) : super(key: key);

  static const appTitle = 'Lomba';
  static const pageTitle = 'Organizaciones';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle + ' - ' + pageTitle,
      home: OrganizationsPage(title: appTitle + ' - ' + pageTitle),
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}

class OrganizationsPage extends StatelessWidget {
  const OrganizationsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LombaAppBar(title: title),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LombaTitlePage(
              title: "Organizaciones",
              subtitle: "Administrador / Organizaciones",
            ),
            LombaFilterListPage(),
            Divider(),
            OrganizationListItem(
              organizacion: "Organizacion 1",
              icon: Icons.business,
            ),
            Divider(),
            OrganizationListItem(
              organizacion: "Organizacion 2",
              icon: Icons.business,
            ),
            Divider(),
            OrganizationListItem(
              organizacion: "Organizacion 3",
              icon: Icons.business,
            ),
            Divider(),
            OrganizationListItem(
              organizacion: "Organizacion 4",
              icon: Icons.business,
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

class OrganizationListItem extends StatelessWidget {
  final String organizacion;
  final IconData icon;

  OrganizationListItem({
    Key? key,
    required this.organizacion,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: new EdgeInsets.all(15.0),
      child: Row(
        children: [
          Icon(this.icon),
          SizedBox(
            width: 20,
          ),
          Expanded(
              child: Center(
            child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  child: Text(
                    this.organizacion,
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 1.4),
                  ),
                  onPressed: () {},
                )),
          )),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (context) => GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: LombaDialogNotYes(
                    itemName: organizacion,
                    titleMessage: 'Desactivar',
                    dialogMessage: '¿Desea desactivar la organización?',
                  ),
                ),
              ).then((value) => {
                    // ignore: unrelated_type_equality_checks
                    if (value == 'Sí')
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBarGenerator.getNotificationMessage(
                                'Se ha desactivado la organización'))
                      },
                  });
            },
            tooltip: 'Desactivar organización',
            child: Icon(Icons.do_not_disturb_on),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            heroTag: null,
            tooltip: 'Ver usuarios de la organización',
            child: Icon(Icons.supervised_user_circle_outlined),
            onPressed: () {
              Navigator.of(context).push(
                  RouteAnimation.animatedTransition(OrganizationUsersList()));
            },
          ),
        ],
      ),
    );
  }
}
