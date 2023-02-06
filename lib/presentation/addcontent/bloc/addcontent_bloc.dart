import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/entities/flows/textcontent.dart';
import 'package:lomba_frontend/domain/usecases/flow/add_text_post.dart';
import 'package:lomba_frontend/domain/usecases/local/get_has_login.dart';
import 'package:lomba_frontend/domain/usecases/local/get_session_status.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/models/session_model.dart';
import 'addcontent_event.dart';
import 'addcontent_state.dart';

class AddContentBloc extends Bloc<AddContentEvent, AddContentState> {
  final AddTextPost _addTextPost;
  final GetHasLogIn _hasLogIn;
  final GetSession _getSession;

  AddContentBloc(
    this._addTextPost, this._hasLogIn, this._getSession,
  ): super(AddContentEmpty()) {
    on<OnAddContentAdd>((event, emit) async {
      emit(AddContentLoading());
      const flowId = '00000111-0111-0111-0111-000000000111';
      SessionModel? session;     
      bool login = false;

      final resultLogIn = await _hasLogIn.execute();
        resultLogIn.fold((failure) => {}, (r) => {login = r});

      if(login) {
        final resultSession = await _getSession.execute();
        resultSession.fold(
              (failure) => {},
              (r) => {
                    session = SessionModel(
                        token: r.token, username: r.username, name: r.name)
                  });

        final userId = session?.getUserId();
        final orgaId = session?.getOrgaId();

        final result = await _addTextPost.execute(orgaId!, userId!, event.text as TextContent, event.title, flowId, event.isDraft);

        result.fold((l) => null, (r) => null);
      }

    },
    transformer: debounce(const Duration(milliseconds: 0)),
    );
  }

  //result.fold;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}