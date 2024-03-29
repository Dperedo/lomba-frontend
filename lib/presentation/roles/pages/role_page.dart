import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/presentation/roles/bloc/role_event.dart';
import 'package:lomba_frontend/presentation/sidedrawer/pages/sidedrawer_page.dart';

import '../bloc/role_bloc.dart';
import '../bloc/role_state.dart';

class RolesPage extends StatelessWidget {
  const RolesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoleBloc, RoleState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _variableAppBar(context, state),
          body: SingleChildScrollView(
              child: Column(
            children: [_bodyRoles(context, state)],
          )),
          drawer: const SideDrawer(),
        );
      },
    );
  }

  Widget _bodyRoles(BuildContext context, RoleState state) {
    if (state is RoleStart) {
      context.read<RoleBloc>().add(const OnRoleListLoad());
    }
    if (state is RoleLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is RoleError) {
      return Center(child: Text(state.message));
    }
    if (state is RoleListLoaded) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: state.roles.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: TextButton(
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.key_outlined),
                                    title: Text(
                                      state.roles[index].name,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              )),
                          onPressed: () {
                            context
                                .read<RoleBloc>()
                                .add(OnRoleLoad(state.roles[index].name));
                          })),
                  Icon(
                      state.roles[index].enabled
                          ? Icons.toggle_on
                          : Icons.toggle_off_outlined,
                      size: 40)
                ],
              ),
              const Divider()
            ],
          );
        },
      );
    }

    if (state is RoleLoaded) {
      return Column(
        children: [
          Text(state.role.name),
          const Divider(),
          Text("Rolename: ${state.role.name}"),
          const Divider(),
          Text("Estado: ${state.role.enabled}"),
          const Divider(),
          Row(
            children: [
              const VerticalDivider(),
              ElevatedButton(
                key: const ValueKey("btnEnableOption"),
                child:
                    Text((state.role.enabled ? "Deshabilitar" : "Habilitar")),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: AlertDialog(
                              title: Text(
                                  '¿Desea ${(state.role.enabled ? "deshabilitar" : "habilitar")} el usuario'),
                              content: const Text(
                                  'Puede cambiar después su elección'),
                              actions: <Widget>[
                                TextButton(
                                  key: const ValueKey("btnConfirmEnable"),
                                  child: Text((state.role.enabled
                                      ? "Deshabilitar"
                                      : "Habilitar")),
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                ),
                                TextButton(
                                  key: const ValueKey("btnCancelEnable"),
                                  child: const Text('Cancelar'),
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                ),
                              ],
                            ),
                          )).then((value) => {
                        if (value)
                          {
                            context.read<RoleBloc>().add(OnRoleEnable(
                                state.role.name, !state.role.enabled))
                          }
                      });
                },
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              ElevatedButton(
                child: const Text("Volver"),
                onPressed: () {
                  context.read<RoleBloc>().add(const OnRoleListLoad());
                },
              )
            ],
          ),
          const Divider(),
        ],
      );
    }

    return const SizedBox();
  }

  AppBar _variableAppBar(BuildContext context, RoleState state) {
    if (state is RoleLoaded) {
      return AppBar(
          title: const Text("Rol"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.read<RoleBloc>().add(const OnRoleListLoad());
            },
          ));
    }

    return AppBar(title: const Text("Roles"));
  }
}
