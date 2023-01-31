import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/roles/enable_role.dart';
import 'package:lomba_frontend/domain/usecases/roles/get_role.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecases/roles/get_roles.dart';
import 'role_event.dart';
import 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  final EnableRole _enableRole;
  final GetRole _getRole;
  final GetRoles _getRoles;

  RoleBloc(
    this._enableRole,
    this._getRole,
    this._getRoles,
  ) : super(RoleStart()) {
    on<OnRoleLoad>(
      (event, emit) async {
        emit(RoleLoading());

        final result = await _getRole.execute(event.name);

        result.fold((failure) => emit(RoleError(failure.message)),
            (role) => {emit(RoleLoaded(role))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnRoleListLoad>(
      (event, emit) async {
        emit(RoleLoading());
        final result = await _getRoles.execute();

        result.fold((failure) => emit(RoleError(failure.message)),
            (listRoles) => {emit(RoleListLoaded(listRoles))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnRoleEnable>((event, emit) async {
      emit(RoleLoading());

      final result = await _enableRole.execute(event.name, event.enabled);
      result.fold(
          (l) => emit(RoleError(l.message)), (r) => {emit(RoleLoaded(r))});
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
