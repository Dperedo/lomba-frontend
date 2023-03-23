import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/login/readif_redirect_login.dart';
import 'package:lomba_frontend/domain/usecases/post/get_latest_posts.dart';
import 'package:lomba_frontend/domain/usecases/post/vote_publication.dart';
import 'package:lomba_frontend/domain/usecases/local/get_has_login.dart';
import 'package:lomba_frontend/domain/usecases/local/get_session_role.dart';
import 'package:lomba_frontend/domain/usecases/local/get_session_status.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/constants.dart';
import '../../../data/models/session_model.dart';
import 'recent_event.dart';
import 'recent_state.dart';

///BLOC para el control de la página principal o Recent
///
///Consulta si el usuario está logueado o no.
class RecentBloc extends Bloc<RecentEvent, RecentState> {
  final GetHasLogIn _hasLogin;
  final FirebaseAuth _firebaseAuthInstance;
  final GetSession _getSession;
  final GetLatestPosts _getLatestPosts;
  final VotePublication _votePublication;
  final GetSessionRole _getSessionRole;
  final ReadIfRedirectLogin _readIfRedirectLogin;

  RecentBloc(
      this._firebaseAuthInstance,
      this._hasLogin,
      this._getSession,
      this._getLatestPosts,
      this._votePublication,
      this._getSessionRole,
      this._readIfRedirectLogin)
      : super(const RecentStart("")) {
    ///Evento que hace la consulta de sesión del usuario en el dispositivo.
    on<OnRecentLoading>(
      (event, emit) async {
        emit(RecentLoading());

        final resultHasRedirect = await _readIfRedirectLogin.execute();
        final hasRedirect = resultHasRedirect.getOrElse(() => false);

        if (hasRedirect) {
          emit(RecentHasLoginGoogleRedirect());
          return;
        }

        var auth = const SessionModel(token: "", username: "", name: "");
        const orgaId = "00000200-0200-0200-0200-000000000200";
        const userId = '00000005-0005-0005-0005-000000000005';
        String flowId = Flows.votationFlowId;
        String stageId = StagesVotationFlow.stageId03Voting;
        String role = '';
        var validLogin = false;

        final result = await _hasLogin.execute();

        result.fold((l) => {emit(RecentError(l.message))}, (valid) async {
          validLogin = valid;
          if (!valid) {
            try {
              await signInAnonymously();
              // ignore: empty_catches
            } catch (e) {}
          }
        });
        if (!validLogin) {
          final resultPosts = await _getLatestPosts.execute(
              orgaId,
              userId,
              flowId,
              stageId,
              event.searchText,
              event.pageIndex,
              event.pageSize);
          resultPosts.fold((l) => {emit(RecentError(l.message))}, (r) {
            emit(RecentLoaded(
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
                r.totalItems ?? 0,
                r.totalPages ?? 1));
          });
        } else {
          final listroles = await _getSessionRole.execute();
          listroles.fold(
              (l) => emit(RecentError(l.message)), (r) => {role = r[0]});
          if (role == 'user') {
            final session = await _getSession.execute();
            session.fold(
                (l) => emit(RecentError(l.message)), (r) => {auth = r});

            final resultPosts = await _getLatestPosts.execute(
                auth.getOrgaId()!,
                auth.getUserId()!,
                flowId,
                stageId,
                event.searchText,
                event.pageIndex,
                event.pageSize);
            resultPosts.fold((l) => {emit(RecentError(l.message))}, (r) {
              emit(RecentLoaded(
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
                  r.totalItems ?? 0,
                  r.totalPages ?? 1));
            });
          } else {
            emit(RecentOnlyUser());
          }
        }
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    ///Evento es llamado para reiniciar el Recent y haga la consulta de sesión.
    on<OnRecentStarter>((event, emit) async {
      emit(RecentStart(event.message));
    });

    on<OnRecentVote>((event, emit) async {
      String flowId = Flows.votationFlowId;
      String stageId = StagesVotationFlow.stageId03Voting;
      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold((l) => emit(RecentError(l.message)), (r) => {auth = r});

      final result = await _votePublication.execute(auth.getOrgaId()!,
          auth.getUserId()!, flowId, stageId, event.postId, event.voteValue);
      result.fold((l) => emit(RecentError(l.message)), (r) => null);
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  Future<UserCredential> signInAnonymously() async {
    return await _firebaseAuthInstance.signInAnonymously();
  }
}
