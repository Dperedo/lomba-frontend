import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/widgets/body_formatter.dart';
import 'package:lomba_frontend/core/widgets/scaffold_manager.dart';

import '../../../core/widgets/snackbar_notification.dart';
import '../bloc/flow_bloc.dart';
import '../bloc/flow_event.dart';
import '../bloc/flow_state.dart';

class FlowPage extends StatelessWidget {
  const FlowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlowBloc, FlowState>(
      builder: (context, state) {
        return BlocListener<FlowBloc, FlowState>(
          listener: (context, state) {
            if(state is FlowError && state.message != ""){
              snackBarNotify(context, state.message, Icons.cancel_outlined);
            }
          },
          child: ScaffoldManager(
            title: _variableAppBar(context, state),
            child: SingleChildScrollView(
                child: Center(
              child: Column(
                children: [
                  BodyFormatter(
                    screenWidth: MediaQuery.of(context).size.width,
                    child: _bodyRoles(context, state)
                    )],
              ),
            )),
          ),
        );
      },
    );
  }

  Widget _bodyRoles(BuildContext context, FlowState state) {
    if (state is FlowStart) {
      context.read<FlowBloc>().add(const OnFlowListLoad());
    }
    if (state is FlowLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is FlowError) {
      return Center(child: Text(state.message));
    }
    if (state is FlowListLoaded) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: state.flows.length,
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
                                      state.flows[index].name,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              )),
                          onPressed: () {
                            context
                                .read<FlowBloc>()
                                .add(OnFlowLoad(state.flows[index].id));
                          })),
                  Icon(
                      state.flows[index].enabled
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

    if (state is FlowLoaded) {
      return Column(
        children: [
          Text(state.flow.name),
          const Divider(),
          Text("Flowname: ${state.flow.name}"),
          const Divider(),
          Text("Estado: ${state.flow.enabled}"),
          const Divider(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: state.flow.stages.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: const Icon(Icons.key_outlined),
                          title: Text(
                            state.flow.stages[index].name,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      Icon(
                      state.flow.stages[index].enabled
                          ? Icons.toggle_on
                          : Icons.toggle_off_outlined,
                      size: 40)
                    ]
                  ),
                  const Divider(),
                ]
              );
            }
          ),
          /*Row(
            children: [
              const VerticalDivider(),
              ElevatedButton(
                key: const ValueKey("btnEnableOption"),
                child:
                    Text((state.flow.enabled ? "Deshabilitar" : "Habilitar")),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: AlertDialog(
                              title: Text(
                                  '¿Desea ${(state.flow.enabled ? "deshabilitar" : "habilitar")} el usuario'),
                              content: const Text(
                                  'Puede cambiar después su elección'),
                              actions: <Widget>[
                                TextButton(
                                  key: const ValueKey("btnConfirmEnable"),
                                  child: Text((state.flow.enabled
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
                          }
                      });
                },
              ),
            ],
          ),*/
          Row(
            children: [
              ElevatedButton(
                child: const Text("Volver"),
                onPressed: () {
                  context.read<FlowBloc>().add(const OnFlowListLoad());
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

  AppBar _variableAppBar(BuildContext context, FlowState state) {
    if (state is FlowLoaded) {
      return AppBar(
          title: const Text("Flujo"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.read<FlowBloc>().add(const OnFlowListLoad());
            },
          ));
    }

    return AppBar(title: const Text("Flujos"));
  }
}
