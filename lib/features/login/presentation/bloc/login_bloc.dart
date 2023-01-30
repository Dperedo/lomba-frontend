import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/features/login/domain/usecases/change_orga.dart';
import 'package:lomba_frontend/features/login/domain/usecases/get_authenticate.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/get_orgasbyuser.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../core/data/models/session_model.dart';
import '../../../../core/domain/entities/session.dart';
import '../../../orgas/domain/entities/orga.dart';
import 'login_event.dart';
import 'login_state.dart';

///BLOC que controla la funcionalidad de Login de usuario.
///
///Considera dos eventos, el que intenta hacer el login y otro para
///reiniciar la pantalla.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetAuthenticate _getAuthenticate;
  final GetOrgasByUser _getOrgasByUser;
  final ChangeOrga _changeOrga;

  LoginBloc(this._getAuthenticate, this._getOrgasByUser, this._changeOrga)
      : super(LoginEmpty()) {
    on<OnLoginTriest>(
      (event, emit) async {
        final username = event.username;
        final password = event.password;

        ///El siguiente emit envía la instrucción de mostrar el spinner
        emit(LoginGetting());
        List<Orga> listorgas = [];
        SessionModel? session;

        final result = await _getAuthenticate.execute(username, password);

        result.fold((failure) {emit(LoginError(failure.message));return;}, (r) {
          session =
              SessionModel(token: r.token, username: r.username, name: r.name);
        });

        if (session != null && session?.getOrgaId() == null) {
          final userId = session?.getUserId();
          final resultOrgas = await _getOrgasByUser.execute(userId!);

          resultOrgas.fold((failure) => {emit(LoginError(failure.message))},
              (r) {
            listorgas = r;
          });
          emit(LoginSelectOrga(listorgas, username));
        } else {
          emit(LoginGoted(session));
        }
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnLoginChangeOrga>((event, emit) async {
      final username = event.username;
      final orgaId = event.orgaId;

      emit(LoginGetting());

      final result = await _changeOrga.execute(username, orgaId);

      result.fold((failure) => {emit(LoginError(failure.message))}, (session) {
        final s = SessionModel(
          token: session.token,
          username: session.username,
          name: session.name,
        );
        emit(LoginGoted(s));
      });
    });

    ///Evento que sólo busca reiniciar la pantalla de login
    on<OnRestartLogin>((event, emit) async {
      emit(LoginEmpty());
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
