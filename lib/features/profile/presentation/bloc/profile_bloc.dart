import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/data/models/session_model.dart';
import 'package:lomba_frontend/core/domain/usecases/get_session_status.dart';
import 'package:lomba_frontend/features/profile/presentation/bloc/profile_event.dart';
import 'package:lomba_frontend/features/profile/presentation/bloc/profile_state.dart';
import 'package:rxdart/rxdart.dart';
import '../../../users/domain/usecases/get_user.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{
  final GetUser _getUser;
  final GetSession _getSession;

  ProfileBloc(this._getUser, this._getSession):super(ProfileStart()){
    on<OnProfileLoad>(
      (event, emit) async {
        emit(ProfileLoading());

        String userId = event.id ?? '';
        SessionModel? sessionModel;
        if (event.id == null){
          final result = await _getSession.execute();
          result.fold((l) => emit(ProfileError(l.message)), (r) => userId = r.getUserId()!);
        }

        final resultUser = await _getUser.execute(userId);
        
        resultUser.fold(
            (l) => emit(ProfileError(l.message)), (r) => {emit(ProfileLoaded(r))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

}