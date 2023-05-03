import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/post/get_post.dart';
import 'package:lomba_frontend/presentation/post/bloc/post_event.dart';
import 'package:lomba_frontend/presentation/post/bloc/post_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/constants.dart';
import '../../../data/models/session_model.dart';
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

  PostBloc(
    this._getPost,
    this._getWithUserPost,
    this._hasLogin,
    this._firebaseAuthInstance,
    this._getSession,
    this._votePublication,
  ) : super(const PostStart('', '')) {
    on<OnPostStarter>((event, emit) => emit(PostStart('', event.postId)));

    on<OnPostLoad>(
      (event, emit) async {
        emit(PostLoading());

        var validLogin = false;

        final result = await _hasLogin.execute();

        result.fold((l) => {emit(PostError(l.message))}, (valid) async {
          validLogin = valid;
          if (!valid) {
            try {
              await signInAnonymously();
              // ignore: empty_catches
            } catch (e) {}
          }
        });

        var auth = const SessionModel(token: "", username: "", name: "");
        final session = await _getSession.execute();
        session.fold((l) => emit(PostError(l.message)), (r) => {auth = r});

        if (!validLogin) {
          final resultPost = await _getPost.execute(event.postId);

          resultPost.fold((l) => emit(PostError(l.message)),
              (r) => {emit(PostLoaded(r, validLogin))});
        } else {
          final resultPostUser = await _getWithUserPost.execute(
              event.postId,
              auth.getUserId() ?? "",
              Flows.votationFlowId,
              StagesVotationFlow.stageId03Voting);

          resultPostUser.fold((l) => emit(PostError(l.message)),
              (r) => {emit(PostLoaded(r, validLogin))});
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
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  Future<UserCredential> signInAnonymously() async {
    return await _firebaseAuthInstance.signInAnonymously();
  }
}
