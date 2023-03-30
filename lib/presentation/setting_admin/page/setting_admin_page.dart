import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/widgets/body_formatter.dart';
import 'package:lomba_frontend/core/widgets/scaffold_manager.dart';

import '../../../core/widgets/snackbar_notification.dart';
import '../../../domain/entities/role.dart';
import '../../../domain/entities/workflow/flow.dart' as flw;
import '../bloc/setting_admin_bloc.dart';
import '../bloc/setting_admin_event.dart';
import '../bloc/setting_admin_state.dart';

///Página con el perfil del usuario
///
///La página es sólo para usuarios con sesión activa.
///Se deberían indicar aquí datos personales, contraseña, foto y demás
///cosas del usuario.
class SettingAdminPage extends StatelessWidget {
  const SettingAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingAdminBloc, SettingAdminState>(builder: (context, state) {
      return BlocListener<SettingAdminBloc, SettingAdminState>(
        listener: (context, state) {
          if (state is SettingAdminError && state.message != "") {
            snackBarNotify(context, state.message, Icons.cancel_outlined);
          } else if (state is SettingAdminStart && state.message != "") {
            snackBarNotify(context, state.message, Icons.account_circle);
          }
        },
        child: ScaffoldManager(
          title: AppBar(
            title: const Text("Configuración de Admin"),
          ),
          child: SingleChildScrollView(
              child: Center(
                  child: BodyFormatter(
            screenWidth: MediaQuery.of(context).size.width,
            child: _bodySettingAdmin(context, state),
          ))),
        ),
      );
    });
  }

  Widget _bodySettingAdmin(BuildContext context, SettingAdminState state) {

    if (state is SettingAdminStart) {
      context.read<SettingAdminBloc>().add(const OnSettingAdminLoad());
    }
    if (state is SettingAdminLoading) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.3,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (state is SettingAdminLoaded) {
      return Center(
        child: Column(
          children: [
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
                          context.read<SettingAdminBloc>().add(
                              OnSettingAdminSave(
                                  state.orgaId,
                                  value.toString(),
                                  state.roleName));
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
                          context.read<SettingAdminBloc>().add(
                              OnSettingAdminSave(
                                  state.orgaId,
                                  state.flowId,
                                  value.toString(),));
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
            ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  key: const ValueKey("btnViewSaveChanges"),
                  label: const Text("Guardar cambios"),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: AlertDialog(
                              title: const Text(
                                  '¿Desea guardar los cambios?'),
                              content: const Text(
                                  'Puede cambiar después su elección'),
                              actions: <Widget>[
                                TextButton(
                                  key: const ValueKey("btnConfirmEnable"),
                                  child: const Text(("Guardar")),
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
                            context.read<SettingAdminBloc>().add(
                                OnSettingAdminEdit(
                                  state.orgaId,
                                  state.flowId,
                                  state.roleName,))
                          }
                      }
                    );
                  },
                ),
          ],
        ),
      );
    }

    return const SizedBox();
  }
}
