import 'package:flutter/material.dart';
import 'package:front_lomba/helpers/snackbars.dart';
import 'package:front_lomba/widgets/lomba_appbar.dart';
import 'package:front_lomba/widgets/lomba_dialog_notyes.dart';
import 'package:front_lomba/widgets/lomba_filterlistpage.dart';
import 'package:front_lomba/widgets/lomba_titlepage.dart';
import 'package:front_lomba/widgets/userdetail_dialog.dart';
import 'package:front_lomba/widgets/lomba_dialog_error.dart';
import 'package:front_lomba/widgets/lomba_sized_screen.dart';
import 'package:provider/provider.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import 'package:front_lomba/widgets/lomba_sidemenu.dart';
import 'package:front_lomba/services/organization_userslist_services.dart';

class OrganizationUsersList extends StatelessWidget {
  const OrganizationUsersList({Key? key, required this.organizacion}) : super(key: key);

  final String organizacion;
  static const appTitle = 'Lomba';
  static const pageTitle = 'Usuarios de la Organización';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '$appTitle - $pageTitle',
      home: OrganizationUsersListPage(title: '$appTitle - $pageTitle',id: organizacion),
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}

class OrganizationUsersListPage extends StatelessWidget {
  const OrganizationUsersListPage({Key? key,
  required this.title,
  required this.id})
      : super(key: key);

  final String title;
  final String id;

  @override
  Widget build(BuildContext context) {
    final organizationUserslistService = Provider.of<OrganizationUserslistService>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;
    const breakpoint = 1200.0;
    if (screenWidth <= breakpoint) {
      return SmallScreen(title: title, principal: UserListBody(organizationUserslistService: organizationUserslistService, id: id));
    } else {
      return BigScreen(title: title, principal: UserListBody(organizationUserslistService: organizationUserslistService, id: id));
    }
    /*return Scaffold(
      appBar: LombaAppBar(title: title),
      body: UserListBody(organizationUserslistService: organizationUserslistService, id: id),
      drawer: const LombaSideMenu(),
    );*/
  }
}

class UserListBody extends StatelessWidget {
  const UserListBody({
    Key? key,
    required this.organizationUserslistService,
    required this.id,
  }) : super(key: key);

  final OrganizationUserslistService organizationUserslistService;
  final String id;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const LombaTitlePage(
            title: "Usuarios de la Organización",
            subtitle: "Organizaciones / _ / Usuarios",
          ),
          Padding(
          padding: EdgeInsets.zero,
          child: Builder(builder: (BuildContext context) {
            print('muere?');
            return Padding(
              padding: EdgeInsets.zero,
              child: FutureBuilder(
                  future: organizationUserslistService.OrganizationUserslist(id),
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
                                  OrganizationUsersListItem(
                                    id: ps?[1][index]["orga"]["id"],
                                    userId: ps?[1][index]["user"]["id"],
                                    username: ps?[1][index]["user"]["username"],
                                    habilitado: ps?[1][index]["user"]["isDisabled"],
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

class OrganizationUsersListItem extends StatelessWidget {
  final String id;
  final String userId;
  final String username;
  final bool habilitado;

  const OrganizationUsersListItem({Key? key,
  required this.id,
  required this.userId,
  required this.username,
  required this.habilitado})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final organizationUserslistService = Provider.of<OrganizationUserslistService>(context, listen: false);
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
                    username,
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
            onPressed: () async {
              showDialog<String>(
                context: context,
                builder: (context) => GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: LombaDialogNotYes(
                    itemName: username,
                    titleMessage: 'Desactivar',
                    dialogMessage:
                        '¿Desea desactivar al usuario de la organización?',
                  ),
                ),
              ).then((value) async {
                    if (value == 'Sí')
                      {
                        print(userId);
                        final List<dynamic>? respuesta = await organizationUserslistService.EnableDisable(id,userId,!habilitado);

                        if ( !respuesta?[2] ){
                          print('segundo if error');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBarGenerator.getNotificationMessage(
                                'Conexión con el servidor no establecido'));
                        } else if ( respuesta?[0].statusCode == 200){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBarGenerator.getNotificationMessage(
                                'Se ha desactivado al usuario de la organización'));
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
            child: const Icon(Icons.do_not_disturb_on),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            heroTag: null,
            tooltip: 'Quitar usuario de la organización',
            onPressed: () async {
              showDialog<String>(
                context: context,
                builder: (context) => GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: LombaDialogNotYes(
                    itemName: username,
                    titleMessage: 'Quitar de la organización',
                    dialogMessage:
                        '¿Desea quitar al usuario de la organización?',
                  ),
                ),
              ).then((value) async {
                    if (value == 'Sí')
                      {
                        print(userId);
                        final List<dynamic>? respuesta = await organizationUserslistService.DeleteUsers(id,userId);

                        if ( !respuesta?[2] ){
                          print('segundo if error');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBarGenerator.getNotificationMessage(
                                'Conexión con el servidor no establecido'));
                        } else if ( respuesta?[0].statusCode == 200){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBarGenerator.getNotificationMessage(
                                'Se ha quitado al usuario de la organización'));
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
            child: const Icon(Icons.cancel),
          ),
        ],
      ),
    );
  }
}
