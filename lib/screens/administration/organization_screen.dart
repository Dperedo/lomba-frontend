import 'package:flutter/material.dart';
import 'package:front_lomba/helpers/route_animation.dart';
import 'package:front_lomba/screens/administration/organization_userslist_screen.dart';

import 'package:provider/provider.dart';
import 'package:front_lomba/widgets/lomba_dialog_notyes.dart';
import 'package:front_lomba/widgets/lomba_appbar.dart';
import 'package:front_lomba/widgets/lomba_filterlistpage.dart';
import 'package:front_lomba/widgets/lomba_sidemenu.dart';
import 'package:front_lomba/widgets/lomba_titlepage.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import 'package:front_lomba/helpers/snackbars.dart';
import 'package:front_lomba/services/organization_service.dart';

class Organizations extends StatelessWidget {
  const Organizations({Key? key}) : super(key: key);

  static const appTitle = 'Lomba';
  static const pageTitle = 'Organizaciones';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '$appTitle - $pageTitle',
      home: const OrganizationsPage(title: '$appTitle - $pageTitle'),
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}

class OrganizationsPage extends StatelessWidget {
  const OrganizationsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final organizationService = Provider.of<OrganizationService>(context, listen: false);
    return Scaffold(
      appBar: LombaAppBar(title: title),
      body: Column(
        children: [
          const LombaTitlePage(
            title: "Organizaciones",
            subtitle: "Administrador / Organizaciones",
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: Builder(builder: (BuildContext context) {
              print('muere?');

              return Padding(
                padding: EdgeInsets.zero,
                child: FutureBuilder(
                    future: organizationService.OrganizationList(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<dynamic>?> snapshot) {
                      if (snapshot.data == null) {
                        //IR a pantalla que indica
                        //no cargó valores.
                        return Text('nada');
                      }
                      final ps = snapshot.data;
                      return Column(
                        children: [
                          const LombaFilterListPage(),
                          const Divider(),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: ps?.length,
                            itemBuilder: (context, index) {
                              final item = index.toString();

                              return Column(
                                children: [
                                  OrganizationListItem(
                                    id: ps?[index]["id"],
                                    organizacion: ps?[index]["name"],
                                    icon: Icons.business,
                                    habilitado: ps?[index]["isDisabled"],
                                  ),
                                  const Divider()
                                ],
                              );
                            },
                          ),
                        ],
                      );
                    }),
              );
            }),
          ),
        ],
      ),
      drawer: const LombaSideMenu(),
    );
  }
}

class OrganizationListItem extends StatelessWidget {
  final String id;
  final String organizacion;
  final IconData icon;
  final bool habilitado;


  const OrganizationListItem({
    Key? key,
    required this.id,
    required this.organizacion,
    required this.icon,
    required this.habilitado
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final organizationService = Provider.of<OrganizationService>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Center(
            child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  child: Text(
                    organizacion,
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
            onPressed: () async {
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
              ).then((value) async {
                    if (value == 'Sí')
                      {
                        final bool respuesta = await organizationService.EnableDisable(id,!habilitado);
                        if (respuesta == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBarGenerator.getNotificationMessage(
                                'Se ha desactivado la organización'));
                                }
                      }
                  });
            },
            tooltip: 'Desactivar organización',
            child: const Icon(Icons.do_not_disturb_on),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            heroTag: null,
            tooltip: 'Ver usuarios de la organización',
            child: const Icon(Icons.supervised_user_circle_outlined),
            onPressed: () {
              Navigator.of(context).push(RouteAnimation.animatedTransition(
                  OrganizationUsersList(organizacion: id)));
            },
          ),
        ],
      ),
    );
  }
}
