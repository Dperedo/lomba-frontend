import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/post/get_post.dart';
import 'package:lomba_frontend/presentation/post/bloc/post_event.dart';
import 'package:lomba_frontend/presentation/post/bloc/post_state.dart';
import 'package:rxdart/rxdart.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPost _getPost;

  PostBloc(
    this._getPost,
    ) : super(const PostStart('', '')) {//PostStart('', '')
    on<OnPostStarter>((event, emit) => emit(PostStart('', event.postId)));

    on<OnPostLoad>(
      (event, emit) async {
        emit(PostLoading());

        /*String userId = event.id ?? '';
        SessionModel? sessionModel;
        if (event.id == null) {
          final result = await _getSession.execute();
          result.fold((l) => emit(PostError(l.message)),
              (r) => userId = r.getUserId()!);
        }*/

        final resultPost = await _getPost.execute(event.postId);

        resultPost.fold((l) => emit(PostError(l.message)),
            (r) => {emit(PostLoaded(r))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}