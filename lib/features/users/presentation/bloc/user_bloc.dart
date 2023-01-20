import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/features/users/domain/usecases/add_user.dart';
import 'package:lomba_frontend/features/users/domain/usecases/delete_user.dart';
import 'package:lomba_frontend/features/users/domain/usecases/enable_user.dart';
import 'package:lomba_frontend/features/users/domain/usecases/get_user.dart';
import 'package:lomba_frontend/features/users/domain/usecases/update_user.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users.dart';
import '../../domain/usecases/update_user_password.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AddUser _addUser;
  final DeleteUser _deleteUser;
  final EnableUser _enableUser;
  final GetUser _getUser;
  final GetUsers _getUsers;
  final UpdateUser _updateUser;
  final UpdateUserPassword _updateUserPassword;

  UserBloc(
    this._addUser,
    this._deleteUser,
    this._enableUser,
    this._getUser,
    this._getUsers,
    this._updateUser, 
    this._updateUserPassword,
  ) : super(UserStart()) {
    on<OnUserLoad>(
      (event, emit) async {
        emit(UserLoading());
        final result = await _getUser.execute(event.id);

        result.fold(
            (l) => emit(UserError(l.message)), (r) => {emit(UserLoaded(r))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnUserListLoad>(
      (event, emit) async {
        emit(UserLoading());
        final result = await _getUsers.execute(
            event.orgaId, event.filter, event.fieldOrder, event.pageNumber, 10);

        result.fold((l) => emit(UserError(l.message)),
            (r) => {emit(UserListLoaded(r))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnUserAdd>((event, emit) async {
      emit(UserLoading());
      final result = await _addUser.execute(
          event.name, event.username, event.email, event.enabled);

      result.fold(
          (l) => emit(UserError(l.message)), (r) => {emit(UserStart())});
    });
    on<OnUserEdit>((event, emit) async {
      emit(UserLoading());

      final user = User(
          id: event.id,
          name: event.name,
          username: event.username,
          email: event.email,
          enabled: event.enabled,
          builtIn: false);

      final result = await _updateUser.execute(event.id, user);
      result.fold(
          (l) => emit(UserError(l.message)), (r) => {emit(UserStart())});
    });
    on<OnUserEnable>((event, emit) async {
      emit(UserLoading());

      final result = await _enableUser.execute(event.id, event.enabled);
      result.fold(
          (l) => emit(UserError(l.message)), (r) => {emit(UserLoaded(r))});
    });
    on<OnUserDelete>((event, emit) async {
      emit(UserLoading());

      final result = await _deleteUser.execute(event.id);
      result.fold(
          (l) => emit(UserError(l.message)), (r) => {emit(UserStart())});
    });
    on<OnUserShowPasswordModifyForm>((event, emit) async {
      emit(UserLoading());
      
      emit(ModifyUserPassword(event.user));
      
    });
    on<OnUserSaveNewPassword>((event, emit) async {
      emit(UserLoading());
      final result = await _getUser.execute(event.password);

      result.fold(
          (l) => emit(UserError(l.message)), (r) => {emit(UserStart())});
    });
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
