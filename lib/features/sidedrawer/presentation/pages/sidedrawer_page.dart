import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/features/home/presentation/bloc/home_event.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_bloc.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_event.dart';
import 'package:lomba_frontend/features/sidedrawer/presentation/bloc/sidedrawer_event.dart';

import '../../../../core/presentation/bloc/nav_bloc.dart';
import '../../../../core/presentation/bloc/nav_event.dart';
import '../../../../core/presentation/bloc/nav_state.dart';
import '../../../home/presentation/bloc/home_bloc.dart';
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
                color: Colors.blue,
              ),
              child: Text('Opciones'),
            ));

            if (state.opts.contains(SideDrawerUserOptions.Home)) {
              childrenOptionsList.add(ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  _handleItemClick(context, NavItem.page_home);
                },
              ));
            }

            if (state.opts.contains(SideDrawerUserOptions.LogIn)) {
              childrenOptionsList.add(ListTile(
                leading: const Icon(Icons.login_outlined),
                title: const Text('Iniciar sesión'),
                onTap: () {
                  _handleItemClick(context, NavItem.page_login);
                },
              ));
            }

            if (state.opts.contains(SideDrawerUserOptions.Profile)) {
              childrenOptionsList.add(ListTile(
                leading: const Icon(Icons.account_box),
                title: const Text('Perfil'),
                onTap: () {
                  _handleItemClick(context, NavItem.page_home);
                },
              ));
            }

            if (state.opts.contains(SideDrawerUserOptions.Orgas)) {
              childrenOptionsList.add(ListTile(
                leading: const Icon(Icons.business_center),
                title: const Text('Organizaciones'),
                onTap: () {
                  _handleItemClick(context, NavItem.page_orgas);
                },
              ));
            }

            if (state.opts.contains(SideDrawerUserOptions.Users)) {
              childrenOptionsList.add(ListTile(
                leading: const Icon(Icons.people_outline),
                title: const Text('Usuarios'),
                onTap: () {
                  _handleItemClick(context, NavItem.page_home);
                },
              ));
            }

            if (state.opts.contains(SideDrawerUserOptions.Roles)) {
              childrenOptionsList.add(ListTile(
                leading: const Icon(Icons.key_outlined),
                title: const Text('Roles'),
                onTap: () {
                  _handleItemClick(context, NavItem.page_home);
                },
              ));
            }

            if (state.opts.contains(SideDrawerUserOptions.LogOff)) {
              childrenOptionsList.add(ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Cerrar sesión'),
                onTap: () {
                  context.read<SideDrawerBloc>().add(OnSideDrawerLogOff());
                  context.read<HomeBloc>().add(OnRestartHome());
                  context.read<LoginBloc>().add(OnRestartLogin());

                  _handleItemClick(context, NavItem.page_home);
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
