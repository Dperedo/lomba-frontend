import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';
import 'package:lomba_frontend/core/timezone.dart';
import 'package:lomba_frontend/core/widgets/body_formatter.dart';
import 'package:lomba_frontend/core/widgets/scaffold_manager.dart';
import 'package:lomba_frontend/presentation/nav/bloc/nav_bloc.dart';
import 'package:lomba_frontend/presentation/nav/bloc/nav_event.dart';

import '../../../core/widgets/keypad_stage_vote.dart';
import '../../../core/widgets/show_posts.dart';
import '../../../core/widgets/snackbar_notification.dart';
import '../../nav/bloc/nav_state.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_cubit.dart';
import '../bloc/post_event.dart';
import '../bloc/post_state.dart';
import '../../../injection.dart' as di;

class PostPage extends StatelessWidget {
  PostPage({Key? key, required this.postId, required this.hasReference})
      : super(key: key);

  late String postId;
  late bool hasReference;

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
          title: _variableAppBar(context, state),
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

  AppBar _variableAppBar(BuildContext context, PostState state) {
    if (state is PostLoaded) {
      return AppBar(
        title: const Text("Post"),
        leading: IconButton(
          key: const ValueKey('btnBackPost'),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (hasReference) {
              Navigator.pop(context);
            } else {
              BlocProvider.of<NavBloc>(context)
                  .add(NavigateTo(NavItem.pagePopular, context, null));
            }
          },
        ),
      );
    }

    return AppBar(title: const Text("Post"));
  }

  Widget _bodyPost(BuildContext context, PostState state) {
    final TextEditingController contentController = TextEditingController();

    if (postId != '') {
      context.read<PostBloc>().add(OnPostLoad(postId));
      postId = '';
    }

    if (state is PostStart && state.postId != '') {
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
      return BlocProvider<PostLiveCubit>(
        create: (context) => PostLiveCubit(di.locator(),di.locator(),di.locator(),di.locator(),),
        child: SizedBox(
          width: 600,
          child: BlocBuilder<PostLiveCubit, PostLiveState>(
            builder: (context, statecubit) {
              context.read<PostLiveCubit>().getComments(state.post.id);
              return Column(
                children: [
                  const SizedBox(height: 40),
                  ShowPosts(
                    post: state.post,
                    child: KeypadVotePost(
                      context: context,
                      post: state.post,
                      statecubit: statecubit,
                      validLogin: state.validLogin,
                      userId: state.userId,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text('Comentarios',
                      style: Theme.of(context).textTheme.headline6),
                  const SizedBox(height: 20),
                  ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: statecubit.commentList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              const SizedBox(height: 5),
                              /*ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(statecubit.commentList[index].user.avatar),
                                ),
                                //title: Text(statecubit.commentList[index].user.name),
                                title: Text(statecubit.commentList[index].user.name),
                                subtitle: Text('Creado: ${statecubit.commentList[index].created.toString()}'),
                              ),*/
                              Row(
                                children: [
                                  statecubit.commentList[index].users[0].pictureUrl!=null ? ClipOval(
                                    child: ImageNetwork(
                                      image: statecubit.commentList[index].users[0].pictureUrl!,
                                      height: 200,
                                      width: 200,
                                    ),
                                  ) : const Center(
                                      child: Icon(
                                        Icons.person,
                                        size: 30,
                                      ),
                                    ),
                                  const SizedBox(width: 10),
                                  Text(statecubit.commentList[index].users[0].name),
                                ],
                              ),
                              Wrap(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.grey,
                                      )
                                    ),
                                    child: Column(
                                      children: [
                                        //Text(statecubit.commentList[index].text),
                                        //Text('Creado: ${statecubit.commentList[index].created.toString()}'),
                                        ListTile(
                                          title: Text(statecubit.commentList[index].text),
                                          subtitle: Text('Creado: ${statecubit.commentList[index].created.toString()}'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  state.userId == statecubit.commentList[index].userId ? Container(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      onPressed: () {
                                        context.read<PostLiveCubit>().deleteComment(state.userId, state.post.id, statecubit.commentList[index].id);
                                      },
                                      icon: const Icon(Icons.close),
                                    ),
                                  ) : const SizedBox(),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        }
                      ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          maxLength: 300,
                          controller: contentController,
                          decoration: const InputDecoration(
                            hintText: 'Escribe un comentario',
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (contentController.text.length >= 4) {
                            context.read<PostLiveCubit>().postComment(state.userId, state.post.id, contentController.text, statecubit.commentList);
                            contentController.clear();
                          } else {
                            snackBarNotify(context, 'El comentario debe tener al menos 4 caracteres', Icons.cancel_outlined);
                          }
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              );
            },
          ),
        ),
      );
    }

    return const SizedBox();
  }
}
