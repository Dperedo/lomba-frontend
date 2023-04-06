import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/workflow/post.dart';
import '../../presentation/popular/bloc/popular_bloc.dart';
import '../../presentation/popular/bloc/popular_cubit.dart';
import '../../presentation/popular/bloc/popular_event.dart';
import '../../presentation/recent/bloc/recent_bloc.dart';
import '../../presentation/recent/bloc/recent_cubit.dart';
import '../../presentation/recent/bloc/recent_event.dart';
import '../../presentation/voted/bloc/voted_bloc.dart';
import '../../presentation/voted/bloc/voted_cubit.dart';
import '../../presentation/voted/bloc/voted_event.dart';

class KeypadVoteVoted extends StatelessWidget {
  const KeypadVoteVoted(
      {super.key, required this.context, required this.post, required this.statecubit, required this.keyValidate});
  final BuildContext context;
  final Post post;
  final VotedLiveState statecubit;
  final GlobalKey<FormState> keyValidate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.resolveWith(
              (states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
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
          child: const Icon(
            Icons.keyboard_arrow_down,
            size: 35,
            color: Colors.blue,)
        ),
        const SizedBox(width: 5,),
        OutlinedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.resolveWith(
              (states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
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
          child: const Icon(
            Icons.keyboard_arrow_up,
            size: 35,
            color: Colors.blue,)
        ),
      ],
    );
  }
}

class KeypadVotePopular extends StatelessWidget {
  const KeypadVotePopular(
      {super.key, required this.context, required this.post, required this.statecubit, required this.validLogin});
  final BuildContext context;
  final Post post;
  final PopularLiveState statecubit;
  final bool validLogin;

  @override
  Widget build(BuildContext context) {
    return (validLogin)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
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
                    child: const Icon(
                      Icons.arrow_drop_down,
                      size: 35,
                      color: Colors.blue,)
                  ),
                  const SizedBox(width: 5,),
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
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
                    child: const Icon(
                      Icons.arrow_drop_up,
                      size: 35,
                      color: Colors.blue,)
                  ),
                ],
              ),
              Row(
                children: [
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: Theme.of(context).secondaryHeaderColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: const Icon(
                      Icons.favorite,
                      size: 35,
                      color: Colors.red,)
                  ),
                  const SizedBox(width: 5,),
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: Theme.of(context).secondaryHeaderColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: const Icon(
                      Icons.comment,
                      size: 35,
                      color: Colors.blue,)
                  ),
                  const SizedBox(width: 5,),
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: Theme.of(context).secondaryHeaderColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: const Icon(
                      Icons.share,
                      size: 35,
                      color: Colors.yellow,)
                  ),
                  const SizedBox(width: 5,),
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: Theme.of(context).secondaryHeaderColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: const Icon(
                      Icons.download,
                      size: 35,
                      color: Colors.green,)
                  ),
                ],
              )
            ],
          )
        : Row();
  }
}

class KeypadVoteRecent extends StatelessWidget {
  const KeypadVoteRecent(
      {super.key, required this.context, required this.post, required this.statecubit, required this.validLogin});
  final BuildContext context;
  final Post post;
  final RecentLiveState statecubit;
  final bool validLogin;

  @override
  Widget build(BuildContext context) {
    return (validLogin)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
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
                    child: const Icon(
                          Icons.arrow_drop_down,
                          size: 35,
                          color: Colors.blue,)
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
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
                    child: const Icon(
                          Icons.arrow_drop_up,
                          size: 35,
                          color: Colors.blue,)
                  ),
                ],
              ),
              Row(
                children: [
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: Theme.of(context).secondaryHeaderColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: const Icon(
                      Icons.favorite,
                      size: 35,
                      color: Colors.red,)
                  ),
                  const SizedBox(width: 5,),
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: Theme.of(context).secondaryHeaderColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: const Icon(
                      Icons.comment,
                      size: 35,
                      color: Colors.blue,)
                  ),
                  const SizedBox(width: 5,),
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: Theme.of(context).secondaryHeaderColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: const Icon(
                      Icons.share,
                      size: 35,
                      color: Colors.yellow,)
                  ),
                  const SizedBox(width: 5,),
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: Theme.of(context).secondaryHeaderColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: const Icon(
                      Icons.download,
                      size: 35,
                      color: Colors.green,)
                  ),
                ],
              ),
            ],
          )
        : Row();
  }
}
