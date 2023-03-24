import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/data/models/session_model.dart';
import 'package:lomba_frontend/domain/usecases/local/get_session_status.dart';
import 'package:lomba_frontend/presentation/profile/bloc/profile_event.dart';
import 'package:lomba_frontend/presentation/profile/bloc/profile_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/users/exists_profile.dart';
import '../../../domain/usecases/users/exists_user.dart';
import '../../../domain/usecases/users/get_user.dart';
import '../../../domain/usecases/users/update_profile.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUser _getUser;
  final GetSession _getSession;
  final UpdateProfile _updateProfile;
  final ExistsProfile _existsProfile;

  ProfileBloc(
    this._getUser,
    this._getSession,
    this._updateProfile,
    this._existsProfile,
    ) : super(const ProfileStart('')) {
    on<OnProfileStarter>((event, emit) => emit(const ProfileStart('')));

    on<OnProfileLoad>(
      (event, emit) async {
        emit(ProfileLoading());

        String userId = event.id ?? '';
        SessionModel? sessionModel;
        if (event.id == null) {
          final result = await _getSession.execute();
          result.fold((l) => emit(ProfileError(l.message)),
              (r) => userId = r.getUserId()!);
        }

        final resultUser = await _getUser.execute(userId);

        resultUser.fold((l) => emit(ProfileError(l.message)),
            (r) => {emit(ProfileLoaded(r))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );
    on<OnProfileEditPrepare>((event, emit) async {
      emit(ProfileEditing(false, false, event.user));
    });
    on<OnProfileEdit>((event, emit) async {
      emit(ProfileLoading());

      final user = User(
          id: event.id,
          name: event.name,
          username: event.username,
          email: event.email,
          enabled: true,
          builtIn: false);

      final result = await _updateProfile.execute(event.id, user);
      result.fold(
          (l) => emit(ProfileError(l.message)),
          (r) => {
                emit(ProfileStart(" El usuario ${event.username} fue actualizado"))
              });
    });
    on<OnProfileValidate>((event, emit) async {
      String userNoId = '';
      if (event.username != "" || event.email != "") {
        final result =
            await _existsProfile.execute(userNoId, event.username, event.email);

        result.fold((l) => emit(ProfileError(l.message)), (r) {
          if (r != null) {
            event.state.existEmail = (r.email == event.email);
            event.state.existUserName = (r.username == event.username);
          } else {
            event.state.existEmail = false;
            event.state.existUserName = false;
          }
        });
      }
    });
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
