import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/workflow/post.dart';
import '../../domain/entities/workflow/vote.dart';
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
      {super.key,
      required this.context,
      required this.post,
      required this.statecubit,
      required this.keyValidate});
  final BuildContext context;
  final Post post;
  final VotedLiveState statecubit;
  final GlobalKey<FormState> keyValidate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            showNegativeButton(context, post.id, post.votes, statecubit.votes,
                () {
              post.votes.clear();
              context.read<VotedBloc>().add(OnVotedAddVote(post.id, -1));
              context.read<VotedLiveCubit>().makeVote(post.id, -1);
            }),
            const SizedBox(
              width: 5,
            ),
            showPositiveButton(context, post.id, post.votes, statecubit.votes,
                () {
              post.votes.clear();
              context.read<VotedBloc>().add(OnVotedAddVote(post.id, 1));
              context.read<VotedLiveCubit>().makeVote(post.id, 1);
            }),
          ],
        ),
        Row(
          children: [
            showFavoriteButton(context, () {}),
            const SizedBox(
              width: 5,
            ),
            showCommentsButton(context, () {}),
            const SizedBox(
              width: 5,
            ),
            showShareButton(context, () {}),
            const SizedBox(
              width: 5,
            ),
            showDownloadButton(context, () {}),
          ],
        )
      ],
    );
  }
}

class KeypadVotePopular extends StatelessWidget {
  const KeypadVotePopular(
      {super.key,
      required this.context,
      required this.post,
      required this.statecubit,
      required this.validLogin});
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
                  showNegativeButton(
                      context, post.id, post.votes, statecubit.votes, () {
                    post.votes.clear();
                    context.read<PopularBloc>().add(OnPopularVote(post.id, -1));
                    context.read<PopularLiveCubit>().makeVote(post.id, -1);
                  }),
                  const SizedBox(
                    width: 5,
                  ),
                  showPositiveButton(
                      context, post.id, post.votes, statecubit.votes, () {
                    post.votes.clear();
                    context.read<PopularBloc>().add(OnPopularVote(post.id, 1));
                    context.read<PopularLiveCubit>().makeVote(post.id, 1);
                  }),
                ],
              ),
              Row(
                children: [
                  showFavoriteButton(context, () {}),
                  const SizedBox(
                    width: 5,
                  ),
                  showCommentsButton(context, () {}),
                  const SizedBox(
                    width: 5,
                  ),
                  showShareButton(context, () {}),
                  const SizedBox(
                    width: 5,
                  ),
                  showDownloadButton(context, () {}),
                ],
              )
            ],
          )
        : Row();
  }
}

class KeypadVoteRecent extends StatelessWidget {
  const KeypadVoteRecent(
      {super.key,
      required this.context,
      required this.post,
      required this.statecubit,
      required this.validLogin});
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
                  showNegativeButton(
                      context, post.id, post.votes, statecubit.votes, () {
                    post.votes.clear();
                    context.read<RecentBloc>().add(OnRecentVote(post.id, -1));
                    context.read<RecentLiveCubit>().makeVote(post.id, -1);
                  }),
                  const SizedBox(
                    width: 5,
                  ),
                  showPositiveButton(
                      context, post.id, post.votes, statecubit.votes, () {
                    post.votes.clear();
                    context.read<RecentBloc>().add(OnRecentVote(post.id, 1));
                    context.read<RecentLiveCubit>().makeVote(post.id, 1);
                  }),
                ],
              ),
              Row(
                children: [
                  showFavoriteButton(context, () {}),
                  const SizedBox(
                    width: 5,
                  ),
                  showCommentsButton(context, () {}),
                  const SizedBox(
                    width: 5,
                  ),
                  showShareButton(context, () {}),
                  const SizedBox(
                    width: 5,
                  ),
                  showDownloadButton(context, () {}),
                ],
              ),
            ],
          )
        : Row();
  }
}

OutlinedButton showDownloadButton(
    BuildContext context, VoidCallback onPressedFunction) {
  return OutlinedButton(
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
      onPressed: onPressedFunction,
      child: const Icon(
        Icons.download,
        size: 35,
        color: Colors.black,
      ));
}

OutlinedButton showShareButton(
    BuildContext context, VoidCallback onPressedFunction) {
  return OutlinedButton(
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
      onPressed: onPressedFunction,
      child: const Icon(
        Icons.share,
        size: 35,
        color: Colors.blueGrey,
      ));
}

OutlinedButton showCommentsButton(
    BuildContext context, VoidCallback onPressedFunction) {
  return OutlinedButton(
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
      onPressed: onPressedFunction,
      child: const Icon(
        Icons.comment,
        size: 35,
        color: Colors.grey,
      ));
}

OutlinedButton showFavoriteButton(
    BuildContext context, VoidCallback onPressedFunction) {
  return OutlinedButton(
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
      onPressed: onPressedFunction,
      child: const Icon(
        Icons.favorite,
        size: 35,
        color: Colors.black12,
      ));
}

OutlinedButton showPositiveButton(
    BuildContext context,
    String postId,
    List<Vote> postVotes,
    Map<String, int> cubitVotes,
    VoidCallback onPressedFunction) {
  return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => isVoted(1, postId, postVotes, cubitVotes)
              ? Colors.yellow
              : Colors.white,
        ),
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
      onPressed:
          isVoted(1, postId, postVotes, cubitVotes) ? null : onPressedFunction,
      child: Icon(
        Icons.keyboard_arrow_up,
        size: 35,
        color: isVoted(1, postId, postVotes, cubitVotes)
            ? Colors.black
            : Colors.blue,
      ));
}

OutlinedButton showNegativeButton(
    BuildContext context,
    String postId,
    List<Vote> postVotes,
    Map<String, int> cubitVotes,
    VoidCallback onPressedFunction) {
  return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => isVoted(-1, postId, postVotes, cubitVotes)
              ? Colors.yellow
              : Colors.white,
        ),
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
      onPressed:
          isVoted(-1, postId, postVotes, cubitVotes) ? null : onPressedFunction,
      child: Icon(
        Icons.keyboard_arrow_down,
        size: 35,
        color: isVoted(-1, postId, postVotes, cubitVotes)
            ? Colors.black
            : Colors.blue,
      ));
}

bool isVoted(int voteValue, String postId, List<Vote> postVotes,
    Map<String, int> cubitVotes) {
  return postVotes.any((element) => element.value == voteValue) ||
      (cubitVotes.containsKey(postId) && cubitVotes[postId] == voteValue);
}