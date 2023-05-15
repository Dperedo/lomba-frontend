import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/entities/workflow/imagecontent.dart';
import 'package:lomba_frontend/domain/entities/workflow/textcontent.dart';
import 'package:lomba_frontend/domain/entities/workflow/videocontent.dart';
import 'package:lomba_frontend/domain/usecases/post/add_text_post.dart';
import 'package:lomba_frontend/domain/usecases/local/get_has_login.dart';
import 'package:lomba_frontend/domain/usecases/local/get_session_status.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/constants.dart';
import '../../../data/models/session_model.dart';
import '../../../domain/usecases/post/add_multi_post.dart';
import 'addcontent_event.dart';
import 'addcontent_state.dart';

class AddContentBloc extends Bloc<AddContentEvent, AddContentState> {
  final AddMultiPost _addMultiPost;
  final GetHasLogIn _hasLogIn;
  final GetSession _getSession;

  AddContentBloc(
    this._addMultiPost,
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

          String filetype = '';
          if (event.cloudFile != null) {
            filetype = event.cloudFile!.filetype;
          }

          final result = await _addMultiPost.execute(
              orgaId!,
              userId!,
              event.text == '' ? null : TextContent(text: event.text),
              event.cloudFile != null &&
                      event.cloudFile!.filetype.startsWith("image")
                  ? ImageContent(
                      url: event.cloudFile!.url,
                      size: event.cloudFile!.size,
                      filetype: event.cloudFile!.filetype,
                      cloudFileId: event.cloudFile!.id,
                      height: event.mediaHeight,
                      width: event.mediaWidth,
                      description: '')
                  : null,
              event.cloudFile != null &&
                      event.cloudFile!.filetype.startsWith("video")
                  ? VideoContent(
                      url: event.cloudFile!.url,
                      size: event.cloudFile!.size,
                      filetype: event.cloudFile!.filetype,
                      cloudFileId: event.cloudFile!.id,
                      width: event.mediaWidth,
                      height: event.mediaHeight,
                      description: '',
                      thumbnailUrl: '',
                      thumbnailSize: 0,
                      thumbnailCloudFileId: '')
                  : null,
              null,
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
