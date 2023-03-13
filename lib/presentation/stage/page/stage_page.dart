import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/widgets/body_formatter.dart';
import 'package:lomba_frontend/core/widgets/scaffold_manager.dart';

import '../../../core/widgets/snackbar_notification.dart';
import '../bloc/stage_bloc.dart';
import '../bloc/stage_event.dart';
import '../bloc/stage_state.dart';

class StagePage extends StatelessWidget {
  const StagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StageBloc, StageState>(
      builder: (context, state) {
        return BlocListener<StageBloc, StageState>(
          listener: (context, state) {
            if(state is StageError && state.message != ""){
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

  Widget _bodyRoles(BuildContext context, StageState state) {
    if (state is StageStart) {
      context.read<StageBloc>().add(const OnStageListLoad());
    }
    if (state is StageLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is StageError) {
      return Center(child: Text(state.message));
    }
    if (state is StageListLoaded) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: state.stages.length,
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
                                      state.stages[index].name,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              )),
                          onPressed: () {
                            context
                                .read<StageBloc>()
                                .add(OnStageLoad(state.stages[index].id));
                          })),
                  Icon(
                      state.stages[index].enabled
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

    if (state is StageLoaded) {
      return Column(
        children: [
          Text(state.stage.name),
          const Divider(),
          Text("Stagename: ${state.stage.name}"),
          const Divider(),
          Text("Estado: ${state.stage.enabled}"),
          const Divider(),
          Row(
            children: [
              ElevatedButton(
                child: const Text("Volver"),
                onPressed: () {
                  context.read<StageBloc>().add(const OnStageListLoad());
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

  AppBar _variableAppBar(BuildContext context, StageState state) {
    if (state is StageLoaded) {
      return AppBar(
          title: const Text("Estado"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.read<StageBloc>().add(const OnStageListLoad());
            },
          ));
    }

    return AppBar(title: const Text("Estados"));
  }
}
