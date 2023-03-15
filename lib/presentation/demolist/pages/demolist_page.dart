import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/presentation/demolist/bloc/demolist_bloc.dart';
import 'package:lomba_frontend/presentation/demolist/bloc/demolist_event.dart';
import 'package:lomba_frontend/presentation/demolist/bloc/demolist_state.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../sidedrawer/pages/sidedrawer_page.dart';

///Página con una lista demo
///
///Esta página tiene la demostración del funcionamiento de búsqueda
/// ordenamiento y filtrado.
class DemoListPage extends StatelessWidget {
  DemoListPage({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _pagerController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final int _fixPageSize = 8;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista demo")),
      body: SingleChildScrollView(
        child: Column(
          children: [_firstDemo(context)],
        ),
      ),
      drawer: const SideDrawer(),
    );
  }

  Widget _firstDemo(BuildContext context) {
    List<String> listFields = <String>["id", "name", "num", "text"];
    return Form(
      key: _key,
      child: BlocBuilder<DemoListBloc, DemoListState>(
        builder: (context, state) {
          if (state is DemoListStartState) {
            context.read<DemoListBloc>().add(OnDemoListSearch(
                "", const <String, int>{'num': 1}, 1, _fixPageSize));
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DemoListLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DemoListLoadedState) {
            List<int> list = [];

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
                                hintStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 18),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                context.read<DemoListBloc>().add(
                                    OnDemoListSearch(
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
                      Row(
                        children: [
                          SizedBox(
                            width: 200,
                            child: NumberPaginator(
                              numberPages: state.totalPages,
                              contentBuilder: (index) => Expanded(
                                child: Center(
                                  child: Text(
                                      "Página: ${index + 1} de ${state.totalPages}"),
                                ),
                              ),
                              onPageChange: (int index) {
                                context.read<DemoListBloc>().add(
                                    OnDemoListSearch(
                                        _searchController.text,
                                        <String, int>{
                                          state.fieldsOrder.keys.first: 1
                                        },
                                        index + 1,
                                        _fixPageSize));
                              },
                            ),
                          ),
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
                              context.read<DemoListBloc>().add(OnDemoListSearch(
                                  state.searchText,
                                  <String, int>{value!: 1},
                                  state.pageIndex,
                                  _fixPageSize));
                            },
                          )
                        ],
                      ),
                      Text(
                          "${(state.searchText != "" ? "Buscando por \"${state.searchText}\", mostrando " : "Mostrando ")}${state.itemCount} registros de ${state.totalItems}. Página ${state.pageIndex} de ${state.totalPages}. Ordenado por ${state.fieldsOrder.keys.first}.")
                    ],
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.listRandomItems.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: TextButton(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(children: [
                                          ListTile(
                                            leading: const Icon(Icons.numbers),
                                            title: Text(
                                                state.listRandomItems[index]
                                                    .name,
                                                style: const TextStyle(
                                                    fontSize: 18)),
                                            subtitle: Text(
                                                '${state.listRandomItems[index].id} / ${state.listRandomItems[index].num}',
                                                style: const TextStyle(
                                                    fontSize: 12)),
                                          )
                                        ]),
                                      ),
                                      onPressed: () {})),
                            ],
                          ),
                          const Divider()
                        ],
                      );
                    }),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
