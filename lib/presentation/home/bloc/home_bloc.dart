import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/flow/get_latest_posts.dart';
import 'package:lomba_frontend/domain/usecases/local/get_has_login.dart';
import 'package:lomba_frontend/domain/usecases/local/get_session_status.dart';
import 'package:rxdart/rxdart.dart';

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

  HomeBloc(
    this._firebaseAuthInstance, 
    this._hasLogin,
    this._getSession,
    this._getLatestPosts
    ) : super(HomeStart()) {
    ///Evento que hace la consulta de sesión del usuario en el dispositivo.
    on<OnHomeLoading>(
      (event, emit) async {
        emit(HomeLoading());
        var auth = const SessionModel(token: "", username: "", name: "");
        const orgaId ="00000200-0200-0200-0200-000000000200";
        const userId = '00000005-0005-0005-0005-000000000005';
        const flowId = '00000111-0111-0111-0111-000000000111';
        const stageId = '00000CCC-0111-0111-0111-000000000111';
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
        if (!validLogin){
        final resultPosts = await _getLatestPosts.execute(
                orgaId,
                userId,
                flowId,
                stageId,       
                event.searchText,
                event.pageIndex,
                event.pageSize
              );
        resultPosts.fold(
              (l) => {emit(HomeError(l.message))},
              (r) => emit(HomeLoaded(
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
                  r.items.length
                  )));
        } else {
          final session = await _getSession.execute();
            session.fold((l) => emit(HomeError(l.message)), (r) => {auth = r});

            final resultPosts = await _getLatestPosts.execute(
              auth.getOrgaId()!,
              auth.getUserId()!,
              flowId,
              stageId,       
              event.searchText,
              event.pageIndex,
              event.pageSize
            );
          resultPosts.fold(
              (l) => {emit(HomeError(l.message))},
              (r) => emit(HomeLoaded(
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
                  r.items.length
                  )));
        }
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    ///Evento es llamado para reiniciar el Home y haga la consulta de sesión.
    on<OnRestartHome>((event, emit) async {
      emit(HomeStart());
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  Future<UserCredential> signInAnonymously() async {
    return await _firebaseAuthInstance.signInAnonymously();
  }
}
