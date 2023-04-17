import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/widgets/body_formatter.dart';
import 'package:lomba_frontend/core/widgets/scaffold_manager.dart';

import '../../../core/validators.dart';
import '../../../core/widgets/keypad_stage_vote.dart';
import '../../../core/widgets/show_posts.dart';
import '../../../core/widgets/snackbar_notification.dart';
import '../../../domain/entities/workflow/textcontent.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_cubit.dart';
import '../bloc/post_event.dart';
import '../bloc/post_state.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      return BlocListener<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostError && state.message != "") {
            snackBarNotify(context, state.message, Icons.cancel_outlined);
          } else if (state is PostStart && state.message != "") {
            snackBarNotify(context, state.message, Icons.account_circle);
          }
        },
        child: ScaffoldManager(
          title: AppBar(),//_variableAppBar(context, state),
          child: SingleChildScrollView(
              child: Center(
                  child: BodyFormatter(
            screenWidth: MediaQuery.of(context).size.width,
            child: _bodyPost(context, state),
          ))),
        ),
      );
    });
  }

  /*AppBar _variableAppBar(BuildContext context, PostState state) {
    if (state is PostEditing) {
      return AppBar(
          title: const Text("Editando Perfil"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.read<PostBloc>().add(OnPostStarter());
            },
          ));
    }

    return AppBar(title: const Text("Perfil"));
  }*/

  Widget _bodyPost(BuildContext context, PostState state) {
    final TextEditingController contentController = TextEditingController();

    if (state is PostStart) {
      context.read<PostBloc>().add(OnPostLoad(state.postId));
    }
    if (state is PostLoading) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.3,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (state is PostLoaded) {
      final String content = 'Texto';
      BlocBuilder<PostLiveCubit, PostLiveState>(
        builder: (context, statecubit) {
          return SizedBox(
            width: 600,
            child: Column(
              children: [
                const SizedBox(height: 40),
                ShowPosts(
                  post: state.post,
                  child: null,
                  /*KeypadVoteRecent(
                    context: context,
                    post: state.post,
                    statecubit: statecubit,
                    validLogin: state.validLogin,
                  ),*/
                ),
                const SizedBox(height: 40),
                /*ListTile(shape: const RoundedRectangleBorder(
                    side: BorderSide(
                    color: Colors.grey,
                    width: 2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(2))),
                  title: Text((content),
                  textAlign: TextAlign.center),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 100),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  key: const ValueKey('txtContent'),
                  maxLength: 300,
                  maxLines: 3,
                  controller: contentController,
                  validator: (value) => Validators.validateName(value ?? ""),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Texto',
                  ),
                ),*/
              ],
            ),
          );
        }
      );
    }

    return const SizedBox();
  }
}
