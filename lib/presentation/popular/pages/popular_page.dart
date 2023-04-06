import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../core/widgets/body_formatter.dart';
import '../../../core/widgets/keypad_stage_vote.dart';
import '../../../core/widgets/scaffold_manager.dart';
import '../../../core/widgets/show_posts.dart';
import '../../../core/widgets/snackbar_notification.dart';
import '../../../domain/entities/workflow/post.dart';
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
  final int _fixPageSize = 10;
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
    const Map<String, String> listFields = <String, String>{
      "Popular": "totals.totalpositive"
    };
    return BlocProvider<PopularLiveCubit>(
      create: (context) => PopularLiveCubit(),
      child: SizedBox(
        width: 800,
        child:
            BlocBuilder<PopularBloc, PopularState>(builder: (context, state) {
          if (state is PopularStart) {
            context.read<PopularBloc>().add(OnPopularLoading('',
                <String, int>{listFields.values.first: -1}, 1, _fixPageSize));
          }
          if (state is PopularLoading) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.3,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
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
                                context.read<PopularBloc>().add(
                                    OnPopularLoading(
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
                                context.read<PopularBloc>().add(
                                    OnPopularLoading(
                                        _searchController.text,
                                        <String, int>{
                                          state.fieldsOrder.keys.first: -1
                                        },
                                        index + 1,
                                        _fixPageSize));
                              },
                            ),
                          )
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
                BlocBuilder<PopularLiveCubit, PopularLiveState>(
                    builder: (context, statecubit) {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.listItems.length,
                      itemBuilder: (context, index) {
                        return ShowPosts(
                          post: state.listItems[index],
                          child: KeypadVotePopular(
                            context: context,
                            post: state.listItems[index],
                            statecubit: statecubit,
                            validLogin: state.validLogin,
                          )
                        );
                        //return ShowPosts(post: state.listItems[index], child: _showVoteButtons(context, state.listItems[index], state.validLogin, statecubit));
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

  Row _showVoteButtons(BuildContext context, Post post, bool validLogin,
      PopularLiveState statecubit) {
    return (validLogin)
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
                  onPressed: post.votes
                              .any((element) => element.value == -1) ||
                          (statecubit.votes
                                  .containsKey(post.id) &&
                              statecubit.votes[post.id] == -1)
                      ? null
                      : () {
                          post.votes.clear();
                          context.read<PopularBloc>().add(
                              OnPopularVote(post.id, -1));
                          context
                              .read<PopularLiveCubit>()
                              .makeVote(post.id, -1);
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
                  onPressed: post.votes
                              .any((element) => element.value == 1) ||
                          (statecubit.votes
                                  .containsKey(post.id) &&
                              statecubit.votes[post.id] == 1)
                      ? null
                      : () {
                          post.votes.clear();
                          context
                              .read<PopularBloc>()
                              .add(OnPopularVote(post.id, 1));
                          context
                              .read<PopularLiveCubit>()
                              .makeVote(post.id, 1);
                        },
                  child: const Icon(Icons.keyboard_arrow_up)),
            ],
          )
        : Row();
  }
}
