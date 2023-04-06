import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/widgets/body_formatter.dart';
import 'package:lomba_frontend/core/widgets/scaffold_manager.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../core/widgets/keypad_stage_approval.dart';
import '../../../core/widgets/show_posts.dart';
import '../../../domain/entities/workflow/post.dart';
import '../../../domain/entities/workflow/textcontent.dart';
import '../../../core/widgets/snackbar_notification.dart';
import '../bloc/rejected_bloc.dart';
import '../bloc/rejected_cubit.dart';
import '../bloc/rejected_event.dart';
import '../bloc/rejected_state.dart';

///Página con los contenidos rechazados por el usuario revisor
///
///La página muestra sólo el contenido rechazado por el usuario conectado
///revisor.
class RejectedPage extends StatelessWidget {
  RejectedPage({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final int _fixPageSize = 10;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RejectedBloc, RejectedState>(
      listener: (context, state) {
        if (state is RejectedError && state.message != "") {
          snackBarNotify(context, state.message, Icons.cancel_outlined);
        }
      },
      child: ScaffoldManager(
        title: AppBar(title: const Text("Rechazados")),
        child: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              BodyFormatter(
                screenWidth: MediaQuery.of(context).size.width,
                child: _bodyRejected(context),
              )
            ],
          ),
        )),
      ),
    );
  }

  Widget _bodyRejected(BuildContext context) {
    //Ordenamiento
    const Map<String, String> listFields = <String, String>{
      "Creación": "created",
      "Rechazado": "tracks.created"
    };
    return BlocProvider<RejectedLiveCubit>(
      create: (context) => RejectedLiveCubit(),
      child: BlocListener<RejectedLiveCubit, RejectedLiveState>(
        listener: (context, state) {
          snackBarNotify(context, "okok", Icons.account_circle);
        },
        child: SizedBox(
          width: 800,
          child: BlocBuilder<RejectedBloc, RejectedState>(
            builder: (context, state) {
              if (state is RejectedStart) {
                context.read<RejectedBloc>().add(OnRejectedLoad(
                    '',
                    <String, int>{listFields.values.first: -1},
                    1,
                    _fixPageSize));
              }
              if (state is RejectedLoading) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is RejectedLoaded) {
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
                                    context.read<RejectedBloc>().add(
                                        OnRejectedLoad(
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
                                    context.read<RejectedBloc>().add(
                                        OnRejectedLoad(
                                            _searchController.text,
                                            <String, int>{
                                              state.fieldsOrder.keys.first: -1
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
                    BlocBuilder<RejectedLiveCubit, RejectedLiveState>(
                        builder: (context, statecubit) {
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.listItems.length,
                          itemBuilder: (context, index) {
                            return ShowPosts(
                              post: state.listItems[index],
                              child: KeypadApprovalRejected(
                                context: context,
                                post: state.listItems[index],
                                statecubit: statecubit,
                                keyValidate: _key,
                              )
                            );
                            //return ShowPosts(post: state.listItems[index], child: _showVoteButtons(context, state.listItems[index], statecubit));
                          });
                    }),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  DropdownButton<String> _sortDropdownButton(RejectedLoaded state,
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
        context.read<RejectedBloc>().add(OnRejectedLoad(state.searchText,
            <String, int>{value!: -1}, state.pageIndex, _fixPageSize));
      },
    );
  }

  Row _showVoteButtons(BuildContext context, Post post,
      RejectedLiveState statecubit) {
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
            onPressed: post.votes
                        .any((element) => element.value == -1) ||
                    (statecubit.votes.containsKey(post.id) &&
                        statecubit.votes[post.id] == -1)
                ? null
                : () {
                    post.votes.clear();
                    context
                        .read<RejectedBloc>()
                        .add(OnRejectedVote(post.id, -1));
                    context
                        .read<RejectedLiveCubit>()
                        .makeVote(post.id, -1);
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
            onPressed: post.votes
                        .any((element) => element.value == 1) ||
                    (statecubit.votes.containsKey(post.id) &&
                        statecubit.votes[post.id] == 1)
                ? null
                : () {
                    post.votes.clear();
                    context
                        .read<RejectedBloc>()
                        .add(OnRejectedVote(post.id, 1));
                    context
                        .read<RejectedLiveCubit>()
                        .makeVote(post.id, 1);
                  },
            child: const Icon(Icons.check)),
      ],
    );
  }
}
