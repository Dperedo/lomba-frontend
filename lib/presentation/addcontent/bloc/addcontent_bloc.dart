import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/entities/workflow/textcontent.dart';
import 'package:lomba_frontend/domain/usecases/post/add_text_post.dart';
import 'package:lomba_frontend/domain/usecases/local/get_has_login.dart';
import 'package:lomba_frontend/domain/usecases/local/get_session_status.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/constants.dart';
import '../../../data/models/session_model.dart';
import 'addcontent_event.dart';
import 'addcontent_state.dart';

class AddContentBloc extends Bloc<AddContentEvent, AddContentState> {
  final AddTextPost _addTextPost;
  final GetHasLogIn _hasLogIn;
  final GetSession _getSession;

  AddContentBloc(
    this._addTextPost,
    this._hasLogIn,
    this._getSession,
  ) : super(AddContentStart()) {
    on<OnAddContentStarter>((event, emit) => emit(AddContentStart()));

    on<OnAddContentAdd>(
      (event, emit) async {
        emit(AddContentLoading());
        SessionModel? session;
        bool login = false;
        const String flowId = Flows.votationFlowId;

        final resultLogIn = await _hasLogIn.execute();
        resultLogIn.fold((failure) => {}, (r) => {login = r});

        if (login) {
          final resultSession = await _getSession.execute();
          resultSession.fold(
              (l) => emit(AddContentError(l.message)),
              (r) => {
                    session = SessionModel(
                        token: r.token, username: r.username, name: r.name)
                  });

          final userId = session?.getUserId();
          final orgaId = session?.getOrgaId();

          final result = await _addTextPost.execute(
              orgaId!,
              userId!,
              TextContent(text: event.text),
              event.title,
              flowId,
              event.isDraft);

          result.fold((l) => emit(AddContentError(l.message)),
              (r) => emit(AddContentUp()));
        }
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnAddContentUp>(
      (event, emit) async {
        //-------------------
        SessionModel? session;
        final resultSession = await _getSession.execute();
          resultSession.fold(
              (l) => emit(AddContentError(l.message)),
              (r) => {
                    session = SessionModel(
                        token: r.token, username: r.username, name: r.name)
                  });

          final userId = session?.getUserId();
          final orgaId = session?.getOrgaId();
        //-------------------
        emit(AddContentEdit(userId!, orgaId!));
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );

    on<OnAddContentFile>(
      (event, emit) {
        emit(AddContentFile(event.name, event.file));
      },
      transformer: debounce(const Duration(milliseconds: 0)),
    );
  }

  //result.fold;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
