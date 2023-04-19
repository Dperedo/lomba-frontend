import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/validators.dart';
import 'package:lomba_frontend/data/models/orgauser_model.dart';
import 'package:lomba_frontend/presentation/orgas/bloc/orga_event.dart';
import 'package:lomba_frontend/presentation/orgas/bloc/orgauser_event.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../core/fakedata.dart';
import '../../../core/widgets/body_formatter.dart';
import '../../../core/widgets/scaffold_manager.dart';
import '../../../core/widgets/snackbar_notification.dart';
import '../../../domain/entities/orgauser.dart';
import '../../../domain/entities/user.dart';
import '../bloc/orga_bloc.dart';
import '../bloc/orga_state.dart';
import '../bloc/orgauser_bloc.dart';
import '../bloc/orgauser_cubit.dart';
import '../bloc/orgauser_state.dart';

///Página de organizaciones que inicia con la lista de organizaciones
///
///Incluye el detalle de cada organización donde es posible ver la lista
///de usuarios relacionados con la organización.
class OrgasPage extends StatelessWidget {
  OrgasPage({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final int _fixPageSize = 10;

//Ordenamiento
  final Map<String, String> listFields = <String, String>{
    "Email": "email",
    "Nombre": "name",
    "Usuario": "username"
  };

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrgaBloc, OrgaState>(
      listener: (context, state) {
        if (state is OrgaLoaded && state.message != "") {
          snackBarNotify(context, state.message, Icons.business_center);
        } else if (state is OrgaError && state.message != "") {
          snackBarNotify(context, state.message, Icons.cancel_outlined);
        }
      },
      child: BlocBuilder<OrgaBloc, OrgaState>(
        builder: (context, state) {
          return ScaffoldManager(
            title: _variableAppBar(context, state),
            floatingActionButton:
                (state is OrgaListLoaded || state is OrgaStart)
                    ? FloatingActionButton(
                        key: const ValueKey("btnAddOption"),
                        tooltip: 'Agregar Orga',
                        onPressed: () {
                          context.read<OrgaBloc>().add(OnOrgaPrepareForAdd());
                        },
                        child: const Icon(Icons.group_add))
                    : null,
            child: SingleChildScrollView(
                child: Center(
              child: Column(
                children: [
                  BodyFormatter(
                    child: _bodyOrgas(context, state),
                    screenWidth: MediaQuery.of(context).size.width,
                  )
                ],
              ),
            )),
          );
        },
      ),
    );
  }

  Widget _bodyOrgas(BuildContext context, OrgaState state) {
    final TextEditingController _orgaNameController = TextEditingController();
    final TextEditingController _codeController = TextEditingController();

    if (state is OrgaStart) {
      context.read<OrgaUserBloc>().add(const OnOrgaUserStarter());
      context.read<OrgaBloc>().add(const OnOrgaListLoad("", "", 1));
    }
    if (state is OrgaLoading) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.3,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (state is OrgaListLoaded) {
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.orgas.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        key: const ValueKey("btnText"),
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
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Estado: ${(state.orga.enabled ? 'Habilitado' : 'Deshabilitado')}")),
            ),
            const Divider(),
            Wrap(
              runSpacing: 12,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  key: const ValueKey("btnDeleteOption"),
                  label: const Text("Eliminar"),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => GestureDetector(
                              key: const ValueKey('btnGd'),
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
                              context.read<OrgaBloc>().add(
                                  OnOrgaDelete(state.orga.id, state.orga.name))
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
                                  state.orga.id,
                                  !state.orga.enabled,
                                  state.orga.name))
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
                    context.read<OrgaUserBloc>().add(OnOrgaUserListLoad(
                        '',
                        state.orga.id,
                        <String, int>{listFields.values.first: 1},
                        1,
                        10));
                  },
                ),
              ],
            ),
            const Divider(),
            Wrap(
              runSpacing: 12,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.add_moderator),
                  key: const ValueKey("btnAddOrgaUserOption"),
                  label: const Text("Asociar usuario"),
                  onPressed: () {
                    context.read<OrgaUserBloc>().add(
                        OnOrgaUserListUserNotInOrgaForAdd('', state.orga.id,
                            <String, int>{listFields.values.first: 1}, 1, 10));
                  },
                ),
                const VerticalDivider(),
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  key: const ValueKey("btnModifyOrga"),
                  label: const Text("Modificar orga"),
                  onPressed: () {
                    context
                        .read<OrgaBloc>()
                        .add(OnOrgaPrepareForEdit(state.orga));
                  },
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                ElevatedButton.icon(
                    key: const ValueKey("btnVolver"),
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
    if (state is OrgaAdding) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _orgaNameController,
                  key: const ValueKey("orgaName1"),
                  validator: (value) =>
                      Validators.validateUsername(value ?? ""),
                  decoration: const InputDecoration(
                    labelText: 'Orga Name',
                    icon: Icon(Icons.account_box),
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    context.read<OrgaBloc>().add(OnOrgaValidate(
                        _orgaNameController.text, _codeController.text, state));
                  },
                  controller: _codeController,
                  key: const ValueKey("code"),
                  validator: (value) => state.validateCode(value ?? ""),
                  decoration: const InputDecoration(
                    labelText: 'Code',
                    icon: Icon(Icons.account_box_outlined),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      key: const ValueKey("cancel1"),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            context
                                .read<OrgaBloc>()
                                .add(const OnOrgaListLoad("", "", 1));
                          },
                          icon: const Icon(Icons.cancel),
                          label: const Text('Cancel')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      key: const ValueKey("save1"),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            if (_key.currentState?.validate() == true) {
                              context.read<OrgaBloc>().add(OnOrgaAdd(
                                    _orgaNameController.text,
                                    _codeController.text,
                                    true,
                                  ));
                            }
                          },
                          icon: const Icon(Icons.save),
                          label: const Text('Guardar')),
                    ),
                  ],
                )
              ],
            )),
      );
    }
    if (state is OrgaEditing) {
      _orgaNameController.text = state.orga.name;
      _codeController.text = state.orga.code;
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _orgaNameController,
                  key: const ValueKey("orgaName"),
                  validator: (value) => Validators.validateName(value ?? ""),
                  decoration: const InputDecoration(
                    labelText: 'Orga Name',
                    icon: Icon(Icons.account_box),
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    context
                        .read<OrgaBloc>()
                        .add(OnOrgaValidateEdit(_codeController.text, state));
                  },
                  controller: _codeController,
                  key: const ValueKey("code"),
                  validator: (value) => state.validateCode(value ?? ""),
                  decoration: const InputDecoration(
                    labelText: 'Codigo',
                    icon: Icon(Icons.account_box_outlined),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      key: const ValueKey('cancelButton'),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            context
                                .read<OrgaBloc>()
                                .add(OnOrgaLoad(state.orga.id));
                          },
                          icon: const Icon(Icons.cancel),
                          label: const Text('Cancel')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      key: const ValueKey('saveButton'),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            if (_key.currentState?.validate() == true) {
                              context.read<OrgaBloc>().add(OnOrgaEdit(
                                  state.orga.id,
                                  _orgaNameController.text,
                                  _codeController.text,
                                  true));
                            }
                          },
                          icon: const Icon(Icons.save),
                          label: const Text('Guardar')),
                    ),
                  ],
                )
              ],
            )),
      );
    }

    return const SizedBox();
  }

  AppBar _variableAppBar(BuildContext context, OrgaState state) {
    if (state is OrgaLoaded) {
      return AppBar(
          title: const Text("Organización"),
          leading: IconButton(
            key: const ValueKey('btnOrganizacion'),
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
    return BlocProvider<OrgaUserDialogEditCubit>(
      create: (context) => OrgaUserDialogEditCubit(orgaUser),
      child: Dialog(
        child: Container(
          height: 600,
          width: 450,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child:
                BlocBuilder<OrgaUserDialogEditCubit, OrgaUserDialogEditState>(
                    builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(user.name,
                            style: const TextStyle(fontSize: 18))),
                    const VerticalDivider(),
                    Wrap(
                      runSpacing: 12,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Asociación habilitada: "),
                        Checkbox(
                            value: state.checks["enabled"],
                            onChanged: ((value) => {
                                  context
                                      .read<OrgaUserDialogEditCubit>()
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
                            key: const ValueKey("btnEliminarAsociacion"),
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
                            physics: const NeverScrollableScrollPhysics(),
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
                                            .read<OrgaUserDialogEditCubit>()
                                            .changeValue(
                                                fakeRoles[index]
                                                    .name
                                                    .toString(),
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
                            key: const ValueKey('btnGuardarAsoc'),
                            label: const Text("Guardar")),
                        const VerticalDivider(),
                        ElevatedButton.icon(
                            icon: const Icon(Icons.cancel),
                            onPressed: () {
                              Navigator.pop(context, null);
                            },
                            key: const ValueKey('btnCancelarAsoc'),
                            label: const Text("Cancelar"))
                      ],
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _showAddingOrgaUserDialog(
      BuildContext context, User user, String orgaId) {
    final orgaUser = OrgaUserModel(
        orgaId: orgaId,
        userId: user.id,
        roles: const <String>[],
        builtIn: false,
        enabled: true);

    return BlocProvider<OrgaUserDialogEditCubit>(
      create: (context) => OrgaUserDialogEditCubit(orgaUser),
      child: Dialog(
        child: Container(
          height: 400,
          width: 500,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child:
                BlocBuilder<OrgaUserDialogEditCubit, OrgaUserDialogEditState>(
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
                                    .read<OrgaUserDialogEditCubit>()
                                    .changeValue("enabled", value!)
                              }))
                    ],
                  ),
                  const VerticalDivider(),
                  SizedBox(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
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
                                          .read<OrgaUserDialogEditCubit>()
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
    context.read<OrgaUserBloc>().add(const OnOrgaUserStarter());

    return BlocListener<OrgaUserBloc, OrgaUserState>(
      listener: (context, state) {
        if (state is OrgaUserStart && state.message != "") {
          snackBarNotify(context, state.message, Icons.business_center);
        } else if (state is OrgaUserError && state.message != "") {
          snackBarNotify(context, state.message, Icons.cancel_outlined);
        }
      },
      child: BlocBuilder<OrgaUserBloc, OrgaUserState>(
        builder: (context, state) {
          if (state is OrgaUserLoading) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.3,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is OrgaUserListLoaded) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: TextFormField(
                              controller: _searchController,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                hintText: 'Buscar usuarios',
                                hintStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 18),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                context.read<OrgaUserBloc>().add(
                                    OnOrgaUserListLoad(
                                        _searchController.text,
                                        state.orgaId,
                                        <String, int>{
                                          listFields.values.first: 1
                                        },
                                        1,
                                        10));
                              },
                              icon: const Icon(Icons.search)),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            child: NumberPaginator(
                              initialPage: state.pageIndex - 1,
                              numberPages: state.totalPages,
                              contentBuilder: (index) => Expanded(
                                child: Center(
                                  child: Text(
                                      "Página: ${index + 1} de ${state.totalPages}"),
                                ),
                              ),
                              onPageChange: (int index) {
                                context.read<OrgaUserBloc>().add(
                                    OnOrgaUserListLoad(
                                        _searchController.text,
                                        state.orgaId,
                                        <String, int>{
                                          state.fieldsOrder.keys.first: 1
                                        },
                                        index + 1,
                                        _fixPageSize));
                              },
                            ),
                          ),
                          const VerticalDivider(),
                          const Text("Orden:"),
                          const VerticalDivider(),
                          _sortDropdownButtonUsersInOrga(
                              state, listFields, context)
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                          "${(state.searchText != "" ? "Buscando por \"${state.searchText}\", mostrando " : "Mostrando ")}${state.itemCount} registros de ${state.totalItems}."),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: TextButton(
                                    key: ValueKey(
                                        "btnTxtUser${state.users[index].id}"),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => GestureDetector(
                                              onTap: () =>
                                                  Navigator.pop(context),
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
                                                    as OrgaUserDialogEditState)
                                                .deleted) {
                                              //eliminar

                                              context.read<OrgaUserBloc>().add(
                                                  OnOrgaUserDelete(
                                                      state.orgaId,
                                                      state.users[index].id,
                                                      state.users[index]
                                                          .username));
                                            } else {
                                              //actualizar
                                              List<String> roles = [];
                                              bool enabled = (value!
                                                      as OrgaUserDialogEditState)
                                                  .checks["enabled"]!;
                                              Roles.toList().forEach((element) {
                                                if ((value!
                                                        as OrgaUserDialogEditState)
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
                                    },
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.switch_account),
                                              title: Text(
                                                state.users[index].name,
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                              subtitle: Text(
                                                  '${state.users[index].username} / ${state.users[index].email}',
                                                  style: const TextStyle(
                                                      fontSize: 12)),
                                            ),
                                          ],
                                        )))),
                            Icon(
                                (state.orgaUsers
                                            .where((element) =>
                                                element.userId ==
                                                    state.users[index].id &&
                                                element.orgaId == state.orgaId)
                                            .isNotEmpty
                                        ? state.orgaUsers
                                            .singleWhere((element) =>
                                                element.userId ==
                                                    state.users[index].id &&
                                                element.orgaId == state.orgaId)
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

          if (state is OrgaUserListUserNotInOrgaLoaded) {
            return Column(
              children: [
                const Text("Usuarios disponibles"),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: TextFormField(
                              controller: _searchController,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                hintText: 'Buscar usuarios',
                                hintStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 18),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                context.read<OrgaUserBloc>().add(
                                    OnOrgaUserListUserNotInOrgaForAdd(
                                        _searchController.text,
                                        state.orgaId,
                                        <String, int>{
                                          state.fieldsOrder.keys.first: 1
                                        },
                                        1,
                                        _fixPageSize));
                              },
                              icon: const Icon(Icons.search)),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            child: NumberPaginator(
                              initialPage: state.pageIndex - 1,
                              numberPages: state.totalPages,
                              contentBuilder: (index) => Expanded(
                                child: Center(
                                  child: Text(
                                      "Página: ${index + 1} de ${state.totalPages}"),
                                ),
                              ),
                              onPageChange: (int index) {
                                context.read<OrgaUserBloc>().add(
                                    OnOrgaUserListUserNotInOrgaForAdd(
                                        _searchController.text,
                                        state.orgaId,
                                        <String, int>{
                                          state.fieldsOrder.keys.first: 1
                                        },
                                        index + 1,
                                        _fixPageSize));
                              },
                            ),
                          ),
                          const VerticalDivider(),
                          const Text("Orden:"),
                          const VerticalDivider(),
                          _sortDropdownButtonUsersNotInOrga(
                              state, listFields, context)
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                          "${(state.searchText != "" ? "Buscando por \"${state.searchText}\", mostrando " : "Mostrando ")}${state.itemCount} registros de ${state.totalItems}."),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: TextButton(
                                    key: const ValueKey('txtBtnAccount'),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.switch_account),
                                              title: Text(
                                                state.users[index].name,
                                                style: const TextStyle(
                                                    fontSize: 18),
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
                                              onTap: () =>
                                                  Navigator.pop(context),
                                              child: _showAddingOrgaUserDialog(
                                                  context,
                                                  state.users[index],
                                                  state.orgaId))).then(
                                        (value) {
                                          if (value != null) {
                                            //actualizar
                                            List<String> roles = [];
                                            bool enabled = (value!
                                                    as OrgaUserDialogEditState)
                                                .checks["enabled"]!;
                                            Roles.toList().forEach((element) {
                                              if ((value!
                                                      as OrgaUserDialogEditState)
                                                  .checks[element]!) {
                                                roles.add(element);
                                              }
                                            });
                                            context.read<OrgaUserBloc>().add(
                                                OnOrgaUserAdd(
                                                    state.orgaId,
                                                    state.users[index].id,
                                                    roles,
                                                    enabled,
                                                    state.users[index]
                                                        .username));
                                          }
                                        },
                                      );
                                    })),
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
          return const SizedBox();
        },
      ),
    );
  }

  DropdownButton<String> _sortDropdownButtonUsersNotInOrga(
      OrgaUserListUserNotInOrgaLoaded state,
      Map<String, String> listFields,
      BuildContext context) {
    return DropdownButton(
      style: const TextStyle(fontSize: 14, color: Colors.black),
      value: state.fieldsOrder.keys.first,
      items: listFields.entries.map<DropdownMenuItem<String>>((field) {
        return DropdownMenuItem<String>(
          value: field.value,
          child: Text(field.key),
        );
      }).toList(),
      onChanged: (String? value) {
        context.read<OrgaUserBloc>().add(OnOrgaUserListUserNotInOrgaForAdd(
            state.searchText,
            state.orgaId,
            <String, int>{value!: 1},
            state.pageIndex,
            _fixPageSize));
      },
    );
  }

  DropdownButton<String> _sortDropdownButtonUsersInOrga(
      OrgaUserListLoaded state,
      Map<String, String> listFields,
      BuildContext context) {
    return DropdownButton(
      style: const TextStyle(fontSize: 14, color: Colors.black),
      value: state.fieldsOrder.keys.first,
      items: listFields.entries.map<DropdownMenuItem<String>>((field) {
        return DropdownMenuItem<String>(
          value: field.value,
          child: Text(field.key),
        );
      }).toList(),
      onChanged: (String? value) {
        context.read<OrgaUserBloc>().add(OnOrgaUserListLoad(
            state.searchText,
            state.orgaId,
            <String, int>{value!: 1},
            state.pageIndex,
            _fixPageSize));
      },
    );
  }
}
