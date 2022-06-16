import 'package:flutter/material.dart';
import 'package:front_lomba/helpers/snackbars.dart';
import 'package:front_lomba/widgets/lomba_appbar.dart';
import 'package:front_lomba/widgets/lomba_dialog_notyes.dart';
import 'package:front_lomba/widgets/lomba_filterlistpage.dart';
import 'package:front_lomba/widgets/lomba_sidemenu.dart';
import 'package:front_lomba/widgets/lomba_titlepage.dart';
import 'package:provider/provider.dart';
import 'package:front_lomba/providers/theme_provider.dart';
import 'package:front_lomba/services/permission_service.dart';

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
  build(BuildContext context) {
    final permiService = Provider.of<PermissionsService>(context, listen: false);
    return Scaffold(
      appBar: LombaAppBar(title: title),
      body: Column(
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
                                  PermissionListItem(
                                    permission: ps?[index]["name"],
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
    //);
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
                        final bool respuesta = await permiService.EnableDisable(permission,!habilitado);
                        //consumir servicio de PermissionService
                        //para habilitar o deshabilitar el permiso
                        if (respuesta == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBarGenerator.getNotificationMessage(
                                'Se ha desactivado el permiso'));
                                }
                      }
                  }
                );
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
