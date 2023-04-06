import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/presentation/login/bloc/login_bloc.dart';
import 'package:lomba_frontend/presentation/nav/bloc/nav_bloc.dart';
import 'package:lomba_frontend/presentation/nav/bloc/nav_state.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../core/widgets/body_formatter.dart';
import '../../../core/widgets/keypad_stage_vote.dart';
import '../../../core/widgets/scaffold_manager.dart';
import '../../../core/widgets/show_posts.dart';
import '../../../core/widgets/snackbar_notification.dart';
import '../../../domain/entities/workflow/post.dart';
import '../../../domain/entities/workflow/textcontent.dart';
import '../../login/bloc/login_event.dart';
import '../../nav/bloc/nav_event.dart';
import '../bloc/recent_bloc.dart';
import '../bloc/recent_cubit.dart';
import '../bloc/recent_event.dart';
import '../bloc/recent_state.dart';

///RecentPage del sistema, en el futuro debe cambiar a página principal
///
///Por ahora sólo muestra un mensaje distinto cuando el usuario está o no
///logueado.
class RecentPage extends StatelessWidget {
  RecentPage({Key? key}) : super(key: key);

  //static const String route = '/recent';
  final TextEditingController _searchController = TextEditingController();
  //final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final int _fixPageSize = 10;
  @override
  Widget build(BuildContext context) {
    return BlocListener<RecentBloc, RecentState>(
      listener: (context, state) {
        if (state is RecentStart && state.message != "") {
          snackBarNotify(context, state.message, Icons.exit_to_app);
        } else if (state is RecentError && state.message != "") {
          snackBarNotify(context, state.message, Icons.cancel_outlined);
        }
      },
      child: ScaffoldManager(
        title: AppBar(
          title: const Text("Recientes"),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                BodyFormatter(
                  screenWidth: MediaQuery.of(context).size.width,
                  child: _bodyRecent(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bodyRecent(BuildContext context) {
    const Map<String, String> listFields = <String, String>{
      "Creación": "created"
    };
    return BlocProvider<RecentLiveCubit>(
      create: (context) => RecentLiveCubit(),
      child: SizedBox(
        width: 800,
        child: BlocBuilder<RecentBloc, RecentState>(builder: (context, state) {
          if (state is RecentStart) {
            context.read<RecentBloc>().add(OnRecentLoading('',
                <String, int>{listFields.values.first: -1}, 1, _fixPageSize));
          }
          if (state is RecentLoading) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.3,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is RecentHasLoginGoogleRedirect) {
            context.read<NavBloc>().add(NavigateTo(NavItem.pageLogin, context));
            context.read<LoginBloc>().add(OnLoginRedirectWithGoogle());
          }
          if (state is RecentOnlyUser) {
            return const Center(child: Text('Bienvenidos a lomba!!!'));
          }
          if (state is RecentLoaded) {
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
                                context.read<RecentBloc>().add(OnRecentLoading(
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
                                context.read<RecentBloc>().add(OnRecentLoading(
                                    _searchController.text,
                                    <String, int>{
                                      state.fieldsOrder.keys.first: -1
                                    },
                                    index + 1,
                                    _fixPageSize));
                              },
                            ),
                          ),
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
                BlocBuilder<RecentLiveCubit, RecentLiveState>(
                  builder: (context, statecubit) {
                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.listItems.length,
                        itemBuilder: (context, index) {
                          return ShowPosts(
                            post: state.listItems[index],
                            child: KeypadVoteRecent(
                              context: context,
                              post: state.listItems[index],
                              statecubit: statecubit,
                              validLogin: state.validLogin,
                            )
                          );
                          //return ShowPosts(post: state.listItems[index], child: _showVoteButtons(context, state.listItems[index], state.validLogin, statecubit));
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

  Row _showVoteButtons(BuildContext context, Post post, bool validLogin,
      RecentLiveState statecubit) {
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
                          context
                              .read<RecentBloc>()
                              .add(OnRecentVote(post.id, -1));
                          context
                              .read<RecentLiveCubit>()
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
                              .read<RecentBloc>()
                              .add(OnRecentVote(post.id, 1));
                          context
                              .read<RecentLiveCubit>()
                              .makeVote(post.id, 1);
                        },
                  child: const Icon(Icons.keyboard_arrow_up)),
            ],
          )
        : Row();
  }
}
