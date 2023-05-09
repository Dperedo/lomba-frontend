import 'dart:async';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/storage/cloudfile.dart';
import '../../../domain/entities/workflow/comment.dart';
import '../../../domain/usecases/comment/delete_comment.dart';
import '../../../domain/usecases/comment/get_comments_post.dart';
import '../../../domain/usecases/storage/get_cloudfile.dart';
import '../../../domain/usecases/storage/register_cloudfile.dart';
import '../../../domain/usecases/storage/upload_cloudfile.dart';

class DetailedListLiveCubit extends Cubit<DetailedListLiveState> {
  final UploadFile uploadFile;
  final RegisterCloudFile _registerCloudFile;
  final GetCloudFile _getCloudFile;
  final GetComments _getComments;
  final DeleteComment _deleteComment;
  late int secondsPassed;
  DetailedListLiveCubit(
    this.uploadFile,
    this._getCloudFile,
    this._registerCloudFile,
    this._getComments,
    this._deleteComment,
  ) : super(DetailedListLiveState(
            const <String, bool>{'enabled': false, 'disabled': false},
            "",
            "",
            Uint8List(0),
            "",
            false,
            false,
            null,
            0,
            0,
            "",
            "",
            []));

  void changeCheckValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }

  void showImageOrVideo(
      Uint8List mediaFile, String localFileName, String userId, String orgaId) {
    emit(state.copyWithName(name: localFileName));
    if (localFileName.endsWith(".jpg") ||
        localFileName.endsWith(".jpeg") ||
        localFileName.endsWith(".gif") ||
        localFileName.endsWith(".png")) {
      showImage(mediaFile, userId, orgaId);
    } else if (localFileName.endsWith(".mp4") ||
        localFileName.endsWith(".mov") ||
        localFileName.endsWith(".wmv") ||
        localFileName.endsWith(".avi")) {
      showVideo(mediaFile, userId, orgaId);
    }
  }

  void showImage(Uint8List image, String userId, String orgaId) async {
    var cloudFileId = '';
    secondsPassed = 0;
    var decodedImage = await decodeImageFromList(image);

    final imageDoubleHeight = (decodedImage.height * 450) / decodedImage.width;
    final imageHeight = imageDoubleHeight.toInt();
    const imageWidth = 450;

    final resultRegister = await _registerCloudFile.execute(userId, orgaId);
    resultRegister.fold((l) => null, (r) => cloudFileId = r.id);

    await uploadFile.execute(image, cloudFileId);

    emit(state.copyWithMedia(
        id: cloudFileId,
        media: image,
        mediaHeight: imageHeight,
        mediaWidth: imageWidth));
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      secondsPassed++;

      final resultCloudFile = await _getCloudFile.execute(cloudFileId);
      resultCloudFile.fold((l) => null, (r) {
        if (r.size != 0) {
          timer.cancel();
          emit(state.copyWithCloudFile(cloudFile: r));
        } else if (secondsPassed >= 10) {
          timer.cancel();
          emit(state.copyWithProgressIndicator(
              localProgress: false, remoteProgress: false));
        }
      });
    });
  }

  void showVideo(Uint8List videoByte, String userId, String orgaId) async {
    var cloudFileId = '';
    secondsPassed = 0;

    final resultRegister = await _registerCloudFile.execute(userId, orgaId);
    resultRegister.fold((l) => null, (r) => cloudFileId = r.id);

    await uploadFile.execute(videoByte, cloudFileId);
    //emit(state.copyWithMedia(id: cloudFileId, media: videoByte, mediaHeight: 200, mediaWidth: 200));

    Timer.periodic(const Duration(seconds: 2), (timer) async {
      secondsPassed++;

      final resultCloudFile = await _getCloudFile.execute(cloudFileId);
      resultCloudFile.fold((l) => null, (r) async {
        if (r.size != 0) {
          timer.cancel();
          //final videoInfo = await FlutterVideoInfo().getVideoInfo(r.url);

          emit(state.copyWithMedia(
              id: cloudFileId,
              media: videoByte,
              mediaHeight: 0,
              mediaWidth: 0));
          emit(state.copyWithCloudFile(
            cloudFile: r,
          ));
        } else if (secondsPassed >= 10) {
          timer.cancel();
          emit(state.copyWithProgressIndicator(
              localProgress: false, remoteProgress: false));
        }
      });
    });
  }

  void removeMedia() {
    emit(state.copyWithRemove(id: "", media: Uint8List(0)));
  }

  void startProgressIndicators() {
    emit(state.copyWithProgressIndicator(
        localProgress: true, remoteProgress: true));
  }

  void stopRemoteProgressIndicators() {
    emit(state.copyWithProgressIndicator(
        localProgress: false, remoteProgress: false));
  }

  void changeTitle(String title) {
    emit(state.copyWithTitle(titlePost: title));
  }

  void changeText(String text) {
    emit(state.copyWithText(textPost: text));
  }

  void getComments(String postId) async {
    final resultComments = await _getComments.execute(postId,<String, int>{"created": -1}, 1, 10, 1);
    resultComments.fold((l) => null, (r) {
      emit(state.copyWithGetComments(commentList: r));
    });
  }

  void deleteComment(String userId, String postId, String commentId) async {
    final resultDelete = await _deleteComment.execute(userId, postId, commentId);
    resultDelete.fold((l) => null, (r) {
      getComments(postId);
    });
  }
}

