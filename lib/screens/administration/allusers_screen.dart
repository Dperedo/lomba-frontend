import 'package:flutter/material.dart';
import 'package:front_lomba/helpers/snackbars.dart';
import 'package:front_lomba/screens/administration/user_edit_screen.dart';

import 'package:front_lomba/widgets/lomba_appbar.dart';
import 'package:front_lomba/widgets/lomba_dialog_notyes.dart';
import 'package:front_lomba/widgets/lomba_filterlistpage.dart';
import 'package:front_lomba/widgets/lomba_sidemenu.dart';
import 'package:front_lomba/widgets/lomba_titlepage.dart';
import 'package:front_lomba/widgets/userdetail_dialog.dart';
import 'package:front_lomba/widgets/lomba_dialog_error.dart';
import 'package:provider/provider.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import '../../helpers/route_animation.dart';
import 'package:front_lomba/services/alluser_service.dart';

class AllUsers extends StatelessWidget {
  const AllUsers({Key? key}) : super(key: key);

  static const appTitle = 'Lomba';
  static const pageTitle = 'Todos los usuarios';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '$appTitle - $pageTitle',
      home: const AllUsersPage(title: '$appTitle - $pageTitle'),
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}

class AllUsersPage extends StatelessWidget {
  const AllUsersPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final allusersService = Provider.of<UserService>(context, listen: false);
    return Scaffold(
      appBar: LombaAppBar(title: title),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const LombaTitlePage(
              title: "Todos los usuarios",
              subtitle: "Administrador / Todos los usuarios",
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: Builder(builder: (BuildContext context) {
                print('muere?');

                return Padding(
                  padding: EdgeInsets.zero,
                  child: FutureBuilder(
                      future: allusersService.UserList(),
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
                                      AllUsersListItem(
                                        id: ps?[1][index]["id"],
                                        username: ps?[1][index]["username"],
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
                      }
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
      drawer: const LombaSideMenu(),
    );
  }
}

class AllUsersListItem extends StatelessWidget {
  final String id;
  final String username;
  final bool habilitado;
  const AllUsersListItem({
    Key? key,
    required this.id,
    required this.username,
    required this.habilitado
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allusersService = Provider.of<UserService>(context, listen: false);
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
            tooltip: 'Organizaciones del usuario',
            onPressed: () {},
            child:
                const Text('1', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            heroTag: null,
            tooltip: 'Desactivar al usuario',
            onPressed: () async {
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
              ).then((value) async {
                    if (value == 'Sí')
                      {
                        final List<dynamic>? respuesta = await allusersService.EnableDisable(id,!habilitado);

                        if ( !respuesta?[2] ){
                          print('segundo if error');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBarGenerator.getNotificationMessage(
                                'Conexión con el servidor no establecido'));
                        } else if ( respuesta?[0].statusCode == 200){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBarGenerator.getNotificationMessage(
                                'Se ha desactivado al usuario'));
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
            tooltip: 'Editar usuario',
            child: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .push(RouteAnimation.animatedTransition(UserEdit(user: id,)));
            },
          ),
        ],
      ),
    );
  }
}
