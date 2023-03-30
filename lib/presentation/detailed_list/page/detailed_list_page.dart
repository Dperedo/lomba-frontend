import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import '../../../core/validators.dart';
import '../../../core/widgets/body_formatter.dart';
import '../../../core/widgets/scaffold_manager.dart';
import '../../../core/widgets/snackbar_notification.dart';
import '../../../domain/entities/workflow/flow.dart' as flw;
import '../../../domain/entities/workflow/stage.dart';
import '../../../domain/entities/workflow/textcontent.dart';
import '../bloc/detailed_list_bloc.dart';
import '../bloc/detailed_list_cubit.dart';
import '../bloc/detailed_list_event.dart';
import '../bloc/detailed_list_state.dart';

///DetailedListPage del sistema, en el futuro debe cambiar a página principal
///
///Por ahora sólo muestra un mensaje distinto cuando el usuario está o no
///logueado.
class DetailedListPage extends StatelessWidget {
  DetailedListPage({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final int _fixPageSize = 10;
  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailedListBloc, DetailedListState>(
      listener: (context, state) {
        /*if (state is DetailedListStart && state.message != "") {
          snackBarNotify(context, state.message, Icons.exit_to_app);
        } else*/
        if (state is DetailedListError && state.message != "") {
          snackBarNotify(context, state.message, Icons.cancel_outlined);
        }
      },
      child: BlocBuilder<DetailedListBloc, DetailedListState>(
        builder: (context, state) {
          return ScaffoldManager(
            title: _variableAppBar(context, state),
            child: SingleChildScrollView(
                child: Center(
              child: Column(
                children: [
                  BodyFormatter(
                    screenWidth: MediaQuery.of(context).size.width,
                    child: _bodyDetailedList(context),
                  )
                ],
              ),
            )),
          );
        },
      ),
    );
  }

  Widget _bodyDetailedList(BuildContext context) {
    const Map<String, String> listFields = <String, String>{
      "Creación": "created",
      "Modificación": "updated"
    };
    return BlocProvider<DetailedListLiveCubit>(
      create: (context) => DetailedListLiveCubit(),
      child: SizedBox(
        width: 800,
        child: BlocBuilder<DetailedListBloc, DetailedListState>(
            builder: (context, state) {
          if (state is DetailedListStart) {
            context.read<DetailedListBloc>().add(OnDetailedListLoading(
                '',
                '',
                '',
                <String, int>{listFields.values.first: -1},
                1,
                _fixPageSize,
                context.read<DetailedListLiveCubit>().state.checks["enabled"]!,
                context
                    .read<DetailedListLiveCubit>()
                    .state
                    .checks["disabled"]!));
          }
          if (state is DetailedListLoading) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.3,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is DetailedListLoaded) {
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
                              key: const ValueKey('search_field'),
                              controller: _searchController,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                hintText: 'Buscar',
                                hintStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 18),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                context.read<DetailedListBloc>().add(
                                    OnDetailedListLoading(
                                        _searchController.text,
                                        state.flowId,
                                        state.stageId,
                                        <String, int>{
                                          state.fieldsOrder.keys.first: 1
                                        },
                                        1,
                                        _fixPageSize,
                                        context
                                            .read<DetailedListLiveCubit>()
                                            .state
                                            .checks["enabled"]!,
                                        context
                                            .read<DetailedListLiveCubit>()
                                            .state
                                            .checks["disabled"]!));
                              },
                              icon: const Icon(Icons.search)),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      BlocBuilder<DetailedListLiveCubit, DetailedListLiveState>(
                        builder: (context, statecubit) {
                          return Column(
                            children: [
                              SwitchListTile.adaptive(
                                title: const Text('Mostrar habilitados'),
                                value: statecubit.checks["enabled"]!,
                                onChanged: (value) {
                                  context
                                      .read<DetailedListLiveCubit>()
                                      .changeCheckValue("enabled", value);

                                  context.read<DetailedListBloc>().add(
                                      OnDetailedListLoading(
                                          _searchController.text,
                                          state.flowId,
                                          state.stageId,
                                          <String, int>{
                                            state.fieldsOrder.keys.first: -1
                                          },
                                          1,
                                          _fixPageSize,
                                          value,
                                          value
                                              ? !value
                                              : statecubit
                                                  .checks["disabled"]!));
                                },
                              ),
                              SwitchListTile.adaptive(
                                title: const Text('Mostrar deshabilitados'),
                                value: statecubit.checks["disabled"]!,
                                onChanged: (value) {
                                  context
                                      .read<DetailedListLiveCubit>()
                                      .changeCheckValue("disabled", value);

                                  context.read<DetailedListBloc>().add(
                                      OnDetailedListLoading(
                                          _searchController.text,
                                          state.flowId,
                                          state.stageId,
                                          <String, int>{
                                            state.fieldsOrder.keys.first: -1
                                          },
                                          1,
                                          _fixPageSize,
                                          value
                                              ? !value
                                              : statecubit.checks["enabled"]!,
                                          value));
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Wrap(
                        children: [
                          DropdownButton(
                            value: state.listFlows
                                .firstWhere((e) => e.id == state.flowId)
                                .id,
                            items: state.listFlows
                                .map<DropdownMenuItem<String>>((flw.Flow flow) {
                              return DropdownMenuItem<String>(
                                value: flow.id,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: Text(flow.name),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value.toString() != state.flowId) {
                                context.read<DetailedListBloc>().add(
                                    OnDetailedListLoading(
                                        state.searchText,
                                        value.toString(),
                                        state.stageId,
                                        <String, int>{state.fieldsOrder.keys.first: -1},
                                        1,
                                        _fixPageSize,
                                        context
                                            .read<DetailedListLiveCubit>()
                                            .state
                                            .checks["enabled"]!,
                                        context
                                            .read<DetailedListLiveCubit>()
                                            .state
                                            .checks["disabled"]!));
                              }
                            },
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          DropdownButton(
                            value: state.listStages
                                .firstWhere((e) => e.id == state.stageId)
                                .id,
                            items: state.listStages
                                .map<DropdownMenuItem<String>>((Stage stage) {
                              return DropdownMenuItem<String>(
                                value: stage.id,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: Text(stage.name),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value.toString() != state.stageId) {
                                context.read<DetailedListBloc>().add(
                                    OnDetailedListLoading(
                                        state.searchText,
                                        state.flowId,
                                        value.toString(),
                                        <String, int>{state.fieldsOrder.keys.first: -1},
                                        1,
                                        _fixPageSize,
                                        context
                                            .read<DetailedListLiveCubit>()
                                            .state
                                            .checks["enabled"]!,
                                        context
                                            .read<DetailedListLiveCubit>()
                                            .state
                                            .checks["disabled"]!));
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Wrap(
                        //mainAxisAlignment: MainAxisAlignment.center,
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
                                context.read<DetailedListBloc>().add(
                                    OnDetailedListLoading(
                                        _searchController.text,
                                        state.flowId,
                                        state.stageId,
                                        <String, int>{
                                          state.fieldsOrder.keys.first: 1
                                        },
                                        index + 1,
                                        _fixPageSize,
                                        context
                                            .read<DetailedListLiveCubit>()
                                            .state
                                            .checks["enabled"]!,
                                        context
                                            .read<DetailedListLiveCubit>()
                                            .state
                                            .checks["disabled"]!));
                              },
                            ),
                          ),
                          const VerticalDivider(),
                          const Text("Orden:"),
                          const VerticalDivider(),
                          DropdownButton(
                            value: state.fieldsOrder.keys.first,
                            items: listFields.entries
                                .map<DropdownMenuItem<String>>((field) {
                              return DropdownMenuItem<String>(
                                value: field.value,
                                child: Text(field.key),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              context.read<DetailedListBloc>().add(
                                  OnDetailedListLoading(
                                      state.searchText,
                                      state.flowId,
                                      state.stageId,
                                      <String, int>{value!: 1},
                                      state.pageIndex,
                                      _fixPageSize,
                                      context
                                          .read<DetailedListLiveCubit>()
                                          .state
                                          .checks["enabled"]!,
                                      context
                                          .read<DetailedListLiveCubit>()
                                          .state
                                          .checks["disabled"]!));
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                          "${(state.searchText != "" ? "Buscando por \"${state.searchText}\", mostrando " : "Mostrando ")}${state.itemCount} registros de ${state.totalItems}. Página ${state.pageIndex} de ${state.totalPages}. Ordenado por ${state.fieldsOrder.keys.first}."),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                BlocBuilder<DetailedListLiveCubit, DetailedListLiveState>(
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
                                  child: TextButton(
                                      child: ListTile(
                                        leading: const Icon(Icons.person),
                                        title:
                                            Text(state.listItems[index].title),
                                      ),
                                      onPressed: () {
                                        context.read<DetailedListBloc>().add(
                                            OnDetailedListEdit(
                                                state.listItems[index]));
                                      }),
                                ),
                                Icon(
                                    state.listItems[index].enabled
                                        ? Icons.toggle_on
                                        : Icons.toggle_off_outlined,
                                    size: 40)
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                        "Votos: ${state.listItems[index].totals.fold(0, (previousValue, element) => int.parse((previousValue ?? 0).toString()) + element.totalcount)} ")),
                                Text(
                                    "Fecha: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(state.listItems[index].created)} "),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Estado: ${state.listItems[index].stages.last.name}"),
                              ],
                            ),
                            const Divider(),
                          ],
                        );
                      });
                }),
              ],
            );
          }
          if (state is DetailedListEdit) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Title(
                          color: Colors.black,
                          child: Text("Usuario: ${state.name}"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(Icons.person),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Title(
                        color: Colors.black,
                        child: Text("Username: ${state.username}"),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.post.tracks.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Table(
                            border: TableBorder.all(),
                            children: const [
                              TableRow(children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Descripción"),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Fecha"),
                                ),
                              ])
                            ]);
                      } else {
                        final item = index - 1;
                        return Table(
                          border: TableBorder.all(),
                          children: [
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child:
                                    Text(state.post.tracks[item].description),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(DateFormat('dd/MM/yyyy HH:mm:ss')
                                    .format(state.post.tracks[item].created)),
                              ),
                            ])
                          ],
                        );
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(state.post.title),
                ),
                ListTile(
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(2))),
                  title: Text(
                      (state.post.postitems[0].content as TextContent).text,
                      textAlign: TextAlign.center),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 100, vertical: 100),
                ),
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
                    onPressed: () {
                      context
                          .read<DetailedListBloc>()
                          .add(OnDetailedListPrepareEditContent(state.post));
                    },
                    child: const Icon(Icons.edit)),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    DropdownButton(
                      value: state.liststage
                          .firstWhere((e) => e.id == state.post.stageId)
                          .id,
                      items: state.liststage
                          .map<DropdownMenuItem<String>>((Stage stage) {
                        return DropdownMenuItem<String>(
                          value: stage.id,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Text(stage.name),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value.toString() != state.post.stageId) {
                          /*context.read<DetailedListBloc>().add(
                              OnDetailedListChangeStage(state.post,
                                  value.toString(), state.liststage));*/
                          final newStageId = value.toString();
                          showDialog(
                            context: context,
                            builder: (context) => GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: AlertDialog(
                                    title: const Text(
                                        '¿Desea cambiar el estado de la publicación?'),
                                    content: const Text(
                                        'Puede cambiar después su elección'),
                                    actions: <Widget>[
                                      TextButton(
                                        key: const ValueKey("btnConfirmEnable"),
                                        child: const Text('Cambiar'),
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
                                  context.read<DetailedListBloc>().add(
                                    OnDetailedListChangeStage(state.post,
                                        newStageId, state.liststage))
                                }
                            });
                        }
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      key: const ValueKey("btnEnableOption"),
                      child: Text(
                          (state.post.enabled ? "Deshabilitar" : "Habilitar")),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: AlertDialog(
                                    title: Text(
                                        '¿Desea ${(state.post.enabled ? "deshabilitar" : "habilitar")} la publicación?'),
                                    content: const Text(
                                        'Puede cambiar después su elección'),
                                    actions: <Widget>[
                                      TextButton(
                                        key: const ValueKey("btnConfirmEnable"),
                                        child: Text((state.post.enabled
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
                                  context.read<DetailedListBloc>().add(
                                      OnDetailedListEnable(
                                          state.post, state.liststage))
                                }
                            });
                      },
                    ),
                  ],
                ),
              ],
            );
          }
          if (state is DetailedListEditContent) {
            final TextEditingController titleController =
                TextEditingController();
            final TextEditingController contentController =
                TextEditingController();
            titleController.text = state.post.title;
            contentController.text =
                (state.post.postitems[0].content as TextContent).text;
            return Form(
              key: _key,
              child: Column(
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
                        if (_key.currentState?.validate() == true) {
                          context.read<DetailedListBloc>().add(
                              OnDetailedListEditContent(
                                  state.post.id,
                                  state.post.userId,
                                  titleController.text,
                                  contentController.text));
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        }),
      ),
    );
  }

  AppBar _variableAppBar(BuildContext context, DetailedListState state) {
    if (state is DetailedListEdit) {
      return AppBar(
          title: const Text("Detalle del Post"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context
                  .read<DetailedListBloc>()
                  .add(const OnDetailedListStarter(''));
            },
          ));
    } else if (state is DetailedListEditContent) {
      return AppBar(
          title: const Text("Edit del Post"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context
                  .read<DetailedListBloc>()
                  .add(OnDetailedListEdit(state.post));
            },
          ));
    }

    return AppBar(title: const Text("Todos los Post"));
  }
}
