import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/post/vote_publication.dart';
import 'package:lomba_frontend/presentation/popular/bloc/popular_event.dart';
import 'package:lomba_frontend/presentation/popular/bloc/popular_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/constants.dart';
import '../../../data/models/session_model.dart';
import '../../../domain/usecases/post/get_popular_posts.dart';
import '../../../domain/usecases/local/get_has_login.dart';
import '../../../domain/usecases/local/get_session_status.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final GetPopularPosts _getPopularPosts;
  final GetSession _getSession;
  final GetHasLogIn _hasLogin;
  final FirebaseAuth _firebaseAuthInstance;
  final VotePublication _votePublication;

  PopularBloc(this._getPopularPosts, this._getSession,
      this._firebaseAuthInstance, this._hasLogin, this._votePublication)
      : super(PopularStart()) {
    on<OnPopularStarter>((event, emit) => emit(PopularStart()));

    on<OnPopularLoad>(
      (event, emit) async {
        emit(PopularLoading());
        const orgaId = "00000200-0200-0200-0200-000000000200";
        const userId = '00000005-0005-0005-0005-000000000005';
        String flowId = Flows.votationFlowId;
        String stageId = StagesVotationFlow.stageId03Voting;
        var auth = const SessionModel(token: "", username: "", name: "");
        var validLogin = false;

        final result = await _hasLogin.execute();

        result.fold((failure) => {}, (valid) async {
          validLogin = valid;
          if (!valid) {
            try {
              await signInAnonymously();
            } catch (e) {}
          }
        });

        if (!validLogin) {
          final resultPosts = await _getPopularPosts.execute(
              orgaId,
              userId,
              flowId,
              stageId,
              event.searchText,
              event.pageIndex,
              event.pageSize);
          resultPosts.fold(
              (l) => {emit(PopularError(l.message))},
              (r) => emit(PopularLoaded(
                  validLogin,
                  orgaId,
                  userId,
                  flowId,
                  stageId,
                  event.searchText,
                  event.fieldsOrder,
                  event.pageIndex,
                  event.pageSize,
                  r.items,
                  r.currentItemCount,
                  r.items.length,
                  r.items.length)));
        } else {
          final session = await _getSession.execute();
          session.fold((l) => emit(PopularError(l.message)), (r) => {auth = r});

          final resultPosts = await _getPopularPosts.execute(
              auth.getOrgaId()!,
              auth.getUserId()!,
              flowId,
              stageId,
              event.searchText,
              event.pageIndex,
              event.pageSize);
          resultPosts.fold(
              (l) => {emit(PopularError(l.message))},
              (r) => emit(PopularLoaded(
                  validLogin,
                  auth.getOrgaId()!,
                  auth.getUserId()!,
                  flowId,
                  stageId,
                  event.searchText,
                  event.fieldsOrder,
                  event.pageIndex,
                  event.pageSize,
                  r.items,
                  r.currentItemCount,
                  r.items.length,
                  r.items.length)));
        }
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnPopularVote>((event, emit) async {
      String flowId = Flows.votationFlowId;
      String stageId = StagesVotationFlow.stageId03Voting;
      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold((l) => emit(PopularError(l.message)), (r) => {auth = r});

      final result = await _votePublication.execute(auth.getOrgaId()!,
          auth.getUserId()!, flowId, stageId, event.postId, event.voteValue);
      result.fold((l) => emit(PopularError(l.message)), (r) {});
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  Future<UserCredential> signInAnonymously() async {
    return await _firebaseAuthInstance.signInAnonymously();
  }
}
