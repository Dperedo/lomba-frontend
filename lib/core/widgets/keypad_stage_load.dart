import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/workflow/post.dart';
import '../../domain/entities/workflow/textcontent.dart';
import '../../presentation/uploaded/bloc/uploaded_bloc.dart';
import '../../presentation/uploaded/bloc/uploaded_cubit.dart';
import '../../presentation/uploaded/bloc/uploaded_event.dart';
import '../constants.dart';

// Cambia el body dependiendo del tamaño de la pantalla
class KeypadLoad extends StatelessWidget {
  const KeypadLoad(
      {super.key, required this.context, required this.post, required this.statecubit, required this.keyValidate});
  final BuildContext context;
  final Post post;
  final UploadedLiveState statecubit;
  final GlobalKey<FormState> keyValidate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children:[
      post.votes.any((element) => element.value == 1) ||
              (statecubit.votes.containsKey(post.id) &&
                  statecubit.votes[post.id] == 1)
          ? const Text('Publicado')
          : OutlinedButton(
              onPressed: () {
                if (keyValidate.currentState?.validate() == true) {
                  context
                      .read<UploadedBloc>()
                      .add(OnUploadedVote(post.id, 1));
                  context
                      .read<UploadedLiveCubit>()
                      .makeVote(post.id, 1);
                }
              },
              child: const Text('Publicar')),
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
            onPressed: post.stageId ==
                    StagesVotationFlow.stageId01Load
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
                              context.read<UploadedBloc>().add(
                                  OnUploadedDelete(post.id))
                            }
                        });
                  }
                : null,
            child: const Icon(
              Icons.delete,
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
            onPressed: post.stageId ==
                    StagesVotationFlow.stageId01Load
                ? () {
                    context.read<UploadedBloc>().add(OnUploadedPrepareForEdit(
                        post.id,
                        post.title,
                        (post.postitems[0].content
                                as TextContent)
                            .text));
                  }
                : null,
            child: const Icon(
              Icons.edit,
              size: 35,
              color: Colors.blue,)
          ),
        ],
      ),
    ]
    );
  }
}
