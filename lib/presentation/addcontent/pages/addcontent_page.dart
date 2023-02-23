import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/validators.dart';
import 'package:lomba_frontend/presentation/addcontent/bloc/addcontent_bloc.dart';
import 'package:lomba_frontend/presentation/addcontent/bloc/addcontent_cubit.dart';
import 'package:lomba_frontend/presentation/addcontent/bloc/addcontent_event.dart';
import 'package:lomba_frontend/presentation/addcontent/bloc/addcontent_state.dart';

import '../../../core/widgets/body_formater.dart';
import '../../../core/widgets/scaffold_manager.dart';
import '../../../core/widgets/snackbar_notification.dart';

///Página para agregar contenido al sistema.
///
///Esta página será accedida por los usuarios clientes del sistema
///que quieran agregar contenido.
class AddContentPage extends StatelessWidget {
  AddContentPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddContentBloc, AddContentState>(
      builder: (context, state) {
        return BlocListener<AddContentBloc, AddContentState>(
          listener: (context, state) {
            if(state is AddContentError && state.message != ""){
              snackBarNotify(context, state.message, Icons.exit_to_app);
            }
          },
          child: ScaffoldManager(
            title: AppBar(
              title: const Text("Agregar contenido"),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: BodyFormater(
                      child: _bodyAddContent(context, _key),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _bodyAddContent(BuildContext context, GlobalKey<FormState> key) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();

    return BlocProvider<AddContentLiveCubit>(
      create: (context) => AddContentLiveCubit(),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SizedBox(
          child: Form(
            key: key,
            child: BlocBuilder<AddContentBloc, AddContentState>(
              builder: (context, state) {
                if (state is AddContentEmpty) {
                  return Column(
                    children: [
                      TextFormField(
                        key: const ValueKey('txtTitle'),
                        maxLength: 150,
                        controller: titleController,
                        validator: (value) =>
                            Validators.validateName(value ?? ""),
                        decoration: const InputDecoration(
                            labelText: 'Titulo', icon: Icon(Icons.title)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        key: const ValueKey('txtContent'),
                        maxLength: 500,
                        maxLines: 8,
                        controller: contentController,
                        validator: (value) =>
                            Validators.validateName(value ?? ""),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Contenido del Post',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text('Dejar como borrador'),
                          BlocBuilder<AddContentLiveCubit, AddContentLiveState>(
                            builder: (context, statecubit) {
                              return Checkbox(
                                value: statecubit.checks["keepasdraft"]!,
                                onChanged: (bool? value) {
                                  context
                                      .read<AddContentLiveCubit>()
                                      .changeValue("keepasdraft",
                                          !statecubit.checks["keepasdraft"]!);
                                },
                              );
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.publish),
                          key: const ValueKey("btnSavedUp"),
                          label: const Text("Subir"),
                          onPressed: () {
                            final AddContentLiveState checkos =
                                context.read<AddContentLiveCubit>().state;

                            if (key.currentState?.validate() == true) {
                              context.read<AddContentBloc>().add(
                                  OnAddContentAdd(
                                      titleController.text,
                                      contentController.text,
                                      context
                                          .read<AddContentLiveCubit>()
                                          .state
                                          .checks["keepasdraft"]!));
                            }
                          },
                        ),
                      ),
                    ],
                  );
                }

                if (state is AddContentUp) {
                  return Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        const Text('Agregado!'),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton.icon(
                            icon: const Icon(Icons.add),
                            label: const Text('Subir más contenido'),
                            onPressed: () {
                              context
                                  .read<AddContentBloc>()
                                  .add(const OnAddContentUp());
                            })
                      ],
                    ),
                  );
                }

                if (state is AddContentLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is AddContentError) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
