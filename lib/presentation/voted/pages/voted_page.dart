import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../core/widgets/body_formatter.dart';
import '../../../core/widgets/scaffold_manager.dart';
import '../../../core/widgets/snackbar_notification.dart';
import '../../../domain/entities/workflow/textcontent.dart';
import '../../sidedrawer/pages/sidedrawer_page.dart';
import '../bloc/voted_bloc.dart';
import '../bloc/voted_cubit.dart';
import '../bloc/voted_event.dart';
import '../bloc/voted_state.dart';

class VotedPage extends StatelessWidget {
  VotedPage({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final int _fixPageSize = 8;

  @override
  Widget build(BuildContext context) {
    return BlocListener<VotedBloc, VotedState>(
      listener: (context, state) {
        if(state is VotedError && state.message != ""){
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
                child: _bodyVoted(context)
              )
            ],
          ),
        )),
      ),
    );
  }

  Widget _bodyVoted(BuildContext context) {
    List<String> listFields = <String>["voted"];
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
                          const <String, int>{'voted': 1},
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
                      return const Center(
                        child: CircularProgressIndicator(),
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
                                                        .first: 1
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
                                    return Column(
                                      children: [
                                        SwitchListTile.adaptive(
                                          title:
                                              const Text('Mostrar positivos'),
                                          value: statecubit.checks["positive"]!,
                                          onChanged: (value) {
                                            context
                                                .read<VotedLiveCubit>()
                                                .changeCheckValue(
                                                    "positive",
                                                    !statecubit
                                                        .checks["positive"]!);

                                            context.read<VotedBloc>().add(
                                                OnVotedLoad(
                                                    _searchController.text,
                                                    <String, int>{
                                                      state.fieldsOrder.keys
                                                          .first: 1
                                                    },
                                                    1,
                                                    _fixPageSize,
                                                    statecubit
                                                        .checks["positive"]!,
                                                    statecubit
                                                        .checks["negative"]!));
                                          },
                                        ),
                                        SwitchListTile.adaptive(
                                          title:
                                              const Text('Mostrar negativos'),
                                          value: statecubit.checks["negative"]!,
                                          onChanged: (value) {
                                            context
                                                .read<VotedLiveCubit>()
                                                .changeCheckValue(
                                                    "negative",
                                                    !statecubit
                                                        .checks["negative"]!);

                                            context.read<VotedBloc>().add(
                                                OnVotedLoad(
                                                    _searchController.text,
                                                    <String, int>{
                                                      state.fieldsOrder.keys
                                                          .first: 1
                                                    },
                                                    1,
                                                    _fixPageSize,
                                                    statecubit
                                                        .checks["positive"]!,
                                                    statecubit
                                                        .checks["negative"]!));
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Páginas: "),
                                    const VerticalDivider(),
                                    NumberPicker(
                                        itemWidth: 40,
                                        haptics: true,
                                        step: 1,
                                        axis: Axis.horizontal,
                                        value: state.totalPages == 0
                                            ? 0
                                            : state.pageIndex,
                                        minValue: state.totalPages == 0 ? 0 : 1,
                                        maxValue: state.totalPages,
                                        onChanged: (value) => context
                                            .read<VotedBloc>()
                                            .add(OnVotedLoad(
                                                _searchController.text,
                                                <String, int>{
                                                  state.fieldsOrder.keys.first:
                                                      1
                                                },
                                                value,
                                                _fixPageSize,
                                                context
                                                    .read<VotedLiveCubit>()
                                                    .state
                                                    .checks["positive"]!,
                                                context
                                                    .read<VotedLiveCubit>()
                                                    .state
                                                    .checks["negative"]!))),
                                    const VerticalDivider(),
                                    const Text("Orden:"),
                                    const VerticalDivider(),
                                    DropdownButton(
                                      value: state.fieldsOrder.keys.first,
                                      items: listFields
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        context.read<VotedBloc>().add(
                                            OnVotedLoad(
                                                state.searchText,
                                                <String, int>{value!: 1},
                                                state.pageIndex,
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
                          BlocBuilder<VotedLiveCubit, VotedLiveState>(
                            builder: (context, statecubit) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.listItems.length,
                                  itemBuilder: (context, index) {
                                    return SingleChildScrollView(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: Column(
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
                                                              color:
                                                                  Colors.grey,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
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
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        ElevatedButton(
                                                            style: ButtonStyle(
                                                              shape: MaterialStateProperty
                                                                  .resolveWith(
                                                                (states) =>
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  side:
                                                                      BorderSide(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .secondaryHeaderColor,
                                                                    width: 2,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            onPressed: state
                                                                        .listItems[
                                                                            index]
                                                                        .votes
                                                                        .any((element) =>
                                                                            element.value ==
                                                                            -1) ||
                                                                    (statecubit.votes.containsKey(state
                                                                            .listItems[
                                                                                index]
                                                                            .id) &&
                                                                        statecubit.votes[state.listItems[index].id] ==
                                                                            -1)
                                                                ? null
                                                                : () {
                                                                    context
                                                                        .read<
                                                                            VotedLiveCubit>()
                                                                        .makeVote(
                                                                            state.listItems[index].id,
                                                                            -1);
                                                                    context
                                                                        .read<
                                                                            VotedBloc>()
                                                                        .add(OnVotedAddVote(
                                                                            state.listItems[index].id,
                                                                            -1));
                                                                  },
                                                            child: const Icon(Icons
                                                                .keyboard_arrow_down)),
                                                        ElevatedButton(
                                                            style: ButtonStyle(
                                                              shape: MaterialStateProperty
                                                                  .resolveWith(
                                                                (states) =>
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  side:
                                                                      BorderSide(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .secondaryHeaderColor,
                                                                    width: 2,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            onPressed: state
                                                                        .listItems[
                                                                            index]
                                                                        .votes
                                                                        .any((element) =>
                                                                            element.value ==
                                                                            1) ||
                                                                    (statecubit.votes.containsKey(state
                                                                            .listItems[
                                                                                index]
                                                                            .id) &&
                                                                        statecubit.votes[state.listItems[index].id] ==
                                                                            1)
                                                                ? null
                                                                : () {
                                                                    context
                                                                        .read<
                                                                            VotedLiveCubit>()
                                                                        .makeVote(
                                                                            state.listItems[index].id,
                                                                            1);
                                                                    context
                                                                        .read<
                                                                            VotedBloc>()
                                                                        .add(OnVotedAddVote(
                                                                            state.listItems[index].id,
                                                                            1));
                                                                  },
                                                            child: const Icon(Icons
                                                                .keyboard_arrow_up)),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 15),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          // const Divider()
                                        ],
                                      ),
                                    );
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
}