class DetailedListLiveState extends Equatable {
  Map<String, bool> checks; // = <String, bool>{};
  final String fileId;
  final String filename;
  final Uint8List mediafile;

  final String message;
  final bool showLocalProgress;
  final bool showRemoteProgress;

  final CloudFile? cloudFile;

  final int mediaHeight;
  final int mediaWidth;
  final String title;
  final String text;
  final List<Comment> commentList;

  @override
  List<Object?> get props => [
        checks,
        fileId,
        filename,
        mediafile,
        message,
        showLocalProgress,
        showRemoteProgress,
        cloudFile,
        mediaHeight,
        mediaWidth,
        title,
        text,
        commentList,
      ];

  DetailedListLiveState(
      this.checks,
      this.fileId,
      this.filename,
      this.mediafile,
      this.message,
      this.showLocalProgress,
      this.showRemoteProgress,
      this.cloudFile,
      this.mediaHeight,
      this.mediaWidth,
      this.title,
      this.text,
      this.commentList);

  DetailedListLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    Map<String, bool> nchecks = <String, bool>{};
    nchecks.addAll(checks);
    nchecks[name] = changeState;
    if (name == "enabled" && changeState) nchecks["disabled"] = !changeState;
    if (name == "disabled" && changeState) nchecks["enabled"] = !changeState;
    final ous = DetailedListLiveState(
        nchecks,
        fileId,
        filename,
        mediafile,
        message,
        showLocalProgress,
        showRemoteProgress,
        cloudFile,
        mediaHeight,
        mediaWidth,
        title,
        text,
        commentList);
    return ous;
  }

  DetailedListLiveState copyWithMedia({
    required String id,
    required Uint8List media,
    required int mediaHeight,
    required int mediaWidth,
  }) {
    final ous = DetailedListLiveState(checks, id, filename, media,
        "Subiendo...", true, true, null, mediaHeight, mediaWidth, title, text, commentList);
    return ous;
  }

  DetailedListLiveState copyWithRemove(
      {required String id, required Uint8List media}) {
    final ous = DetailedListLiveState(checks, id, "", media, "Subiendo...",
        false, false, null, 0, 0, title, text, commentList);
    return ous;
  }

  DetailedListLiveState copyWithProgressIndicator(
      {required bool localProgress, required bool remoteProgress}) {
    final ous = DetailedListLiveState(checks, fileId, filename, mediafile, "",
        localProgress, remoteProgress, null, 0, 0, title, text, commentList);
    return ous;
  }

  DetailedListLiveState copyWithCloudFile({
    required CloudFile cloudFile,
  }) {
    final ous = DetailedListLiveState(checks, fileId, filename, mediafile, "",
        false, false, cloudFile, mediaHeight, mediaWidth, title, text, commentList);
    return ous;
  }

  DetailedListLiveState copyWithName({
    required String name,
  }) {
    final ous = DetailedListLiveState(
        checks,
        fileId,
        name,
        mediafile,
        message,
        showLocalProgress,
        showRemoteProgress,
        cloudFile,
        mediaHeight,
        mediaWidth,
        title,
        text,
        commentList);
    return ous;
  }

  DetailedListLiveState copyWithTitle({
    required String titlePost,
  }) {
    final ous = DetailedListLiveState(
        checks,
        fileId,
        filename,
        mediafile,
        message,
        showLocalProgress,
        showRemoteProgress,
        cloudFile,
        mediaHeight,
        mediaWidth,
        titlePost,
        text,
        commentList);
    return ous;
  }

  DetailedListLiveState copyWithText({
    required String textPost,
  }) {
    final ous = DetailedListLiveState(
        checks,
        fileId,
        filename,
        mediafile,
        message,
        showLocalProgress,
        showRemoteProgress,
        cloudFile,
        mediaHeight,
        mediaWidth,
        title,
        textPost,
        commentList);
    return ous;
  }

  DetailedListLiveState copyWithGetComments({required List<Comment> commentList}) {
    final ous = DetailedListLiveState(
        checks,
        fileId,
        filename,
        mediafile,
        message,
        showLocalProgress,
        showRemoteProgress,
        cloudFile,
        mediaHeight,
        mediaWidth,
        title,
        text,
        commentList);
    return ous;
  }
}
