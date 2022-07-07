import 'package:flutter/material.dart';
import 'package:front_lomba/helpers/snackbars.dart';
import 'package:front_lomba/helpers/preferences.dart';
import 'package:front_lomba/widgets/lomba_appbar.dart';
import 'package:front_lomba/widgets/lomba_dialog_notyes.dart';
import 'package:front_lomba/widgets/lomba_filterlistpage.dart';
import 'package:front_lomba/widgets/lomba_sidemenu.dart';
import 'package:front_lomba/widgets/lomba_titlepage.dart';
import 'package:provider/provider.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import 'package:front_lomba/services/permission_service.dart';
import 'package:front_lomba/services/auth_service.dart';
import 'package:front_lomba/widgets/lomba_dialog_error.dart';
import 'package:front_lomba/widgets/lomba_sized_screen.dart';
import 'package:front_lomba/screens/login_screen.dart';
import 'package:front_lomba/helpers/route_animation.dart';

class Permissions extends StatelessWidget {
  const Permissions({Key? key}) : super(key: key);

  static const appTitle = 'Lomba';
  static const pageTitle = 'Permisos';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '$appTitle - $pageTitle',
      home: const _PermissionsPage(title: '$appTitle - $pageTitle'),
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}

class _PermissionsPage extends StatelessWidget {
  const _PermissionsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  build(BuildContext context)  {
    final permiService = Provider.of<PermissionsService>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;
    final int breakpoint = Preferences.maxScreen;
    if (screenWidth <= breakpoint) {
      return SmallScreen(title: title, principal: PermisoBody(permiService: permiService));
    } else {
      return BigScreen(title: title, principal: PermisoBody(permiService: permiService));
    }
    /*return Scaffold(
      appBar: LombaAppBar(title: title),
      body: PermisoBody(permiService: permiService),
      drawer: const LombaSideMenu(),
    );*/
  }
}

class PermisoBody extends StatelessWidget {
  const PermisoBody({
    Key? key,
    required this.permiService,
  }) : super(key: key);

  final PermissionsService permiService;
  //late Future<int> permiService.PermissionsList();

  @override
  /*void initState() {
    super.initState();
  };*/
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const LombaTitlePage(
            title: "Permisos",
            subtitle: "Administración / Permisos",
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: Builder(builder: (BuildContext context) {
              print('muere?');

              return Padding(
                padding: EdgeInsets.zero,
                child: FutureBuilder(
                    future: permiService.PermissionsList(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<dynamic>?> snapshot) {
                      if (snapshot.data == null) {
                        return const CircularProgressIndicator();
                      } 
                      final ps = snapshot.data;
                      if ( !ps?[2] ){
                        print('segundo if error');
                        return const LombaDialogErrorDisconnect();
                      }else if ( ps?[0].statusCode == 200){ 
                        return Column(
                          children: [
                            const LombaFilterListPage(),
                            const Divider(),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: ps?[1].length,
                              itemBuilder: (context, index) {
                                final item = index.toString();

                                return Column(
                                  children: [
                                    PermissionListItem(
                                      permission: ps?[1][index]["name"],
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
                        print('salio error');
                        return const LombaDialogError();
                      }
                }),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class PermissionListItem extends StatelessWidget {
  final String permission;
  final bool habilitado;

  const PermissionListItem({Key? key, 
  required this.permission,
  required this.habilitado})
      : super(key: key);
      

  @override
  Widget build(BuildContext context) {
    final permiService = Provider.of<PermissionsService>(context, listen: false);
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
          if(habilitado)...[
            FloatingActionButton(
              heroTag: null,
              onPressed: () async {
                showDialog<String>(
                  context: context,
                  builder: (context) => GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: LombaDialogNotYes(
                      itemName: permission,
                      titleMessage: 'Activar',
                      dialogMessage: '¿Desea activar el permiso?',
                    ),
                  ),
                ).then((value) async {
                      if (value == 'Sí')
                        {
                          final List<dynamic>? respuesta = await permiService.EnableDisable(permission,!habilitado);
                          //consumir servicio de PermissionService
                          
                          if ( !respuesta?[2] ){
                            print('segundo if error');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBarGenerator.getNotificationMessage(
                                  'Conexión con el servidor no establecido'));
                          } else if ( respuesta?[0].statusCode == 200){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBarGenerator.getNotificationMessage(
                                  'Se ha Activado el permiso'));
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
                          //setState(() {});
                        }
                    }
                  );
              },
              tooltip: 'Activar permiso',
              backgroundColor: Colors.red[600],
              child: const Icon(Icons.do_not_disturb_on),
            ),
          ]else...[
            FloatingActionButton(
              heroTag: null,
              onPressed: () async {
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
                ).then((value) async {
                      if (value == 'Sí')
                        {
                          final List<dynamic>? respuesta = await permiService.EnableDisable(permission,!habilitado);
                          //consumir servicio de PermissionService
                          
                          if ( !respuesta?[2] ){
                            print('segundo if error');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBarGenerator.getNotificationMessage(
                                  'Conexión con el servidor no establecido'));
                          } else if ( respuesta?[0].statusCode == 200){
                            //print('en la alerta !!!!!!!!!!!!!');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBarGenerator.getNotificationMessage(
                                  'Se ha desactivado el permiso'));
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
                          permiService.PermissionsList();
                          //print('despeus de la alerta !!!!!!!!!!!!!');
                        }
                    }
                  );
                  /*setState() {
                    var ps = permiService.PermissionsList();
                  };
                  print('despeus del set !!!!!!!!!!!!!');*/
              },
              tooltip: 'Desactivar permiso',
              child: const Icon(Icons.done_rounded),//do_not_disturb_on
            ),
          ],
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => Text(sender);

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}
