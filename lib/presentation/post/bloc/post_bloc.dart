import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/post/get_post.dart';
import 'package:lomba_frontend/presentation/post/bloc/post_event.dart';
import 'package:lomba_frontend/presentation/post/bloc/post_state.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecases/local/get_has_login.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPost _getPost;
  final GetHasLogIn _hasLogin;
  final FirebaseAuth _firebaseAuthInstance;

  PostBloc(
    this._getPost,
    this._hasLogin,
    this._firebaseAuthInstance,
    ) : super(const PostStart('', '')) {//PostStart('', '')
    on<OnPostStarter>((event, emit) => emit(PostStart('', event.postId)));

    on<OnPostLoad>(
      (event, emit) async {
        emit(PostLoading());

        var validLogin = false;

        final result = await _hasLogin.execute();

        result.fold((l) => {emit(PostError(l.message))}, (valid) async {
          validLogin = valid;
          if (!valid) {
            try {
              await signInAnonymously();
              // ignore: empty_catches
            } catch (e) {}
          }
        });

        final resultPost = await _getPost.execute(event.postId);

        resultPost.fold((l) => emit(PostError(l.message)),
            (r) => {emit(PostLoaded(r, validLogin))});
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  Future<UserCredential> signInAnonymously() async {
    return await _firebaseAuthInstance.signInAnonymously();
  }
}