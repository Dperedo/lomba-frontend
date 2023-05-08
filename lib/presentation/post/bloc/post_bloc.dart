import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/entities/workflow/comment.dart';
import 'package:lomba_frontend/domain/usecases/post/get_post.dart';
import 'package:lomba_frontend/presentation/post/bloc/post_event.dart';
import 'package:lomba_frontend/presentation/post/bloc/post_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/constants.dart';
import '../../../data/models/session_model.dart';
import '../../../domain/usecases/comment/get_comments_post.dart';
import '../../../domain/usecases/comment/post_comment.dart';
import '../../../domain/usecases/local/get_has_login.dart';
import '../../../domain/usecases/local/get_session_status.dart';
import '../../../domain/usecases/post/get_withuser_post.dart';
import '../../../domain/usecases/post/vote_publication.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPost _getPost;
  final GetWithUserPost _getWithUserPost;
  final GetHasLogIn _hasLogin;
  final FirebaseAuth _firebaseAuthInstance;
  final GetSession _getSession;
  final VotePublication _votePublication;
  final GetComments _getComments;
  final PostComment _postComment;

  PostBloc(
    this._getPost,
    this._getWithUserPost,
    this._hasLogin,
    this._firebaseAuthInstance,
    this._getSession,
    this._votePublication,
    this._getComments,
    this._postComment,
  ) : super(const PostStart('', '')) {
    on<OnPostStarter>((event, emit) => emit(PostStart('', event.postId)));

    on<OnPostLoad>(
      (event, emit) async {
        emit(PostLoading());

        final Map<String, dynamic> params = {'voteState': 1};
        var validLogin = false;
        var userId = '';
        List<Comment> commentList = [];
        final commentTest1 = Comment(id: '1', userId: '1', postId: event.postId, text: 'primer comentario', enabled: true, created: DateTime.now());
        final commentTest2 = Comment(id: '2', userId: '2', postId: event.postId, text: 'segundo comentario', enabled: true, created: DateTime.now());

        final result = await _hasLogin.execute();

        result.fold((l) => {emit(PostError(l.message))}, (valid) async {
          validLogin = valid;
          if (!valid) {
            try {
              await signInAnonymously();
              // ignore: empty_catches
            } catch (e) {}
          } else {
            final session = await _getSession.execute();
            session.fold((l) => emit(PostError(l.message)),
                (r) => userId = r.getUserId()!);
          }
        });

        /*final resultComment = await _getComments.execute(event.postId, 'created', 1, 10, params);
        resultComment.fold((l) => emit(PostError(l.message)),
            (r) => {commentList = r});

        //-----------------------------------------
        commentList.add(commentTest1);
        commentList.add(commentTest2);
        //-----------------------------------------*/

        if (!validLogin) {
          final resultPost = await _getPost.execute(event.postId);

          resultPost.fold((l) => emit(PostError(l.message)),
              (r) => {emit(PostLoaded(r, validLogin, userId, commentList))});
        } else {
          final resultPostUser = await _getWithUserPost.execute(event.postId,
              userId, Flows.votationFlowId, StagesVotationFlow.stageId03Voting);

          resultPostUser.fold((l) => emit(PostError(l.message)),
              (r) => {emit(PostLoaded(r, validLogin, userId, commentList))});
        }
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnPostVote>((event, emit) async {
      String flowId = Flows.votationFlowId;
      String stageId = StagesVotationFlow.stageId03Voting;
      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold((l) => emit(PostError(l.message)), (r) => {auth = r});

      final result = await _votePublication.execute(auth.getOrgaId()!,
          auth.getUserId()!, flowId, stageId, event.postId, event.voteValue);
      result.fold((l) => emit(PostError(l.message)), (r) => null);
    });

    on<OnCreateComment>((event, emit) async {
      final resultAddComment = await _postComment.execute(event.userId, event.postId, event.text);
      resultAddComment.fold((l) => emit(PostError(l.message)), (r) => null);
    });
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  Future<UserCredential> signInAnonymously() async {
    return await _firebaseAuthInstance.signInAnonymously();
  }
}
