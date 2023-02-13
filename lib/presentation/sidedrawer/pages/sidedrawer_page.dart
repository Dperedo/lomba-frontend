import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/presentation/home/bloc/home_event.dart';
import 'package:lomba_frontend/presentation/login/bloc/login_bloc.dart';
import 'package:lomba_frontend/presentation/login/bloc/login_event.dart';
import 'package:lomba_frontend/presentation/sidedrawer/bloc/sidedrawer_event.dart';

import '../../nav/bloc/nav_bloc.dart';
import '../../nav/bloc/nav_event.dart';
import '../../nav/bloc/nav_state.dart';
import '../../home/bloc/home_bloc.dart';
import '../../../domain/entities/orga.dart';
import '../bloc/sidedrawer_bloc.dart';
import '../bloc/sidedrawer_state.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({
    Key? key,
  }) : super(key: key);

  void _handleItemClick(BuildContext context, NavItem item) {
    BlocProvider.of<NavBloc>(context).add(NavigateTo(item));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<SideDrawerBloc, SideDrawerState>(
        builder: (context, state) {
          if (state is SideDrawerEmpty) {
            context.read<SideDrawerBloc>().add(const OnSideDrawerLoading());

            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SideDrawerReady) {
            List<Widget> childrenOptionsList = <Widget>[];

            childrenOptionsList.add(const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
              child: Text('Opciones'),
            ));

            if (state.orgas.isNotEmpty) {
              if (state.orgas.length > 1) {
                String firstOrga = state.orgaId;
                if (firstOrga == '') {
                  firstOrga = state.orgas.first.id;
                }
                childrenOptionsList.add(Padding(
                  padding: const EdgeInsets.only(left: 17.0),
                  child: Row(
                    children: [
                      const Icon(Icons.business_center),
                      DropdownButton(
                          value: state.orgas
                              .firstWhere((element) => element.id == firstOrga)
                              .id,
                          items: state.orgas
                              .map<DropdownMenuItem<String>>((Orga orga) {
                            return DropdownMenuItem<String>(
                              value: orga.id,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Text(orga.name),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value.toString() != firstOrga) {
                              showDialog(
                                  context: context,
                                  builder: (context) => GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: AlertDialog(
                                          title: const Text(
                                              '¿Desea cambiar de Organización?'),
                                          actions: <Widget>[
                                            TextButton(
                                              key: const ValueKey(
                                                  "btnChangeOrga"),
                                              child: const Text('Cambiar'),
                                              onPressed: () {
                                                Navigator.pop(context, true);
                                              },
                                            ),
                                            TextButton(
                                              key: const ValueKey("btnCancel"),
                                              child: const Text('Cancelar'),
                                              onPressed: () {
                                                Navigator.pop(context, false);
                                              },
                                            ),
                                          ],
                                        ),
                                      )).then((resp) => {
                                    if (resp)
                                      {
                                        firstOrga = value.toString(),
                                        context.read<SideDrawerBloc>().add(
                                            OnSideDrawerChangeOrga(
                                                value.toString()))
                                      }
                                  });
                            }
                          }),
                    ],
                  ),
                ));
              } else {
                //mostrar solo el texto nombre de la orga
                if (state.orgas[0].name != 'System' &&
                    state.orgas[0].name != 'Default') {
                  childrenOptionsList.add(ListTile(
                      leading: const Icon(Icons.business_center),
                      title: Text(state.orgas[0].name)));
                }
              }
            }

            if (state.opts.contains(SideDrawerUserOptions.optHome)) {
              childrenOptionsList.add(ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  _handleItemClick(context, NavItem.pageHome);
                },
              ));
            }

            if (state.opts.contains(SideDrawerUserOptions.optLogIn)) {
              childrenOptionsList.add(ListTile(
                leading: const Icon(Icons.login_outlined),
                title: const Text('Iniciar sesión'),
                onTap: () {
                  _handleItemClick(context, NavItem.pageLogin);
                },
              ));
            }

            if (state.opts.contains(SideDrawerUserOptions.optProfile)) {
              childrenOptionsList.add(ListTile(
                leading: const Icon(Icons.account_box),
                title: const Text('Perfil'),
                onTap: () {
                  _handleItemClick(context, NavItem.pageProfile);
                },
              ));
            }

            if (state.opts.contains(SideDrawerUserOptions.optOrgas)) {
              childrenOptionsList.add(ListTile(
                leading: const Icon(Icons.business_center),
                title: const Text('Organizaciones'),
                onTap: () {
                  _handleItemClick(context, NavItem.pageOrgas);
                },
              ));
            }

            if (state.opts.contains(SideDrawerUserOptions.optUsers)) {
              childrenOptionsList.add(ListTile(
                leading: const Icon(Icons.people_outline),
                title: const Text('Usuarios'),
                onTap: () {
                  _handleItemClick(context, NavItem.pageUsers);
                },
              ));
            }

            if (state.opts.contains(SideDrawerUserOptions.optRoles)) {
              childrenOptionsList.add(ListTile(
                leading: const Icon(Icons.key_outlined),
                title: const Text('Roles'),
                onTap: () {
                  _handleItemClick(context, NavItem.pageRoles);
                },
              ));
            }

            if (state.opts.contains(SideDrawerUserOptions.optAddContent)) {
              childrenOptionsList.add(ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Subir contenido'),
                onTap: () {
                  _handleItemClick(context, NavItem.pageAddContent);
                },
              ));
            }

            if (state.opts.contains(SideDrawerUserOptions.optUploaded)) {
              childrenOptionsList.add(ListTile(
                leading: const Icon(Icons.upload),
                title: const Text('Subidos'),
                onTap: () {
                  _handleItemClick(context, NavItem.pageUploaded);
                },
              ));
            }

            if (state.opts.contains(SideDrawerUserOptions.optViewed)) {
              childrenOptionsList.add(ListTile(
                leading: const Icon(Icons.view_sidebar),
                title: const Text('Votados'),
                onTap: () {
                  _handleItemClick(context, NavItem.pageVoted);
                },
              ));
            }

            if (state.opts.contains(SideDrawerUserOptions.optPopular)) {
              childrenOptionsList.add(ListTile(
                leading: const Icon(Icons.star),
                title: const Text('Populares'),
                onTap: () {
                  _handleItemClick(context, NavItem.pagePopular);
                },
              ));
            }

            if (state.opts.contains(SideDrawerUserOptions.optToBeApproved)) {
              childrenOptionsList.add(ListTile(
                leading: const Icon(Icons.pending),
                title: const Text('Por Aprobar'),
                onTap: () {
                  _handleItemClick(context, NavItem.pageToBeApproved);
                },
              ));
            }

            if (state.opts.contains(SideDrawerUserOptions.optApproved)) {
              childrenOptionsList.add(ListTile(
                leading: const Icon(Icons.approval),
                title: const Text('Aprobados'),
                onTap: () {
                  _handleItemClick(context, NavItem.pageApproved);
                },
              ));
            }

            if (state.opts.contains(SideDrawerUserOptions.optRejected)) {
              childrenOptionsList.add(ListTile(
                leading: const Icon(Icons.stop),
                title: const Text('Rechazados'),
                onTap: () {
                  _handleItemClick(context, NavItem.pageRejected);
                },
              ));
            }

            if (state.opts.contains(SideDrawerUserOptions.optDemoList)) {
              childrenOptionsList.add(ListTile(
                leading: const Icon(Icons.star),
                title: const Text('Lista demo'),
                onTap: () {
                  _handleItemClick(context, NavItem.pageDemoList);
                },
              ));
            }

            if (state.opts.contains(SideDrawerUserOptions.optLogOff)) {
              childrenOptionsList.add(ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Cerrar sesión'),
                onTap: () {
                  context.read<SideDrawerBloc>().add(OnSideDrawerLogOff());
                  context.read<HomeBloc>().add(OnRestartHome());
                  context.read<LoginBloc>().add(OnRestartLogin());

                  _handleItemClick(context, NavItem.pageHome);
                },
              ));
            }

            Widget listView = ListView(
              padding: EdgeInsets.zero,
              children: childrenOptionsList,
            );

            return listView;
          }
          return const SizedBox();
        },
      ),
    );
  }
}
