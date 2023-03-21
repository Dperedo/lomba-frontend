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
import 'home_event.dart';
import 'home_state.dart';

///BLOC para el control de la página principal o Home
///
///Consulta si el usuario está logueado o no.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHasLogIn _hasLogin;
  final FirebaseAuth _firebaseAuthInstance;
  final GetSession _getSession;
  final GetLatestPosts _getLatestPosts;
  final VotePublication _votePublication;
  final GetSessionRole _getSessionRole;
  final ReadIfRedirectLogin _readIfRedirectLogin;

  HomeBloc(
      this._firebaseAuthInstance,
      this._hasLogin,
      this._getSession,
      this._getLatestPosts,
      this._votePublication,
      this._getSessionRole,
      this._readIfRedirectLogin)
      : super(const HomeStart("")) {
    ///Evento que hace la consulta de sesión del usuario en el dispositivo.
    on<OnHomeLoading>(
      (event, emit) async {
        emit(HomeLoading());

        final resultHasRedirect = await _readIfRedirectLogin.execute();
        final hasRedirect = resultHasRedirect.getOrElse(() => false);

        if (hasRedirect) {
          emit(HomeHasLoginGoogleRedirect());
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

        result.fold((l) => {emit(HomeError(l.message))}, (valid) async {
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
          resultPosts.fold((l) => {emit(HomeError(l.message))}, (r) {
            emit(HomeLoaded(
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
              (l) => emit(HomeError(l.message)), (r) => {role = r[0]});
          if (role == 'user') {
            final session = await _getSession.execute();
            session.fold((l) => emit(HomeError(l.message)), (r) => {auth = r});

            final resultPosts = await _getLatestPosts.execute(
                auth.getOrgaId()!,
                auth.getUserId()!,
                flowId,
                stageId,
                event.searchText,
                event.pageIndex,
                event.pageSize);
            resultPosts.fold((l) => {emit(HomeError(l.message))}, (r) {
              emit(HomeLoaded(
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
            emit(HomeOnlyUser());
          }
        }
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    ///Evento es llamado para reiniciar el Home y haga la consulta de sesión.
    on<OnHomeStarter>((event, emit) async {
      emit(HomeStart(event.message));
    });

    on<OnHomeVote>((event, emit) async {
      String flowId = Flows.votationFlowId;
      String stageId = StagesVotationFlow.stageId03Voting;
      var auth = const SessionModel(token: "", username: "", name: "");
      final session = await _getSession.execute();
      session.fold((l) => emit(HomeError(l.message)), (r) => {auth = r});

      final result = await _votePublication.execute(auth.getOrgaId()!,
          auth.getUserId()!, flowId, stageId, event.postId, event.voteValue);
      result.fold((l) => emit(HomeError(l.message)), (r) => null);
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  Future<UserCredential> signInAnonymously() async {
    return await _firebaseAuthInstance.signInAnonymously();
  }
}
