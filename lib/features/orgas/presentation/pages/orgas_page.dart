import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/features/orgas/presentation/bloc/orga_event.dart';
import 'package:lomba_frontend/features/orgas/presentation/bloc/orgauser_event.dart';
import 'package:lomba_frontend/features/orgas/presentation/widgets/tap_to_expand.dart';
import 'package:lomba_frontend/features/sidedrawer/presentation/pages/sidedrawer_page.dart';

import '../bloc/orga_bloc.dart';
import '../bloc/orga_state.dart';
import '../bloc/orgauser_bloc.dart';
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
                                  state.orgas[index].name,
                                ),
                              ),
                              onPressed: () {
                                context
                                    .read<OrgaBloc>()
                                    .add(OnOrgaLoad(state.orgas[index].id));
                              },
                            )),
                      ))
                    ],
                  )),
              const Divider()
          ],
        );
        }
      );
    }

    if (state is OrgaLoaded) {
      return Column(
        children: [
          Text(state.orga.name),
          const Divider(),
          Text("Código: ${state.orga.code}"),
          const Divider(),
          Text("Estado: ${state.orga.enabled}"),
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
                              title:
                                  const Text('¿Desea eliminar la organización'),
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
              ElevatedButton(
                key: const ValueKey("btnEnableOption"),
                child:
                    Text((state.orga.enabled ? "Deshabilitar" : "Habilitar")),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: AlertDialog(
                              title: Text(
                                  '¿Desea ${(state.orga.enabled ? "deshabilitar" : "habilitar")} la organización'),
                              content: const Text(
                                  'Puede cambiar después su elección'),
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
              ElevatedButton(
                key: const ValueKey("btnViewUsersOption"),
                child: const Text("Ver usuarios"),
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
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<OrgaBloc>()
                        .add(const OnOrgaListLoad("", "", 1));
                  },
                  child: const Text("Volver"))
            ],
          ),
          const Divider(),
          _orgaUserList(context)
        ],
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
                itemCount: state.orgaUsers.length,
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
                                          state.orgaUsers[index].userId,
                                        ),
                                      ),
                                      onPressed: () {},
                                    )),
                              ))
                            ],
                          )),
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
    );
  }
}
