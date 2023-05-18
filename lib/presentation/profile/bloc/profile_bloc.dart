import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/local/get_session_status.dart';
import 'package:lomba_frontend/presentation/profile/bloc/profile_event.dart';
import 'package:lomba_frontend/presentation/profile/bloc/profile_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/users/exists_profile.dart';
import '../../../domain/usecases/users/get_user.dart';
import '../../../domain/usecases/users/update_profile.dart';
import '../../../domain/usecases/users/update_profile_password.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUser _getUser;
  final GetSession _getSession;
  final UpdateProfile _updateProfile;
  final ExistsProfile _existsProfile;
  final UpdateProfilePassword _updateProfilePassword;

  ProfileBloc(
    this._getUser,
    this._getSession,
    this._updateProfile,
    this._existsProfile,
    this._updateProfilePassword
    ) : super(const ProfileStart('')) {
    on<OnProfileStarter>((event, emit) => emit(const ProfileStart('')));

    on<OnProfileLoad>(
      (event, emit) async {
        emit(ProfileLoading());

        String userId = event.userId ?? '';
        String orgaId = event.orgaId ?? '';
        if (event.userId == null || event.orgaId == null) {
          final result = await _getSession.execute();
          result.fold((l) => emit(ProfileError(l.message)),
            (r) {
              userId = r.getUserId()!;
              orgaId = r.getOrgaId()!;
            });
        }

        final resultUser = await _getUser.execute(userId);

        resultUser.fold((l) => emit(ProfileError(l.message)),
            (r) => {emit(ProfileLoaded(r, orgaId))});
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
          builtIn: false,
          pictureUrl: null,
          pictureCloudFileId: null,
          pictureThumbnailUrl: null,
          pictureThumbnailCloudFileId: null,);

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
    on<OnProfileShowPasswordModifyForm>((event, emit) async {
      emit(ProfileLoading());
      
      emit(ProfileUpdatePassword(event.user));
    });
    on<OnProfileSaveNewPassword>((event, emit) async {
      emit(ProfileLoading());

      final result =
          await _updateProfilePassword.execute(event.user.id, event.password);

      result.fold((l) => emit(ProfileError(l.message)),
          (r) => {emit(const ProfileStart(" Contraseña Modificada"))});
    });

    on<OnProfileSaveImagen>((event, emit) async {
      emit(ProfileLoading());

      final user = User(
          id: event.user.id,
          name: event.user.name,
          username: event.user.username,
          email: event.user.email,
          enabled: event.user.enabled,
          builtIn: event.user.builtIn,
          pictureUrl: event.imageUrl==''||event.imageUrl==null ? null : event.imageUrl,
          pictureCloudFileId: event.cloudFileId==''||event.cloudFileId==null ? null : event.cloudFileId,
          pictureThumbnailUrl: event.imageUrlThumbnail==''||event.imageUrlThumbnail==null ? null : event.imageUrlThumbnail,
          pictureThumbnailCloudFileId: event.cloudFileIdThumbnail==''||event.cloudFileIdThumbnail==null ? null : event.cloudFileIdThumbnail,);

      final result =
          await _updateProfile.execute(event.user.id, user);

      result.fold((l) => emit(ProfileError(l.message)),
          (r) => {emit(const ProfileStart("Imagen de Perfil Guardada"))});
    });
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
