import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/features/users/presentation/bloc/user_event.dart';
import 'package:lomba_frontend/features/sidedrawer/presentation/pages/sidedrawer_page.dart';

import '../bloc/user_bloc.dart';
import '../bloc/user_state.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _variableAppBar(context, state),
          body: SingleChildScrollView(
              child: Column(
            children: [_bodyUsers(context, state)],
          )),
          drawer: const SideDrawer(),
        );
      },
    );
  }

  Widget _bodyUsers(BuildContext context, UserState state) {
    if (state is UserStart) {
      context.read<UserBloc>().add(const OnUserListLoad("", "", "", 1));
    }
    if (state is UserLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is UserListLoaded) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: state.users.length,
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
                                    leading: const Icon(Icons.switch_account),
                                    title: Text(
                                      state.users[index].name,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    subtitle: Text(
                                        '${state.users[index].username} / ${state.users[index].email}',
                                        style: const TextStyle(fontSize: 12)),
                                  ),
                                ],
                              )),
                          onPressed: () {
                            context
                                .read<UserBloc>()
                                .add(OnUserLoad(state.users[index].id));
                          })),
                  Icon(
                      state.users[index].enabled
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

    if (state is UserLoaded) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.switch_account_rounded),
              title:
                  Text(state.user.name, style: const TextStyle(fontSize: 22)),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Username: ${state.user.username}",
                      style: const TextStyle(fontSize: 14))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Email: ${state.user.email}",
                      style: const TextStyle(fontSize: 14))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Estado: ${(state.user.enabled ? 'Habilitado' : 'Deshabilitado')}")),
            ),
            const Divider(),
            Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  key: const ValueKey("btnDeleteOption"),
                  label: const Text("Eliminar"),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: AlertDialog(
                                title:
                                    const Text('¿Desea eliminar el usuario?'),
                                content:
                                    const Text('La eliminación es permanente'),
                                actions: <Widget>[
                                  TextButton(
                                    key: const ValueKey("btnConfirmDelete"),
                                    child: const Text('Eliminar'),
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                  ),
                                  TextButton(
                                    key: const ValueKey("btnCancelDelete"),
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
                              context
                                  .read<UserBloc>()
                                  .add(OnUserDelete(state.user.id))
                            }
                        });
                  },
                ),
                const VerticalDivider(),
                ElevatedButton.icon(
                  icon: Icon(!state.user.enabled
                      ? Icons.toggle_on
                      : Icons.toggle_off_outlined),
                  key: const ValueKey("btnEnableOption"),
                  label:
                      Text((state.user.enabled ? "Deshabilitar" : "Habilitar")),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: AlertDialog(
                                title: Text(
                                    '¿Desea ${(state.user.enabled ? "deshabilitar" : "habilitar")} el usuario?'),
                                content: const Text(
                                    'Esta acción afecta el acceso del usuario al sistema'),
                                actions: <Widget>[
                                  TextButton(
                                    key: const ValueKey("btnConfirmEnable"),
                                    child: Text((state.user.enabled
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
                              context.read<UserBloc>().add(OnUserEnable(
                                  state.user.id, !state.user.enabled))
                            }
                        });
                  },
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      context
                          .read<UserBloc>()
                          .add(const OnUserListLoad("", "", "", 1));
                    },
                    label: const Text("Volver"))
              ],
            ),
            const Divider(),
          ],
        ),
      );
    }

    return const SizedBox();
  }

  AppBar _variableAppBar(BuildContext context, UserState state) {
    if (state is UserLoaded) {
      return AppBar(
          title: const Text("Usuario"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.read<UserBloc>().add(const OnUserListLoad("", "", "", 1));
            },
          ));
    }

    return AppBar(title: const Text("Usuarios"));
  }
}
