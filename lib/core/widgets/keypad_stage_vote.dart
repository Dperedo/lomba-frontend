import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/entities/workflow/imagecontent.dart';

import '../../domain/entities/workflow/post.dart';
import '../../domain/entities/workflow/postitem.dart';
import '../../domain/entities/workflow/videocontent.dart';
import '../../domain/entities/workflow/vote.dart';
import '../../presentation/nav/bloc/nav_bloc.dart';
import '../../presentation/nav/bloc/nav_event.dart';
import '../../presentation/nav/bloc/nav_state.dart';
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
            showCommentsButton(context, () {
              BlocProvider.of<NavBloc>(context).add(NavigateTo(
                  NavItem.pagePost, context, <String, dynamic>{"id": post.id}));
            }),
            const SizedBox(
              width: 5,
            ),
            showShareButton(context, () {}),
            const SizedBox(
              width: 5,
            ),
            showDownloadButton(context, post),
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
                  showCommentsButton(context, () {
                    BlocProvider.of<NavBloc>(context).add(NavigateTo(
                        NavItem.pagePost,
                        context,
                        <String, dynamic>{"id": post.id}));
                  }),
                  const SizedBox(
                    width: 5,
                  ),
                  showShareButton(context, () {}),
                  const SizedBox(
                    width: 5,
                  ),
                  showDownloadButton(context, post),
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
                  showBookmarkButton(context, () {}),
                  const SizedBox(
                    width: 5,
                  ),
                  showCommentsButton(context, () {
                    BlocProvider.of<NavBloc>(context).add(NavigateTo(
                        NavItem.pagePost,
                        context,
                        <String, dynamic>{"id": post.id}));
                  }),
                  const SizedBox(
                    width: 5,
                  ),
                  showShareButton(context, () {}),
                  const SizedBox(
                    width: 5,
                  ),
                  showDownloadButton(context, post),
                ],
              ),
            ],
          )
        : Row();
  }
}

OutlinedButton showDownloadButton(BuildContext context, Post post) {
  PostItem? postItem = null;
  String elementType = '';
  String elementUrl = '';
  String elementExtension = '';
  String elementMimeType = '';

  if (post.postitems
      .any((element) => element.type == "image" || element.type == "video")) {
    postItem = post.postitems.firstWhere(
        (element) => element.type == "image" || element.type == "video");

    elementType = postItem.type;
    if (elementType == 'image') {
      elementUrl = (postItem.content as ImageContent).url;
      elementExtension = elementUrl.split('.').last;
      elementMimeType = (postItem.content as ImageContent).filetype;
    }
    if (elementType == 'video') {
      elementUrl = (postItem.content as VideoContent).url;
      elementExtension = elementUrl.split('.').last;
      elementMimeType = (postItem.content as VideoContent).filetype;
    }
  }

  print(elementType);
  print(elementUrl);

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
      onPressed: postItem == null
          ? null
          : () async {
              /*if (await canLaunchUrl(Uri.parse(file.url))) {
                await launchUrl(
                  Uri.parse(file.url),
                );
              } else {
                throw 'No se pudo lanzar la URL file.url';
              }
*/
              /*
              FileSaver.instance
                  .saveFile(
                      name: "File",
                      link: elementUrl,
                      ext: elementExtension,
                      mimeType: MimeType.other)
                  .then((value) {
                print(value);
              });
              */
            },
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

OutlinedButton showBookmarkButton(
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
        Icons.bookmark_add,
        size: 35,
        color: Colors.grey,
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
