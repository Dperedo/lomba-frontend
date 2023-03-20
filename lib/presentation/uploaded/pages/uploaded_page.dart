import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/widgets/body_formatter.dart';
import 'package:lomba_frontend/core/widgets/scaffold_manager.dart';
import 'package:lomba_frontend/presentation/uploaded/bloc/uploaded_cubit.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../core/constants.dart';
import '../../../core/validators.dart';
import '../../../core/widgets/snackbar_notification.dart';
import '../../../domain/entities/workflow/textcontent.dart';
import '../bloc/uploaded_bloc.dart';
import '../bloc/uploaded_event.dart';
import '../bloc/upoaded_state.dart';

class UploadedPage extends StatelessWidget {
  UploadedPage({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController postIdController = TextEditingController();

  final int _fixPageSize = 10;
  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadedBloc, UploadedState>(
      listener: (context, state) {
        if (state is UploadedError && state.message != "") {
          snackBarNotify(context, state.message, Icons.cancel_outlined);
        }
      },
      child: ScaffoldManager(
        title: AppBar(title: const Text("Subidos")),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                BodyFormatter(
                  screenWidth: MediaQuery.of(context).size.width,
                  child: _bodyUploaded(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bodyUploaded(BuildContext context) {
    //Ordenamiento
    const Map<String, String> listFields = <String, String>{
      "Creación": "created",
      "Modificación": "updated"
    };
    return BlocProvider<UploadedLiveCubit>(
      create: (context) => UploadedLiveCubit(),
      child: BlocListener<UploadedLiveCubit, UploadedLiveState>(
        listener: (context, state) {
          snackBarNotify(context, "Publicado!", Icons.upload);
        },
        child: SizedBox(
          width: 800,
          child: Form(
              key: _key,
              child: BlocBuilder<UploadedBloc, UploadedState>(
                  builder: (context, state) {
                if (state is UploadedStart) {
                  context.read<UploadedBloc>().add(OnUploadedLoad(
                      '',
                      <String, int>{listFields.values.first: -1},
                      1,
                      _fixPageSize,
                      context
                          .read<UploadedLiveCubit>()
                          .state
                          .checks["onlydrafts"]!));
                }
                if (state is UploadedLoading) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is UploadedLoaded) {
                  return _uploadedLoaded(context, state, listFields);
                }
                if (state is UploadedPrepareForEdit) {
                  return _uploadedEdit(context, state, _key);
                }
                return const SizedBox();
              })),
        ),
      ),
    );
  }

  Widget _uploadedEdit(BuildContext context, UploadedPrepareForEdit state,
      GlobalKey<FormState> key) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();
    titleController.text = state.title;
    contentController.text = state.content;

    return Column(
      children: [
        TextFormField(
          key: const ValueKey('txtTitle'),
          maxLength: 150,
          controller: titleController,
          validator: (value) => Validators.validateName(value ?? ""),
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
          validator: (value) => Validators.validateName(value ?? ""),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Contenido del Post',
          ),
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
              final UploadedLiveState checkos =
                  context.read<UploadedLiveCubit>().state;
              if (key.currentState?.validate() == true) {
                context.read<UploadedBloc>().add(OnUploadedEdit(state.postId,
                    titleController.text, contentController.text));
              }
            },
          ),
        ),
      ],
    );
  }

  Column _uploadedLoaded(BuildContext context, UploadedLoaded state,
      Map<String, String> listFields) {
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
                        hintText: 'Buscar',
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        context.read<UploadedBloc>().add(OnUploadedLoad(
                            _searchController.text,
                            <String, int>{state.fieldsOrder.keys.first: -1},
                            1,
                            _fixPageSize,
                            context
                                .read<UploadedLiveCubit>()
                                .state
                                .checks["onlydrafts"]!));
                      },
                      icon: const Icon(Icons.search)),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              BlocBuilder<UploadedLiveCubit, UploadedLiveState>(
                builder: (context, statecubit) {
                  return SwitchListTile.adaptive(
                    title: const Text('Mostrar solo borradores'),
                    value: statecubit.checks["onlydrafts"]!,
                    onChanged: (value) {
                      context
                          .read<UploadedLiveCubit>()
                          .changeCheckValue("onlydrafts", value);

                      context.read<UploadedBloc>().add(OnUploadedLoad(
                          _searchController.text,
                          <String, int>{state.fieldsOrder.keys.first: -1},
                          1,
                          _fixPageSize,
                          value));
                    },
                  );
                },
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
                        context.read<UploadedBloc>().add(OnUploadedLoad(
                            _searchController.text,
                            <String, int>{state.fieldsOrder.keys.first: -1},
                            index + 1,
                            _fixPageSize,
                            context
                                .read<UploadedLiveCubit>()
                                .state
                                .checks["onlydrafts"]!));
                      },
                    ),
                  ),
                  const VerticalDivider(),
                  const Text("Orden:"),
                  const VerticalDivider(),
                  _sortDropdownButton(state, listFields, context)
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
        BlocBuilder<UploadedLiveCubit, UploadedLiveState>(
          builder: (context, statecubit) {
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.listItems.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.person),
                                  title: Text(state.listItems[index].title),
                                ),
                                ListTile(
                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.grey, width: 2),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(2))),
                                  // tileColor: Colors.grey,
                                  title: Text(
                                      (state.listItems[index].postitems[0]
                                              .content as TextContent)
                                          .text,
                                      textAlign: TextAlign.center),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 100, vertical: 100),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: showButtonPublish(
                                      state, index, statecubit, context),
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // const Divider()
                    ],
                  );
                });
          },
        ),
      ],
    );
  }

  DropdownButton<String> _sortDropdownButton(UploadedLoaded state,
      Map<String, String> listFields, BuildContext context) {
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
        context.read<UploadedBloc>().add(OnUploadedLoad(
            state.searchText,
            <String, int>{value!: -1},
            state.pageIndex,
            _fixPageSize,
            context.read<UploadedLiveCubit>().state.checks["onlydrafts"]!));
      },
    );
  }

  List<Widget> showButtonPublish(UploadedLoaded state, int index,
      UploadedLiveState statecubit, BuildContext context) {
    return [
      state.listItems[index].votes.any((element) => element.value == 1) ||
              (statecubit.votes.containsKey(state.listItems[index].id) &&
                  statecubit.votes[state.listItems[index].id] == 1)
          ? const Text('Publicado')
          : ElevatedButton(
              onPressed: () {
                if (_key.currentState?.validate() == true) {
                  context
                      .read<UploadedBloc>()
                      .add(OnUploadedVote(state.listItems[index].id, 1));
                  context
                      .read<UploadedLiveCubit>()
                      .makeVote(state.listItems[index].id, 1);
                }
              },
              child: const Text('Publicar')),
      Row(
        children: [
          ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.resolveWith(
                  (states) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                      color: Theme.of(context).secondaryHeaderColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
              onPressed: state.listItems[index].stageId ==
                      StagesVotationFlow.stageId01Load
                  ? () {
                      showDialog(
                          context: context,
                          builder: (context) => GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: AlertDialog(
                                  title: const Text('¿Desea eliminar el post?'),
                                  content: const Text(
                                      'La eliminación es permanente'),
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
                                context.read<UploadedBloc>().add(
                                    OnUploadedDelete(state.listItems[index].id))
                              }
                          });
                    }
                  : null,
              child: const Icon(Icons.delete)),
          ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.resolveWith(
                  (states) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                      color: Theme.of(context).secondaryHeaderColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
              onPressed: state.listItems[index].stageId ==
                      StagesVotationFlow.stageId01Load
                  ? () {
                      context.read<UploadedBloc>().add(OnUploadedPrepareForEdit(
                          state.listItems[index].id,
                          state.listItems[index].title,
                          (state.listItems[index].postitems[0].content
                                  as TextContent)
                              .text));
                    }
                  : null,
              child: const Icon(Icons.edit)),
        ],
      ),
    ];
  }
}
