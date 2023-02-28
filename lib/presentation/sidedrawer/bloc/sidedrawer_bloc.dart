import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/sidedrawer/do_logoff.dart';
import 'package:lomba_frontend/domain/usecases/sidedrawer/get_side_options.dart';
import 'package:lomba_frontend/presentation/sidedrawer/bloc/sidedrawer_event.dart';
import 'package:lomba_frontend/presentation/sidedrawer/bloc/sidedrawer_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/models/session_model.dart';
import '../../../domain/usecases/local/get_has_login.dart';
import '../../../domain/usecases/local/get_session_status.dart';
import '../../../domain/usecases/login/change_orga.dart';
import '../../../domain/entities/orga.dart';
import '../../../domain/usecases/orgas/get_orga.dart';
import '../../../domain/usecases/orgas/get_orgasbyuser.dart';

class SideDrawerBloc extends Bloc<SideDrawerEvent, SideDrawerState> {
  final GetSideOptions _getOptions;
  final DoLogOff _doLogOff;
  final GetSession _getSession;
  final GetOrgasByUser _getOrgasByUser;
  final GetHasLogIn _hasLogIn;
  final ChangeOrga _changeOrga;

  SideDrawerBloc(this._getOptions, this._doLogOff, this._getSession,
      this._getOrgasByUser, this._hasLogIn, this._changeOrga)
      : super(SideDrawerEmpty()) {
    on<OnSideDrawerLoading>(
      (event, emit) async {
        emit(SideDrawerLoading());
        List<Orga> listOrgas = [];
        SessionModel? session;
        String? orgaId = '';
        bool login = false;
        final result = await _getOptions.execute();

        final resultLogIn = await _hasLogIn.execute();
        resultLogIn.fold((l) => {emit(SideDrawerError(l.message))}, (r) => {login = r});

        if (login) {
          final resultSession = await _getSession.execute();
          resultSession.fold((l) => {emit(SideDrawerError(l.message))},
              (r) => {
                    session = SessionModel(
                        token: r.token, username: r.username, name: r.name)
                  });

          final userId = session?.getUserId();
          orgaId = session?.getOrgaId();
          final resultOrgas = await _getOrgasByUser.execute(userId!);

          resultOrgas.fold((l) => {emit(SideDrawerError(l.message))}, (r) {
            listOrgas = r;
          });
        }
        result.fold((l) => {emit(SideDrawerError(l.message))},
            (optList) => {emit(SideDrawerReady(optList, listOrgas, orgaId!))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnSideDrawerChangeOrga>((event, emit) async {
      final orgaId = event.orgaId;
      List<Orga> listOrgas = [];
      String username = '';
      SessionModel? session; //= ( name:'', token:'', usernam:'');

      final result = await _getOptions.execute();

      final resultSession = await _getSession.execute();
      resultSession.fold((l) => {emit(SideDrawerError(l.message))}, (r) {
        username = r.username;
      });

      final resultChange = await _changeOrga.execute(username, orgaId);

      resultChange.fold((l) => {emit(SideDrawerError(l.message))}, (r) async {
        session = SessionModel(
          token: r.token,
          username: r.username,
          name: r.name,
        );
      });
      final userId = session?.getUserId();
      final resultOrgas = await _getOrgasByUser.execute(userId!);

      resultOrgas.fold((l) => {emit(SideDrawerError(l.message))}, (r) => {listOrgas = r});

      result.fold((l) => {emit(SideDrawerError(l.message))},
          (optList) => {emit(SideDrawerReady(optList, listOrgas, orgaId))});
    });

    on<OnSideDrawerLogOff>((event, emit) async {
      final result = await _doLogOff.execute();

      result.fold((l) => {emit(SideDrawerError(l.message))}, (r) => {emit(SideDrawerEmpty())});
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
