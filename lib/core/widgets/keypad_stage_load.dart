import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/workflow/post.dart';
import '../../domain/entities/workflow/textcontent.dart';
import '../../domain/entities/workflow/vote.dart';
import '../../presentation/uploaded/bloc/uploaded_bloc.dart';
import '../../presentation/uploaded/bloc/uploaded_cubit.dart';
import '../../presentation/uploaded/bloc/uploaded_event.dart';
import '../constants.dart';

// Cambia el body dependiendo del tamaño de la pantalla
class KeypadLoad extends StatelessWidget {
  const KeypadLoad(
      {super.key,
      required this.context,
      required this.post,
      required this.statecubit,
      required this.keyValidate});
  final BuildContext context;
  final Post post;
  final UploadedLiveState statecubit;
  final GlobalKey<FormState> keyValidate;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) => isVoted(1, post.id, post.votes, statecubit.votes)
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
          onPressed: isVoted(1, post.id, post.votes, statecubit.votes)
              ? null
              : () {
                  if (keyValidate.currentState?.validate() == true) {
                    context
                        .read<UploadedBloc>()
                        .add(OnUploadedVote(post.id, 1));
                    context.read<UploadedLiveCubit>().makeVote(post.id, 1);
                  }
                },
          child: isVoted(1, post.id, post.votes, statecubit.votes)
              ? const Text('Publicado')
              : const Text('Publicar', style: TextStyle(color: Colors.blue))),
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
              onPressed: post.stageId == StagesVotationFlow.stageId01Load
                  ? () {
                      showDialog(
                          context: context,
                          builder: (context) => GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: AlertDialog(
                                  title: const Text('¿Desea eliminar el post?'),
                                  content: const Text(
                                      'La eliminación es permanente'),
                                  actions: <Widget>[
                                    TextButton(
                                      key: const ValueKey("btnConfirmDelete"),
                                      child: const Text('Eliminar'),
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      },
                                    ),
                                    TextButton(
                                      key: const ValueKey("btnCancelDelete"),
                                      child: const Text('Cancelar'),
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                    ),
                                  ],
                                ),
                              )).then((value) => {
                            if (value)
                              {
                                context
                                    .read<UploadedBloc>()
                                    .add(OnUploadedDelete(post.id))
                              }
                          });
                    }
                  : null,
              child: Icon(
                Icons.delete,
                size: 35,
                color: post.stageId == StagesVotationFlow.stageId01Load
                    ? Colors.blue
                    : Colors.grey,
              )),
          const SizedBox(
            width: 5,
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
              onPressed: post.stageId == StagesVotationFlow.stageId01Load
                  ? () {
                      context.read<UploadedBloc>().add(OnUploadedPrepareForEdit(
                          post.id,
                          post.title,
                          (post.postitems[0].content as TextContent).text));
                    }
                  : null,
              child: Icon(
                Icons.edit,
                size: 35,
                color: post.stageId == StagesVotationFlow.stageId01Load
                    ? Colors.blue
                    : Colors.grey,
              )),
        ],
      ),
    ]);
  }
}

bool isVoted(int voteValue, String postId, List<Vote> postVotes,
    Map<String, int> cubitVotes) {
  return postVotes.any((element) => element.value == voteValue) ||
      (cubitVotes.containsKey(postId) && cubitVotes[postId] == voteValue);
}
