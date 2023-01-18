import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/features/profile/presentation/bloc/profile_event.dart';
import 'package:lomba_frontend/features/profile/presentation/bloc/profile_state.dart';
import 'package:rxdart/rxdart.dart';
import '../../../users/domain/usecases/get_user.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{
  final GetUser _getUser;

  ProfileBloc(this._getUser):super(ProfileStart()){
    on<OnProfileLoad>(
      (event, emit) async {
        emit(ProfileLoading());
        final result = await _getUser.execute(event.id);

        result.fold(
            (l) => emit(ProfileError(l.message)), (r) => {emit(ProfileLoaded(r))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

}