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
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                          child: Center(
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              child: Center(
                                child: Text(
                                  state.users[index].name,
                                ),
                              ),
                              onPressed: () {
                                context
                                    .read<UserBloc>()
                                    .add(OnUserLoad(state.users[index].id));
                              },
                            )),
                      ))
                    ],
                  )),
              const Divider()
            ],
          );
        },
      );
    }

    if (state is UserLoaded) {
      return Column(
        children: [
          Text(state.user.name),
          const Divider(),
          Text("Username: ${state.user.username}"),
          const Divider(),
          Text("Email: ${state.user.email}"),
          const Divider(),
          Text("Estado: ${state.user.enabled}"),
          const Divider(),
          Row(
            children: [
              ElevatedButton(
                key: const ValueKey("btnDeleteOption"),
                child: const Text("Eliminar"),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: AlertDialog(
                              title: const Text('¿Desea eliminar el usuario'),
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
              ElevatedButton(
                key: const ValueKey("btnEnableOption"),
                child:
                    Text((state.user.enabled ? "Deshabilitar" : "Habilitar")),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: AlertDialog(
                              title: Text(
                                  '¿Desea ${(state.user.enabled ? "deshabilitar" : "habilitar")} el usuario'),
                              content: const Text(
                                  'Puede cambiar después su elección'),
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
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<UserBloc>()
                        .add(const OnUserListLoad("", "", "", 1));
                  },
                  child: const Text("Volver"))
            ],
          ),
          const Divider(),
        ],
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
