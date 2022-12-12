import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/features/home/presentation/pages/home_page.dart';
import 'package:lomba_frontend/features/login/presentation/pages/login_page.dart';

import '../../../../core/presentation/bloc/nav_bloc.dart';
import '../../../../core/presentation/bloc/nav_event.dart';
import '../../../../core/presentation/bloc/nav_state.dart';
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
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          BlocBuilder<SideDrawerBloc, SideDrawerState>(
              builder: (context, state) {
            return const Text('Organizaciones');
          }),
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Opciones'),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              _handleItemClick(context, NavItem.page_home);
            },
          ),
          ListTile(
            leading: const Icon(Icons.business_center),
            title: const Text('Organizaciones'),
            onTap: () {
              _handleItemClick(context, NavItem.page_orgas);
            },
          ),
          ListTile(
            leading: const Icon(Icons.people_outline),
            title: const Text('Usuarios'),
            onTap: () {
              _handleItemClick(context, NavItem.page_home);
            },
          ),
          ListTile(
            leading: const Icon(Icons.key_outlined),
            title: const Text('Roles'),
            onTap: () {
              _handleItemClick(context, NavItem.page_home);
            },
          ),
          ListTile(
            leading: const Icon(Icons.login_outlined),
            title: const Text('Iniciar sesión'),
            onTap: () {
              _handleItemClick(context, NavItem.page_login);
            },
          ),
        ],
      ),
    );
  }
}
