import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/workflow/post.dart';
import '../../domain/entities/workflow/vote.dart';
import '../../presentation/approved/bloc/approved_bloc.dart';
import '../../presentation/approved/bloc/approved_cubit.dart';
import '../../presentation/approved/bloc/approved_event.dart';
import '../../presentation/rejected/bloc/rejected_bloc.dart';
import '../../presentation/rejected/bloc/rejected_cubit.dart';
import '../../presentation/rejected/bloc/rejected_event.dart';
import '../../presentation/tobeapproved/bloc/tobeapproved_bloc.dart';
import '../../presentation/tobeapproved/bloc/tobeapproved_cubit.dart';
import '../../presentation/tobeapproved/bloc/tobeapproved_event.dart';

class KeypadApprovalToBeApproved extends StatelessWidget {
  const KeypadApprovalToBeApproved(
      {super.key,
      required this.context,
      required this.post,
      required this.statecubit,
      required this.keyValidate});
  final BuildContext context;
  final Post post;
  final ToBeApprovedLiveState statecubit;
  final GlobalKey<FormState> keyValidate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        showRejectButton(context, post.id, post.votes, statecubit.votes, () {
          post.votes.clear();
          context.read<ToBeApprovedBloc>().add(OnToBeApprovedVote(post.id, -1));
          context.read<ToBeApprovedLiveCubit>().makeVote(post.id, -1);
        }),
        showApproveButton(context, post.id, post.votes, statecubit.votes, () {
          post.votes.clear();
          context.read<ToBeApprovedBloc>().add(OnToBeApprovedVote(post.id, 1));
          context.read<ToBeApprovedLiveCubit>().makeVote(post.id, 1);
        }),
      ],
    );
  }
}

class KeypadApprovalApproved extends StatelessWidget {
  const KeypadApprovalApproved(
      {super.key,
      required this.context,
      required this.post,
      required this.statecubit,
      required this.keyValidate});
  final BuildContext context;
  final Post post;
  final ApprovedLiveState statecubit;
  final GlobalKey<FormState> keyValidate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        showRejectButton(context, post.id, post.votes, statecubit.votes, () {
          post.votes.clear();
          context.read<ApprovedBloc>().add(OnApprovedVote(post.id, -1));
          context.read<ApprovedLiveCubit>().makeVote(post.id, -1);
        }),
        const SizedBox(
          width: 5,
        ),
        showApproveButton(context, post.id, post.votes, statecubit.votes, () {
          post.votes.clear();
          context.read<ApprovedBloc>().add(OnApprovedVote(post.id, 1));
          context.read<ApprovedLiveCubit>().makeVote(post.id, 1);
        }),
      ],
    );
  }
}

class KeypadApprovalRejected extends StatelessWidget {
  const KeypadApprovalRejected(
      {super.key,
      required this.context,
      required this.post,
      required this.statecubit,
      required this.keyValidate});
  final BuildContext context;
  final Post post;
  final RejectedLiveState statecubit;
  final GlobalKey<FormState> keyValidate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        showRejectButton(context, post.id, post.votes, statecubit.votes, () {
          post.votes.clear();
          context.read<RejectedBloc>().add(OnRejectedVote(post.id, -1));
          context.read<RejectedLiveCubit>().makeVote(post.id, -1);
        }),
        const SizedBox(
          width: 5,
        ),
        showApproveButton(context, post.id, post.votes, statecubit.votes, () {
          post.votes.clear();
          context.read<RejectedBloc>().add(OnRejectedVote(post.id, 1));
          context.read<RejectedLiveCubit>().makeVote(post.id, 1);
        }),
      ],
    );
  }
}

OutlinedButton showApproveButton(
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
        Icons.check,
        size: 35,
        color: isVoted(1, postId, postVotes, cubitVotes)
            ? Colors.black
            : Colors.blue,
      ));
}

OutlinedButton showRejectButton(
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
        Icons.close,
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
