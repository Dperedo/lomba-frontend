import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../core/widgets/body_formatter.dart';
import '../../../core/widgets/scaffold_manager.dart';
import '../../../core/widgets/snackbar_notification.dart';
import '../../../domain/entities/workflow/textcontent.dart';
import '../bloc/popular_bloc.dart';
import '../bloc/popular_cubit.dart';
import '../bloc/popular_event.dart';
import '../bloc/popular_state.dart';

///Página con el contenido popular.
///
///Esta página será accedida por los usuarios estén o no con sesión dentro,
///es decir, se mostrará a todos los usuarios no administradores.
class PopularPage extends StatelessWidget {
  PopularPage({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final int _fixPageSize = 8;
  @override
  Widget build(BuildContext context) {
    return BlocListener<PopularBloc, PopularState>(
      listener: (context, state) {
        if (state is PopularError && state.message != "") {
          snackBarNotify(context, state.message, Icons.cancel_outlined);
        }
      },
      child: ScaffoldManager(
        title: AppBar(
          title: const Text("Populares"),
        ),
        child: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              BodyFormatter(
                screenWidth: MediaQuery.of(context).size.width,
                child: _bodyPopular(context),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget _bodyPopular(BuildContext context) {
    List<String> listFields = <String>["popular"];
    return BlocProvider<PopularLiveCubit>(
      create: (context) => PopularLiveCubit(),
      child: SizedBox(
        width: 800,
        child:
            BlocBuilder<PopularBloc, PopularState>(builder: (context, state) {
          if (state is PopularStart) {
            context.read<PopularBloc>().add(OnPopularLoad(
                '', const <String, int>{'popular': 1}, 1, _fixPageSize));
          }
          if (state is PopularLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PopularLoaded) {
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
                                context.read<PopularBloc>().add(OnPopularLoad(
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
                              value:
                                  state.totalPages == 0 ? 0 : state.pageIndex,
                              minValue: state.totalPages == 0 ? 0 : 1,
                              maxValue: state.totalPages,
                              onChanged: (value) => context
                                  .read<PopularBloc>()
                                  .add(OnPopularLoad(
                                      _searchController.text,
                                      <String, int>{
                                        state.fieldsOrder.keys.first: 1
                                      },
                                      value,
                                      _fixPageSize))),
                          const VerticalDivider(),
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
                BlocBuilder<PopularLiveCubit, PopularLiveState>(
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
                                          leading: const Icon(Icons.person),
                                          title: Text(
                                              state.listItems[index].title),
                                        ),
                                        ListTile(
                                          shape: const RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: Colors.grey, width: 2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2))),
                                          // tileColor: Colors.grey,
                                          title: Text(
                                              (state
                                                      .listItems[index]
                                                      .postitems[0]
                                                      .content as TextContent)
                                                  .text,
                                              textAlign: TextAlign.center),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 100,
                                                  vertical: 100),
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                            child: _showVoteButtons(state,
                                                context, index, statecubit)),
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
                }),
              ],
            );
          }
          return const SizedBox();
        }),
      ),
    );
  }

  Row? _showVoteButtons(PopularLoaded state, BuildContext context, int index,
      PopularLiveState statecubit) {
    return (state.validLogin)
        ? Row(
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
                          (statecubit.votes
                                  .containsKey(state.listItems[index].id) &&
                              statecubit.votes[state.listItems[index].id] == -1)
                      ? null
                      : () {
                          state.listItems[index].votes.clear();
                          context.read<PopularBloc>().add(
                              OnPopularVote(state.listItems[index].id, -1));
                          context
                              .read<PopularLiveCubit>()
                              .makeVote(state.listItems[index].id, -1);
                        },
                  child: const Icon(Icons.keyboard_arrow_down)),
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
                          (statecubit.votes
                                  .containsKey(state.listItems[index].id) &&
                              statecubit.votes[state.listItems[index].id] == 1)
                      ? null
                      : () {
                          state.listItems[index].votes.clear();
                          context
                              .read<PopularBloc>()
                              .add(OnPopularVote(state.listItems[index].id, 1));
                          context
                              .read<PopularLiveCubit>()
                              .makeVote(state.listItems[index].id, 1);
                        },
                  child: const Icon(Icons.keyboard_arrow_up)),
            ],
          )
        : null;
  }
}
