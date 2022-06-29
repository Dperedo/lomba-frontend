import 'package:flutter/material.dart';
import 'package:front_lomba/helpers/route_animation.dart';
import 'package:front_lomba/screens/administration/organization_userslist_screen.dart';

import 'package:provider/provider.dart';
import 'package:front_lomba/widgets/lomba_dialog_notyes.dart';
import 'package:front_lomba/widgets/lomba_appbar.dart';
import 'package:front_lomba/widgets/lomba_filterlistpage.dart';
import 'package:front_lomba/widgets/lomba_sidemenu.dart';
import 'package:front_lomba/widgets/lomba_titlepage.dart';
import 'package:front_lomba/widgets/lomba_dialog_error.dart';
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
      body: SingleChildScrollView(
        child: Column(
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
                          return const CircularProgressIndicator();
                        }
                        final ps = snapshot.data;
                        if ( !ps?[2] ){
                          return const LombaDialogErrorDisconnect();
                        } else if ( ps?[0].statusCode == 200 ) {
                          return Column(
                          children: [
                            const LombaFilterListPage(),
                            const Divider(),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: ps?[1].length,
                              itemBuilder: (context, index) {
                                //final item = index.toString();

                                return Column(
                                  children: [
                                    OrganizationListItem(
                                      id: ps?[1][index]["id"],
                                      organizacion: ps?[1][index]["name"],
                                      icon: Icons.business,
                                      habilitado: ps?[1][index]["isDisabled"],
                                    ),
                                    const Divider()
                                  ],
                                );
                              },
                            ),
                          ],
                        );
                        } else if (ps?[0].statusCode >= 400 && ps?[0].statusCode <= 400) {
                          print('400 error');
                          if(ps?[0].statusCode == 401) {
                            return const LombaDialogError401();
                          } else if(ps?[0].statusCode == 403) {
                            return const LombaDialogError403();
                          }
                          return const LombaDialogError400();
                        } else {
                          print('entro error');
                          return const LombaDialogError();
                        }
                        
                      }),
                );
              }),
            ),
          ],
        ),
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
                        final List<dynamic>? respuesta = await organizationService.EnableDisable(id,!habilitado);

                        if ( !respuesta?[2] ){
                          print('segundo if error');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBarGenerator.getNotificationMessage(
                                'Conexión con el servidor no establecido'));
                        } else if ( respuesta?[0].statusCode == 200){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBarGenerator.getNotificationMessage(
                                'Se ha desactivado la organización'));
                        } else if (respuesta?[0].statusCode >= 400 && respuesta?[0].statusCode <= 400) {
                          if(respuesta?[0].statusCode == 401) {
                            ScaffoldMessenger.of(context).showSnackBar(
                            SnackBarGenerator.getNotificationMessage(
                                'Ocurrió un problema con la autentificación'));
                          }else if(respuesta?[0].statusCode == 403) {
                            ScaffoldMessenger.of(context).showSnackBar(
                            SnackBarGenerator.getNotificationMessage(
                                'Ocurrió un problema con la Solicitud'));
                          }else {
                            print('400 error');
                            ScaffoldMessenger.of(context).showSnackBar(
                            SnackBarGenerator.getNotificationMessage(
                                'Ocurrió una solicitud Incorrecta'));
                          }
                        } else {
                          print('salio error');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBarGenerator.getNotificationMessage(
                                'Error con el servidor'));
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
