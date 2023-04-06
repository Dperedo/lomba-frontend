import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/validators.dart';
import 'package:lomba_frontend/presentation/addcontent/bloc/addcontent_bloc.dart';
import 'package:lomba_frontend/presentation/addcontent/bloc/addcontent_cubit.dart';
import 'package:lomba_frontend/presentation/addcontent/bloc/addcontent_event.dart';
import 'package:lomba_frontend/presentation/addcontent/bloc/addcontent_state.dart';

import '../../../core/widgets/body_formatter.dart';
import '../../../core/widgets/scaffold_manager.dart';
import '../../../core/widgets/snackbar_notification.dart';
import '../../../injection.dart' as di;

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
            if (state is AddContentError && state.message != "") {
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
                    child: BodyFormatter(
                      screenWidth: MediaQuery.of(context).size.width,
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
    final TextEditingController contentControllerImagen = TextEditingController();

    String? _validateFields(String value) {
      if (value.isEmpty && contentControllerImagen.text.isEmpty) {
        return 'Por favor, complete al menos uno de los campos';
      }
      return null;
    }

    return BlocProvider<AddContentLiveCubit>(
      create: (context) => AddContentLiveCubit(di.locator(),di.locator(),di.locator()),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SizedBox(
          child: Form(
            key: key,
            child: BlocBuilder<AddContentBloc, AddContentState>(
              builder: (context, state) {
                if (state is AddContentStart) {
                  context.read<AddContentBloc>().add(const OnAddContentUp());
                }
                if (state is AddContentFile) {
                  return Image.memory(
                    state.file,
                    fit: BoxFit.cover,
                  );
                }
                if (state is AddContentEdit) {
                  return BlocBuilder<AddContentLiveCubit, AddContentLiveState>(
                    builder: (context, statecubit) {
                      return Column(
                        children: [
                          TextFormField(
                            key: const ValueKey('txtTitle'),
                            maxLength: 150,
                            controller: titleController,
                            validator: (value) =>
                                Validators.validateName(value ?? ""),
                            decoration: const InputDecoration(
                                labelText: 'Título', icon: Icon(Icons.title)),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            key: const ValueKey('txtContent'),
                            maxLength: 500,
                            maxLines: 4,
                            controller: contentController,
                            validator: (value) =>
                                _validateFields(value ?? ""),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Texto',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            child: Stack(
                              children: <Widget>[
                                statecubit.filename != ""
                                    ? Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 250,
                                        child: Image.memory(
                                          statecubit.imagefile,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(
                                        padding: const EdgeInsets.all(5.0),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                5.0), // Radius of the border
                                            border: Border.all(
                                              width: 1,
                                              color: Colors
                                                  .grey, // Color of the border
                                            )),
                                        child: statecubit.showLocalProgress ?
                                        const CircularProgressIndicator() :
                                        ElevatedButton.icon(
                                            onPressed: () async {
                                              FilePickerResult? result =
                                                  await FilePicker.platform
                                                      .pickFiles(
                                                type: FileType.custom,
                                                allowedExtensions: [
                                                  'jpg',
                                                  'png',
                                                  'gif',
                                                  'jpeg'
                                                ],
                                              );
                                              if (result != null) {
                                                context.read<AddContentLiveCubit>().startProgressIndicators();
                                                PlatformFile file =
                                                    result.files.first;
                                                if (file.size != 0) {
                                                  contentControllerImagen.text = file.name;
                                                  context.read<AddContentLiveCubit>()
                                                      .showImage(
                                                          file.bytes!,
                                                          state.userId,
                                                          state.orgaId);
                                                } else {
                                                  snackBarNotify(context,
                                                      "El archivo no puede estar vacío",
                                                      Icons.error);
                                                }
                                              } else {
                                                // User canceled the picker
                                              }
                                            },
                                            icon: const Icon(Icons.file_open),
                                            label: const Text("Subir imagen")),
                                      ),
                                statecubit.filename != ""
                                    ? Container(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          alignment: Alignment.topRight,
                                          icon: const Icon(Icons.cancel),
                                          onPressed: () {
                                            context.read<AddContentLiveCubit>().stopRemoteProgressIndicators();
                                            context.read<AddContentLiveCubit>().removeImage();
                                          },
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Text('Dejar como borrador'),
                              Expanded(
                                child: Checkbox(
                                  value: statecubit.checks["keepasdraft"]!,
                                  onChanged: (bool? value) {
                                    context
                                        .read<AddContentLiveCubit>()
                                        .changeValue("keepasdraft",
                                            !statecubit.checks["keepasdraft"]!);
                                  },
                                ),
                              ),
                              statecubit.showRemoteProgress ?
                              const CircularProgressIndicator() : 
                              const SizedBox()
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
                              onPressed: statecubit.showRemoteProgress || statecubit
                                              .cloudFile == null ? null :
                              () {
                                if (key.currentState?.validate() == true) {
                                  context.read<AddContentBloc>().add(
                                      OnAddContentAdd(
                                          titleController.text,
                                          contentController.text,
                                          statecubit.cloudFile,
                                          statecubit.checks["keepasdraft"]!,
                                          statecubit.imageHeight,
                                          statecubit.imageWidth,));
                                }
                              },
                            ),
                          ),
                          const Divider(
                            height: 10,
                          ),
                        ],
                      );
                    },
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
                              context.read<AddContentLiveCubit>().removeImage();
                            })
                      ],
                    ),
                  );
                }

                if (state is AddContentLoading) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
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
