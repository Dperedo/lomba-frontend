import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/data/models/session_model.dart';
import 'package:lomba_frontend/domain/usecases/local/get_session_status.dart';
import 'package:lomba_frontend/presentation/profile/bloc/profile_event.dart';
import 'package:lomba_frontend/presentation/profile/bloc/profile_state.dart';
import 'package:rxdart/rxdart.dart';
import '../../../domain/usecases/users/get_user.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUser _getUser;
  final GetSession _getSession;

  ProfileBloc(this._getUser, this._getSession) : super(ProfileStart()) {
    on<OnProfileStarter>((event, emit) => emit(ProfileStart()));

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
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
