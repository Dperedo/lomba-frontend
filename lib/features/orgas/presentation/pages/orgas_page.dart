import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/features/orgas/presentation/bloc/orga_event.dart';
import 'package:lomba_frontend/features/orgas/presentation/bloc/orgauser_event.dart';
import 'package:lomba_frontend/features/sidedrawer/presentation/pages/sidedrawer_page.dart';

import '../../../../core/fakedata.dart';
import '../../../users/domain/entities/user.dart';
import '../../domain/entities/orgauser.dart';
import '../bloc/orga_bloc.dart';
import '../bloc/orga_state.dart';
import '../bloc/orgauser_bloc.dart';
import '../bloc/orgauser_checkboxes_cubit.dart';
import '../bloc/orgauser_state.dart';

///Página de organizaciones que inicia con la lista de organizaciones
///
///Incluye el detalle de cada organización donde es posible ver la lista
///de usuarios relacionados con la organización.
class OrgasPage extends StatelessWidget {
  const OrgasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrgaBloc, OrgaState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _variableAppBar(context, state),
          body: SingleChildScrollView(
              child: Column(
            children: [_bodyOrgas(context, state)],
          )),
          drawer: const SideDrawer(),
        );
      },
    );
  }

  Widget _bodyOrgas(BuildContext context, OrgaState state) {
    if (state is OrgaStart) {
      context.read<OrgaBloc>().add(const OnOrgaListLoad("", "", 1));
    }
    if (state is OrgaLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is OrgaListLoaded) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: state.orgas.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(children: [
                                ListTile(
                                  leading: const Icon(Icons.business_center),
                                  title: Text(state.orgas[index].name,
                                      style: const TextStyle(fontSize: 18)),
                                  subtitle: Text(state.orgas[index].code,
                                      style: const TextStyle(fontSize: 12)),
                                )
                              ]),
                            ),
                            onPressed: () {
                              context
                                  .read<OrgaBloc>()
                                  .add(OnOrgaLoad(state.orgas[index].id));
                            })),
                    Icon(
                        state.orgas[index].enabled
                            ? Icons.toggle_on
                            : Icons.toggle_off_outlined,
                        size: 40)
                  ],
                ),
                const Divider()
              ],
            );
          });
    }

    if (state is OrgaLoaded) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.business_center),
              title:
                  Text(state.orga.name, style: const TextStyle(fontSize: 22)),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Código: ${state.orga.code}",
                      style: const TextStyle(fontSize: 14))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Estado: ${(state.orga.enabled ? 'Habilitado' : 'Deshabilitado')}")),
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
                                title: const Text(
                                    '¿Desea eliminar la organización?'),
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
                                  .read<OrgaBloc>()
                                  .add(OnOrgaDelete(state.orga.id))
                            }
                        });
                  },
                ),
                const VerticalDivider(),
                ElevatedButton.icon(
                  icon: Icon(!state.orga.enabled
                      ? Icons.toggle_on
                      : Icons.toggle_off_outlined),
                  key: const ValueKey("btnEnableOption"),
                  label:
                      Text((state.orga.enabled ? "Deshabilitar" : "Habilitar")),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: AlertDialog(
                                title: Text(
                                    '¿Desea ${(state.orga.enabled ? "deshabilitar" : "habilitar")} la organización?'),
                                content: const Text(
                                    'Esta acción afecta el acceso de los usuarios al sistema'),
                                actions: <Widget>[
                                  TextButton(
                                    key: const ValueKey("btnConfirmEnable"),
                                    child: Text((state.orga.enabled
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
                              context.read<OrgaBloc>().add(OnOrgaEnable(
                                  state.orga.id, !state.orga.enabled))
                            }
                        });
                  },
                ),
                const VerticalDivider(),
                ElevatedButton.icon(
                  icon: const Icon(Icons.switch_account_rounded),
                  key: const ValueKey("btnViewUsersOption"),
                  label: const Text("Ver usuarios"),
                  onPressed: () {
                    context
                        .read<OrgaUserBloc>()
                        .add(OnOrgaUserListLoad(state.orga.id));
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
                          .read<OrgaBloc>()
                          .add(const OnOrgaListLoad("", "", 1));
                    },
                    label: const Text("Volver"))
              ],
            ),
            const Divider(),
            _orgaUserList(context)
          ],
        ),
      );
    }

    return const SizedBox();
  }

  AppBar _variableAppBar(BuildContext context, OrgaState state) {
    if (state is OrgaLoaded) {
      return AppBar(
          title: const Text("Organización"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.read<OrgaBloc>().add(const OnOrgaListLoad("", "", 1));
            },
          ));
    }

    return AppBar(title: const Text("Organizaciones"));
  }

  Widget _showEditingOrgaUserDialog(
      BuildContext context, OrgaUser orgaUser, User user) {
    return BlocProvider<OrgaUserCheckBoxesCubit>(
      create: (context) => OrgaUserCheckBoxesCubit(orgaUser),
      child: Dialog(
        child: Container(
          height: 400,
          width: 500,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child:
                BlocBuilder<OrgaUserCheckBoxesCubit, OrgaUserCheckBoxesState>(
                    builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(user.name,
                          style: const TextStyle(fontSize: 18))),
                  const VerticalDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Asociación habilitada: "),
                      Checkbox(
                          value: state.checks["enabled"],
                          onChanged: ((value) => {
                                context
                                    .read<OrgaUserCheckBoxesCubit>()
                                    .changeValue("enabled", value!)
                              })),
                      ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: AlertDialog(
                                        title: const Text(
                                            '¿Desea eliminar la asociación?'),
                                        content: const Text(
                                            'Esta acción afecta el acceso de los usuarios al sistema'),
                                        actions: <Widget>[
                                          TextButton(
                                            key: const ValueKey(
                                                "btnConfirmDeleteOrgaUser"),
                                            child: const Text("Eliminar"),
                                            onPressed: () {
                                              Navigator.pop(context, true);
                                            },
                                          ),
                                          TextButton(
                                            key: const ValueKey(
                                                "btnCancelDeleteOrgaUser"),
                                            child: const Text('Cancelar'),
                                            onPressed: () {
                                              Navigator.pop(context, false);
                                            },
                                          ),
                                        ],
                                      ),
                                    )).then((value) {
                              if (value) {
                                state.deleted = true;
                                Navigator.pop(context, state);
                              }
                            });
                          },
                          icon: const Icon(Icons.delete),
                          label: const Text("Eliminar asociación"))
                    ],
                  ),
                  const VerticalDivider(),
                  SizedBox(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: fakeRoles.length,
                          itemBuilder: (context, index) {
                            return CheckboxListTile(
                                title: Text(
                                  fakeRoles[index].name,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                value: state
                                    .checks[fakeRoles[index].name.toString()],
                                onChanged: ((value) => {
                                      context
                                          .read<OrgaUserCheckBoxesCubit>()
                                          .changeValue(
                                              fakeRoles[index].name.toString(),
                                              value!)
                                    }));
                          }),
                    ),
                  ),
                  const VerticalDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                          icon: const Icon(Icons.save),
                          onPressed: () {
                            Navigator.pop(context, state);
                          },
                          label: const Text("Guardar")),
                      const VerticalDivider(),
                      ElevatedButton.icon(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            Navigator.pop(context, null);
                          },
                          label: const Text("Cancelar"))
                    ],
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _orgaUserList(BuildContext context) {
    return BlocBuilder<OrgaUserBloc, OrgaUserState>(
      builder: (context, state) {
        if (state is OrgaUserLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is OrgaUserListLoaded) {
          return Column(
            children: [
              ListView.builder(
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
                                            leading: const Icon(
                                                Icons.switch_account),
                                            title: Text(
                                              state.users[index].name,
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                            subtitle: Text(
                                                '${state.users[index].username} / ${state.users[index].email}',
                                                style: const TextStyle(
                                                    fontSize: 12)),
                                          ),
                                        ],
                                      )),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => GestureDetector(
                                            onTap: () => Navigator.pop(context),
                                            child: _showEditingOrgaUserDialog(
                                                context,
                                                state.orgaUsers
                                                    .where((element) =>
                                                        element.userId ==
                                                        state.users[index].id)
                                                    .first,
                                                state.users[index]))).then(
                                      (value) {
                                        if (value != null) {
                                          if ((value!
                                                  as OrgaUserCheckBoxesState)
                                              .deleted) {
                                            //eliminar

                                            context.read<OrgaUserBloc>().add(
                                                OnOrgaUserDelete(state.orgaId,
                                                    state.users[index].id));
                                          } else {
                                            //actualizar
                                            List<String> roles = [];
                                            bool enabled = (value!
                                                    as OrgaUserCheckBoxesState)
                                                .checks["enabled"]!;
                                            Roles.toList().forEach((element) {
                                              if ((value!
                                                      as OrgaUserCheckBoxesState)
                                                  .checks[element]!) {
                                                roles.add(element);
                                              }
                                            });
                                            context.read<OrgaUserBloc>().add(
                                                OnOrgaUserEdit(
                                                    state.orgaId,
                                                    state.users[index].id,
                                                    roles,
                                                    enabled));
                                          }
                                        }
                                      },
                                    );
                                    /*
                                      context
                                          .read<OrgaUserBloc>()
                                          .add(OnOrgaUserPrepareForEdit(
                                            state.orgaId,
                                            state.users[index].id,
                                          ));
                                          */
                                  })),
                          Icon(
                              (state.orgaUsers
                                          .where((element) =>
                                              element.userId ==
                                              state.users[index].id)
                                          .isNotEmpty
                                      ? state.orgaUsers
                                          .singleWhere((element) =>
                                              element.userId ==
                                              state.users[index].id)
                                          .enabled
                                      : false)
                                  ? Icons.toggle_on
                                  : Icons.toggle_off_outlined,
                              size: 40)
                        ],
                      ),
                      const Divider()
                    ],
                  );
                },
              )
            ],
          );
        }

        if (state is OrgaUserEditing) {
          return Column(
            children: [
              Row(
                children: [
                  const Text("Asociación habilitada: "),
                  Checkbox(
                      value: state.orgaUser.enabled,
                      onChanged: ((value) => {value = value})),
                  ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                      label: const Text("Eliminar asociación"))
                ],
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: fakeRoles.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                        title: Text(
                          fakeRoles[index].name,
                          style: const TextStyle(fontSize: 12),
                        ),
                        value: state.orgaUser.roles
                            .contains(fakeRoles[index].name.toString()),
                        onChanged: ((value) => {}));
                  }),
              Center(
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Row(
                          children: [
                            ElevatedButton.icon(
                                icon: const Icon(Icons.save),
                                onPressed: () {},
                                label: const Text("Guardar")),
                            const VerticalDivider(),
                            ElevatedButton.icon(
                                icon: const Icon(Icons.cancel),
                                onPressed: () {},
                                label: const Text("Cancelar"))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}
