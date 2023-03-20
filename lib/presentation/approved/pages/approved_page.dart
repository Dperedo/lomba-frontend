import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../domain/entities/workflow/textcontent.dart';
import '../../../core/widgets/body_formatter.dart';
import '../../../core/widgets/scaffold_manager.dart';
import '../../../core/widgets/snackbar_notification.dart';
import '../bloc/approved_bloc.dart';
import '../bloc/approved_cubit.dart';
import '../bloc/approved_event.dart';
import '../bloc/approved_state.dart';

///Página con el contenido que el usuario revisor ha aprobado anteriormente.
///
///Se mostrará un listado con todo aquel contenido que el usuario haya
///aprobado anteriormente desde la página de "Por Aprobar"
class ApprovedPage extends StatelessWidget {
  ApprovedPage({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final int _fixPageSize = 10;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ApprovedBloc, ApprovedState>(
      listener: (context, state) {
        if (state is ApprovedError && state.message != "") {
          snackBarNotify(context, state.message, Icons.cancel_outlined);
        }
      },
      child: ScaffoldManager(
        title: AppBar(
          title: const Text("Aprobados"),
        ),
        child: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              BodyFormatter(
                screenWidth: MediaQuery.of(context).size.width,
                child: _bodyApproved(context),
              )
            ],
          ),
        )),
      ),
    );
  }

  Widget _bodyApproved(BuildContext context) {
    //Ordenamiento
    const Map<String, String> listFields = <String, String>{
      "Creación": "created",
      "Aprobación": "tracks.created"
    };
    return BlocProvider<ApprovedLiveCubit>(
        create: (context) => ApprovedLiveCubit(),
        child: BlocListener<ApprovedLiveCubit, ApprovedLiveState>(
          listener: (context, state) {
            snackBarNotify(context, state.message, Icons.account_circle);
          },
          child: SizedBox(
              width: 800,
              child: Form(
                  key: _key,
                  child: BlocBuilder<ApprovedBloc, ApprovedState>(
                    builder: (context, state) {
                      if (state is ApprovedStart) {
                        context.read<ApprovedBloc>().add(OnApprovedLoad(
                            '',
                            <String, int>{listFields.values.first: -1},
                            1,
                            _fixPageSize));
                      }
                      if (state is ApprovedLoading) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.3,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      if (state is ApprovedLoaded) {
                        return Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
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
                                                color: Colors.grey,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            context.read<ApprovedBloc>().add(
                                                OnApprovedLoad(
                                                    _searchController.text,
                                                    <String, int>{
                                                      state.fieldsOrder.keys
                                                          .first: -1
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
                                            context.read<ApprovedBloc>().add(
                                                OnApprovedLoad(
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
                                      _sortDropdownButton(
                                          state, listFields, context)
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
                            BlocBuilder<ApprovedLiveCubit, ApprovedLiveState>(
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
                                                    leading: const Icon(
                                                        Icons.person),
                                                    title: Text(state
                                                        .listItems[index]
                                                        .title),
                                                  ),
                                                  ListTile(
                                                    shape: const RoundedRectangleBorder(
                                                        side: BorderSide(
                                                            color: Colors.grey,
                                                            width: 2),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    2))),
                                                    // tileColor: Colors.grey,
                                                    title: Text(
                                                        (state
                                                                    .listItems[
                                                                        index]
                                                                    .postitems[0]
                                                                    .content
                                                                as TextContent)
                                                            .text,
                                                        textAlign:
                                                            TextAlign.center),
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 100,
                                                            vertical: 100),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  _showVoteButtons(context,
                                                      state, index, statecubit),
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
                            }),
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  ))),
        ));
  }

  DropdownButton<String> _sortDropdownButton(ApprovedLoaded state,
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
        context.read<ApprovedBloc>().add(OnApprovedLoad(state.searchText,
            <String, int>{value!: -1}, state.pageIndex, _fixPageSize));
      },
    );
  }

  Row _showVoteButtons(BuildContext context, ApprovedLoaded state, int index,
      ApprovedLiveState statecubit) {
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
                        .read<ApprovedBloc>()
                        .add(OnApprovedVote(state.listItems[index].id, -1));
                    context
                        .read<ApprovedLiveCubit>()
                        .makeVote(state.listItems[index].id, -1);
                  },
            child: const Icon(Icons.close)),
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
                        .any((element) => element.value == 1) ||
                    (statecubit.votes.containsKey(state.listItems[index].id) &&
                        statecubit.votes[state.listItems[index].id] == 1)
                ? null
                : () {
                    state.listItems[index].votes.clear();
                    context
                        .read<ApprovedBloc>()
                        .add(OnApprovedVote(state.listItems[index].id, 1));
                    context
                        .read<ApprovedLiveCubit>()
                        .makeVote(state.listItems[index].id, 1);
                  },
            child: const Icon(Icons.check)),
      ],
    );
  }
}
