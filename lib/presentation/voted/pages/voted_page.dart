import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../core/widgets/body_formatter.dart';
import '../../../core/widgets/scaffold_manager.dart';
import '../../../core/widgets/show_posts.dart';
import '../../../core/widgets/snackbar_notification.dart';
import '../../../domain/entities/workflow/post.dart';
import '../../../domain/entities/workflow/textcontent.dart';
import '../bloc/voted_bloc.dart';
import '../bloc/voted_cubit.dart';
import '../bloc/voted_event.dart';
import '../bloc/voted_state.dart';

class VotedPage extends StatelessWidget {
  VotedPage({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final int _fixPageSize = 10;

  @override
  Widget build(BuildContext context) {
    return BlocListener<VotedBloc, VotedState>(
      listener: (context, state) {
        if (state is VotedError && state.message != "") {
          snackBarNotify(context, state.message, Icons.cancel_outlined);
        }
      },
      child: ScaffoldManager(
        title: AppBar(title: const Text("Votados")),
        child: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              BodyFormatter(
                  screenWidth: MediaQuery.of(context).size.width,
                  child: _bodyVoted(context))
            ],
          ),
        )),
      ),
    );
  }

  Widget _bodyVoted(BuildContext context) {
    //Ordenamiento
    const Map<String, String> listFields = <String, String>{
      "Votación": "votes.created",
      "Creación": "created"
    };
    return BlocProvider<VotedLiveCubit>(
        create: (context) => VotedLiveCubit(),
        child: SizedBox(
            width: 800,
            child: Form(
                key: _key,
                child: BlocBuilder<VotedBloc, VotedState>(
                  builder: (context, state) {
                    if (state is VotedStart) {
                      context.read<VotedBloc>().add(OnVotedLoad(
                          '',
                          <String, int>{listFields.values.first: -1},
                          1,
                          _fixPageSize,
                          context
                              .read<VotedLiveCubit>()
                              .state
                              .checks["positive"]!,
                          context
                              .read<VotedLiveCubit>()
                              .state
                              .checks["negative"]!));
                    }
                    if (state is VotedLoading) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.3,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state is VotedLoaded) {
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
                                              color: Colors.grey, fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          context.read<VotedBloc>().add(
                                              OnVotedLoad(
                                                  _searchController.text,
                                                  <String, int>{
                                                    state.fieldsOrder.keys
                                                        .first: -1
                                                  },
                                                  1,
                                                  _fixPageSize,
                                                  context
                                                      .read<VotedLiveCubit>()
                                                      .state
                                                      .checks["positive"]!,
                                                  context
                                                      .read<VotedLiveCubit>()
                                                      .state
                                                      .checks["negative"]!));
                                        },
                                        icon: const Icon(Icons.search)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                BlocBuilder<VotedLiveCubit, VotedLiveState>(
                                  builder: (context, statecubit) {
                                    return _showFilters(
                                        statecubit, context, state);
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
                                          context.read<VotedBloc>().add(
                                              OnVotedLoad(
                                                  _searchController.text,
                                                  <String, int>{
                                                    state.fieldsOrder.keys
                                                        .first: -1
                                                  },
                                                  index + 1,
                                                  _fixPageSize,
                                                  context
                                                      .read<VotedLiveCubit>()
                                                      .state
                                                      .checks["positive"]!,
                                                  context
                                                      .read<VotedLiveCubit>()
                                                      .state
                                                      .checks["negative"]!));
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
                                    "${(state.searchText != "" ? "Buscando por \"${state.searchText}\", mostrando " : "Mostrando ")}${state.itemCount} registros de ${state.totalItems}.."),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          BlocBuilder<VotedLiveCubit, VotedLiveState>(
                            builder: (context, statecubit) {
                              return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.listItems.length,
                                  itemBuilder: (context, index) {
                                    return ShowPosts(post: state.listItems[index], child: _showVoteButtons(context, state.listItems[index], statecubit));
                                  });
                            },
                          )
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ))));
  }

  Column _showFilters(
      VotedLiveState statecubit, BuildContext context, VotedLoaded state) {
    return Column(
      children: [
        SwitchListTile.adaptive(
          title: const Text('Mostrar positivos'),
          value: statecubit.checks["positive"]!,
          onChanged: (value) {
            context.read<VotedLiveCubit>().changeCheckValue("positive", value);

            context.read<VotedBloc>().add(OnVotedLoad(
                _searchController.text,
                <String, int>{state.fieldsOrder.keys.first: -1},
                1,
                _fixPageSize,
                value,
                value ? !value : statecubit.checks["negative"]!));
          },
        ),
        SwitchListTile.adaptive(
          title: const Text('Mostrar negativos'),
          value: statecubit.checks["negative"]!,
          onChanged: (value) {
            context.read<VotedLiveCubit>().changeCheckValue("negative", value);

            context.read<VotedBloc>().add(OnVotedLoad(
                _searchController.text,
                <String, int>{state.fieldsOrder.keys.first: -1},
                1,
                _fixPageSize,
                value ? !value : statecubit.checks["positive"]!,
                value));
          },
        ),
      ],
    );
  }

  DropdownButton<String> _sortDropdownButton(
      VotedLoaded state, Map<String, String> listFields, BuildContext context) {
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
        context.read<VotedBloc>().add(OnVotedLoad(
            state.searchText,
            <String, int>{value!: -1},
            state.pageIndex,
            _fixPageSize,
            context.read<VotedLiveCubit>().state.checks["positive"]!,
            context.read<VotedLiveCubit>().state.checks["negative"]!));
      },
    );
  }

  Row _showVoteButtons(BuildContext context, Post post,
      VotedLiveState statecubit) {
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
                        .read<VotedBloc>()
                        .add(OnVotedAddVote(post.id, -1));
                    context
                        .read<VotedLiveCubit>()
                        .makeVote(post.id, -1);
                  },
            child: const Icon(Icons.keyboard_arrow_down)),
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
                        .read<VotedBloc>()
                        .add(OnVotedAddVote(post.id, 1));
                    context
                        .read<VotedLiveCubit>()
                        .makeVote(post.id, 1);
                  },
            child: const Icon(Icons.keyboard_arrow_up)),
      ],
    );
  }
}
