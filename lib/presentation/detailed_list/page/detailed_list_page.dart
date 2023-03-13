import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/presentation/detailed_list/bloc/detailedList_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../core/widgets/body_formatter.dart';
import '../../../core/widgets/scaffold_manager.dart';
import '../../../core/widgets/snackbar_notification.dart';
import '../../../domain/entities/workflow/stage.dart';
import '../../../domain/entities/workflow/textcontent.dart';
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
  final int _fixPageSize = 8;
  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailedListBloc, DetailedListState>(
      listener: (context, state) {
        /*if (state is DetailedListStart && state.message != "") {
          snackBarNotify(context, state.message, Icons.exit_to_app);
        } else*/ if (state is DetailedListError && state.message != "") {
          snackBarNotify(context, state.message, Icons.cancel_outlined);
        }
      },
      child: ScaffoldManager(
        title: AppBar(),
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
      ),
    );
  }

  Widget _bodyDetailedList(BuildContext context) {
    List<String> listFields = <String>["latest"];
    return BlocProvider<DetailedListLiveCubit>(
      create: (context) => DetailedListLiveCubit(),
      child: SizedBox(
        width: 800,
        child: BlocBuilder<DetailedListBloc, DetailedListState>(builder: (context, state) {
          if (state is DetailedListStart) {
            context.read<DetailedListBloc>().add(OnDetailedListLoading(
                '', const <String, int>{'latest': 1}, 1, _fixPageSize));
          }
          if (state is DetailedListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
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
                                context.read<DetailedListBloc>().add(OnDetailedListLoading(
                                    _searchController.text,
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
                      Wrap(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Páginas: "),
                          const VerticalDivider(),
                          NumberPicker(
                              itemWidth: 40,
                              haptics: true,
                              step: 1,
                              axis: Axis.horizontal,
                              value:
                                  state.totalPages == 0 ? 0 : state.pageIndex,
                              minValue: state.totalPages == 0 ? 0 : 1,
                              maxValue: state.totalPages,
                              onChanged: (value) => context
                                  .read<DetailedListBloc>()
                                  .add(OnDetailedListLoading(
                                      _searchController.text,
                                      <String, int>{
                                        state.fieldsOrder.keys.first: 1
                                      },
                                      value,
                                      _fixPageSize))),
                          const VerticalDivider(),
                          const Text("Orden:"),
                          const VerticalDivider(),
                          DropdownButton(
                            value: state.fieldsOrder.keys.first,
                            items: listFields
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              context.read<DetailedListBloc>().add(OnDetailedListLoading(
                                  state.searchText,
                                  <String, int>{value!: 1},
                                  state.pageIndex,
                                  _fixPageSize));
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
                      shrinkWrap: true,
                      itemCount: state.listItems.length,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                      child: ListTile(
                                        leading: const Icon(Icons.person),
                                        title: Text(
                                            state.listItems[index].title),
                                      ),
                                      onPressed: () {
                                        context.read<DetailedListBloc>().add(OnDetailedListEdit(state.listItems[index]));
                                      }
                                    ),
                                  ),
                                  Icon(state.listItems[index].enabled
                                    ? Icons.toggle_on
                                    : Icons.toggle_off_outlined,
                                    size: 40)
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text("Votos: ${state.listItems[index].votes.length.toString()} ")),
                                  Text("Fecha: ${state.listItems[index].created.month}/${
                                    state.listItems[index].created.day}/${
                                    state.listItems[index].created.year} "),
                                ],
                              ),
                              const Divider(),
                            ],
                          ),
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
                  children: const [
                    Text("Usuario: "),
                    Icon(Icons.person),
                    Text("Username: ")
                  ],
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(state.post.title),
                ),
                ListTile(
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.all(
                          Radius.circular(2))),
                  title: Text(
                    (state.post.postitems[0].content as TextContent).text,
                    textAlign: TextAlign.center),
                  contentPadding:
                    const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 100),
                ),
                DropdownButton(
                  value: state.liststage.firstWhere((e) => e.id == state.post.stageId).id,
                  items: state.liststage.map<DropdownMenuItem<String>>((Stage stage) {
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
                      context.read<DetailedListBloc>().add(OnDetailedListEdit(state.post));
                    }
                  },
                ),
                ElevatedButton(
                key: const ValueKey("btnEnableOption"),
                child:
                    Text((state.post.enabled ? "Deshabilitar" : "Habilitar")),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: AlertDialog(
                          title: Text(
                              '¿Desea ${(state.post.enabled ? "deshabilitar" : "habilitar")} el usuario'),
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
                            context.read<DetailedListBloc>().add(OnDetailedListEnable())
                          }
                      });
                },
              ),
              ],
            );
          }
          return const SizedBox();
        }),
      ),
    );
  }

  AppBar _variableAppBar(BuildContext context, DetailedListState state) {
    if (state is DetailedListLoaded) {
      return AppBar(
          title: const Text("Detalle"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.read<DetailedListBloc>().add(const OnDetailedListStarter(''));
            },
          ));
    }

    return AppBar(title: const Text(""));
  }
}
