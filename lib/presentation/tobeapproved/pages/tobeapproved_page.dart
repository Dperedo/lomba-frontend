import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/widgets/body_formatter.dart';
import 'package:lomba_frontend/core/widgets/scaffold_manager.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:image_network/image_network.dart';

import '../../../core/widgets/snackbar_notification.dart';
import '../../../domain/entities/workflow/imagecontent.dart';
import '../../../domain/entities/workflow/textcontent.dart';
import '../bloc/tobeapproved_bloc.dart';
import '../bloc/tobeapproved_cubit.dart';
import '../bloc/tobeapproved_event.dart';
import '../bloc/tobeapproved_state.dart';

class ToBeApprovedPage extends StatelessWidget {
  ToBeApprovedPage({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final int _fixPageSize = 10;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ToBeApprovedBloc, ToBeApprovedState>(
      listener: (context, state) {
        if (state is ToBeApprovedError && state.message != "") {
          snackBarNotify(context, state.message, Icons.cancel_outlined);
        }
      },
      child: ScaffoldManager(
          title: AppBar(title: const Text("Por aprobar")),
          child: SingleChildScrollView(
              child: Center(
            child: Column(
              children: [
                BodyFormatter(
                    screenWidth: MediaQuery.of(context).size.width,
                    child: _bodyToBeApproved(context))
              ],
            ),
          ))),
    );
  }

  Widget _bodyToBeApproved(BuildContext context) {
    //Ordenamiento
    const Map<String, String> listFields = <String, String>{
      "Creación": "created",
      "Publicación": "tracks.created"
    };
    return BlocProvider<ToBeApprovedLiveCubit>(
        create: (context) => ToBeApprovedLiveCubit(),
        child: SizedBox(
          width: 800,
          child: Form(
              key: _key,
              child: BlocBuilder<ToBeApprovedBloc, ToBeApprovedState>(
                  builder: (context, state) {
                if (state is ToBeApprovedStart) {
                  context.read<ToBeApprovedBloc>().add(OnToBeApprovedLoad(
                      '',
                      <String, int>{listFields.values.first: -1},
                      1,
                      _fixPageSize));
                }
                if (state is ToBeApprovedLoading) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is ToBeApprovedLoaded) {
                  return Column(
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none),
                                      hintText: 'Buscar',
                                      hintStyle: const TextStyle(
                                          color: Colors.grey, fontSize: 18),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      context.read<ToBeApprovedBloc>().add(
                                          OnToBeApprovedLoad(
                                              _searchController.text,
                                              <String, int>{
                                                state.fieldsOrder.keys.first: -1
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
                                      context
                                          .read<ToBeApprovedBloc>()
                                          .add(
                                              OnToBeApprovedLoad(
                                                  _searchController.text,
                                                  <String, int>{
                                                    state.fieldsOrder.keys
                                                        .first: -1
                                                  },
                                                  index + 1,
                                                  _fixPageSize));
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
                      BlocBuilder<ToBeApprovedLiveCubit, ToBeApprovedLiveState>(
                          builder: (context, statecubit) {
                        return showPosts(state, statecubit);
                      })
                    ],
                  );
                }
                return const SizedBox();
              })),
        ));
  }

  ListView showPosts(ToBeApprovedLoaded state, ToBeApprovedLiveState statecubit) {
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
                          title: Text(
                              state.listItems[index].title),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.listItems[index]
                                          .postitems.length,
                          itemBuilder: (context, i) {
                          if (state.listItems[index].postitems[i].type=='text'){
                            return ListTile(
                              shape:
                                  const RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.grey,
                                          width: 2),
                                      borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(
                                                  2))),
                              title: Text(
                                  (state.listItems[index]
                                      .postitems[i].content
                                          as TextContent).text,
                                textAlign: TextAlign.center),
                              contentPadding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 100,
                                      vertical: 100),
                            );
                          }
                          else if(state.listItems[index].postitems[i].type=='image'){
                            
                            final imagen = state.listItems[index]
                                  .postitems[i].content as ImageContent;
                            return Container(
                              padding: const EdgeInsets.all(5.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                )
                              ),
                              child: ImageNetwork(
                                image: imagen.url,
                                height: double.parse((imagen.height).toString()),
                                width: double.parse((imagen.width).toString()),
                              )
                              //Image.network(imagen.url),
                            );
                          }
                            else {return null;}
                          }
                        ),
                        const SizedBox(height: 10),
                        _showVoteButtons(context, state,
                            index, statecubit),
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
  }

  DropdownButton<String> _sortDropdownButton(ToBeApprovedLoaded state,
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
        context.read<ToBeApprovedBloc>().add(OnToBeApprovedLoad(
            state.searchText,
            <String, int>{value!: 1},
            state.pageIndex,
            _fixPageSize));
      },
    );
  }

  Row _showVoteButtons(BuildContext context, ToBeApprovedLoaded state,
      int index, ToBeApprovedLiveState statecubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.resolveWith(
                (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Theme.of(context).secondaryHeaderColor,
                    width: 2,
                  ),
                ),
              ),
            ),
            onPressed: state.listItems[index].votes
                        .any((element) => element.value == -1) ||
                    (statecubit.votes.containsKey(state.listItems[index].id) &&
                        statecubit.votes[state.listItems[index].id] == -1)
                ? null
                : () {
                    state.listItems[index].votes.clear();
                    context
                        .read<ToBeApprovedBloc>()
                        .add(OnToBeApprovedVote(state.listItems[index].id, -1));
                    context
                        .read<ToBeApprovedLiveCubit>()
                        .makeVote(state.listItems[index].id, -1);
                  },
            child: const Icon(Icons.close)),
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
            onPressed: state.listItems[index].votes
                        .any((element) => element.value == 1) ||
                    (statecubit.votes.containsKey(state.listItems[index].id) &&
                        statecubit.votes[state.listItems[index].id] == 1)
                ? null
                : () {
                    state.listItems[index].votes.clear();
                    context
                        .read<ToBeApprovedBloc>()
                        .add(OnToBeApprovedVote(state.listItems[index].id, 1));
                    context
                        .read<ToBeApprovedLiveCubit>()
                        .makeVote(state.listItems[index].id, 1);
                  },
            child: const Icon(Icons.check)),
      ],
    );
  }
}
