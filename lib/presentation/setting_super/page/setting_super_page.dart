import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/widgets/body_formatter.dart';
import 'package:lomba_frontend/core/widgets/scaffold_manager.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/snackbar_notification.dart';
import '../../../domain/entities/orga.dart';
import '../../../domain/entities/role.dart';
import '../../../domain/entities/workflow/flow.dart' as flw;
import '../bloc/setting_super_bloc.dart';
import '../bloc/setting_super_event.dart';
import '../bloc/setting_super_state.dart';

///Página con el perfil del usuario
///
///La página es sólo para usuarios con sesión activa.
///Se deberían indicar aquí datos personales, contraseña, foto y demás
///cosas del usuario.
class SettingSuperPage extends StatelessWidget {
  const SettingSuperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingSuperBloc, SettingSuperState>(builder: (context, state) {
      return BlocListener<SettingSuperBloc, SettingSuperState>(
        listener: (context, state) {
          if (state is SettingSuperError && state.message != "") {
            snackBarNotify(context, state.message, Icons.cancel_outlined);
          } else if (state is SettingSuperStart && state.message != "") {
            snackBarNotify(context, state.message, Icons.account_circle);
          }
        },
        child: ScaffoldManager(
          title: AppBar(),//_variableAppBar(context, state),
          child: SingleChildScrollView(
              child: Center(
                  child: BodyFormatter(
            screenWidth: MediaQuery.of(context).size.width,
            child: _bodySettingSuper(context, state),
          ))),
        ),
      );
    });
  }

  /*AppBar _variableAppBar(BuildContext context, SettingSuperState state) {
    if (state is SettingSuperEditing) {
      return AppBar(
          title: const Text("Editando Perfil"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.read<SettingSuperBloc>().add(OnSettingSuperStarter());
            },
          ));
    }

    return AppBar(title: const Text("Perfil"));
  }*/

  Widget _bodySettingSuper(BuildContext context, SettingSuperState state) {

    if (state is SettingSuperStart) {
      context.read<SettingSuperBloc>().add(const OnSettingSuperLoad());
    }
    if (state is SettingSuperLoading) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.3,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (state is SettingSuperLoaded) {
      return Center(
        child: Column(
          children: [
            SizedBox(
              width: 300,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const Text("Organización:"),
                      const VerticalDivider(),
                      DropdownButton(
                        value: state.listOrgas.firstWhere((e) => e.id == state.orgaId).id,
                        hint: const Text('Seleccionar'),
                        items: state.listOrgas.map<DropdownMenuItem<String>>((Orga orga) {
                          return DropdownMenuItem<String>(
                            value: orga.id,
                            child: Text(orga.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if(value.toString() != state.orgaId) {
                          context.read<SettingSuperBloc>().add(
                              OnSettingSuperEdit(
                                  value.toString(),
                                  SettingCodes.defaultOrgaForUserRegister));
                          }
                        }
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 300,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const Text("Flujo:"),
                      const VerticalDivider(),
                      DropdownButton(
                        value: state.listFlows.firstWhere((e) => e.id == state.flowId).id,
                        hint: const Text('Seleccionar'),
                        items: state.listFlows.map<DropdownMenuItem<String>>((flw.Flow flow) {
                          return DropdownMenuItem<String>(
                            value: flow.id,
                            child: Text(flow.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if(value.toString() != state.flowId) {
                          context.read<SettingSuperBloc>().add(
                              OnSettingSuperEdit(
                                  value.toString(),
                                  SettingCodes.defaultFlow));
                          }
                        }
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 300,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const Text("Rol:"),
                      const VerticalDivider(),
                      DropdownButton(
                        value: state.listRoles.firstWhere((e) => e.name == state.roleName).name,
                        hint: const Text('Seleccionar'),
                        items: state.listRoles.map<DropdownMenuItem<String>>((Role role) {
                          return DropdownMenuItem<String>(
                            value: role.name,
                            child: Text(role.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if(value.toString() != state.roleName) {
                          context.read<SettingSuperBloc>().add(
                              OnSettingSuperEdit(
                                  value.toString(),
                                  SettingCodes.defaultRoleForUserRegister));
                          }
                        }
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 300,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Wrap(
                    children: [
                      const Text("Organización para anónimos:"),
                      const VerticalDivider(),
                      DropdownButton(
                        value: state.listOrgas.firstWhere((e) => e.id == state.orgaIdForAnonymous).id,
                        hint: const Text('Seleccionar'),
                        items: state.listOrgas.map<DropdownMenuItem<String>>((Orga orga) {
                          return DropdownMenuItem<String>(
                            value: orga.id,
                            child: Text(orga.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if(value.toString() != state.orgaId) {
                          context.read<SettingSuperBloc>().add(
                              OnSettingSuperEdit(
                                  value.toString(),
                                  SettingCodes.orgaForAnonymousUser));
                          }
                        }
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox();
  }
}
