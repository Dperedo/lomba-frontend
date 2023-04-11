import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/storage/get_cloudfile.dart';
import 'package:lomba_frontend/domain/usecases/storage/register_cloudfile.dart';
import 'package:lomba_frontend/domain/usecases/storage/upload_cloudfile.dart';
import 'package:video_player/video_player.dart';

import '../../../domain/entities/storage/cloudfile.dart';

class AddContentLiveCubit extends Cubit<AddContentLiveState> {
  final UploadFile uploadFile;
  final RegisterCloudFile _registerCloudFile;
  final GetCloudFile _getCloudFile;
  late int secondsPassed;
  AddContentLiveCubit(
    this.uploadFile,
    this._getCloudFile,
    this._registerCloudFile,
  ) : super(AddContentLiveState(
            const <String, bool>{"keepasdraft": false},
            "",
            "",
            Uint8List(0),
            "",
            false,
            false,
            null,
            0,
            0));

  void changeValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }

  void showImageOrVideo(
      Uint8List mediaFile, String localFileName, String userId, String orgaId) {
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
    final imageHeight = decodedImage.height;
    final imageWidth = decodedImage.width;
    final resultRegister = await _registerCloudFile.execute(userId, orgaId);
    resultRegister.fold((l) => null, (r) => cloudFileId = r.id);
    await uploadFile.execute(image, cloudFileId);
    emit(state.copyWithMedia(id: cloudFileId, media: image));
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      secondsPassed++;
      print(secondsPassed);
      final resultCloudFile = await _getCloudFile.execute(cloudFileId);
      resultCloudFile.fold((l) => null, (r) {
        if (r.size != 0) {
          timer.cancel();
          emit(state.copyWithCloudFile(
              cloudFile: r, mediaHeight: imageHeight, mediaWidth: imageWidth));
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
    //VideoPlayerController controller = videoPlayer(videoByte);
    /*final File videoFile = File.fromRawPath(videoByte);
    final controller = VideoPlayerController.file(videoFile);

    //await controller.initialize();
    final videoHeight = controller.value.size.height.toInt();
    final videoWidth = controller.value.size.width.toInt();*/

    final resultRegister = await _registerCloudFile.execute(userId, orgaId);
    resultRegister.fold((l) => null, (r) => cloudFileId = r.id);

    await uploadFile.execute(videoByte, cloudFileId);
    emit(state.copyWithMedia(id: cloudFileId, media: videoByte));

    Timer.periodic(const Duration(seconds: 2), (timer) async {
      secondsPassed++;
      print(secondsPassed);

      final resultCloudFile = await _getCloudFile.execute(cloudFileId);
      resultCloudFile.fold((l) => null, (r) {
        if (r.size != 0) {
          timer.cancel();
          emit(state.copyWithCloudFile(
              cloudFile: r, mediaHeight: 200, mediaWidth: 200));
        } else if (secondsPassed >= 10) {
          timer.cancel();
          emit(state.copyWithProgressIndicator(
              localProgress: false, remoteProgress: false));
        }
      });
    });
  }

  /*VideoPlayerController videoPlayer(Uint8List video) {
    final File videoFile = File.fromRawPath(video);
    final controller = VideoPlayerController.file(videoFile);
    return controller;
  }*/

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

}

class AddContentLiveState extends Equatable {
  final Map<String, bool> checks;
  final String fileId;
  final String filename;
  final Uint8List mediafile;

  final String message;
  final bool showLocalProgress;
  final bool showRemoteProgress;

  final CloudFile? cloudFile;

  final int mediaHeight;
  final int mediaWidth;
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
      ];

  const AddContentLiveState(
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
  );

  AddContentLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    Map<String, bool> nchecks = <String, bool>{};
    nchecks.addAll(checks);
    nchecks[name] = changeState;
    final ous = AddContentLiveState(
        nchecks,
        fileId,
        filename,
        mediafile,
        "",
        showLocalProgress,
        showRemoteProgress,
        null,
        0,
        0);
    return ous;
  }

  AddContentLiveState copyWithMedia(
      {required String id, required Uint8List media}) {
    final ous = AddContentLiveState(
        checks,
        id,
        filename,
        media,
        "Subiendo...",
        true,
        true,
        null,
        0,
        0);
    return ous;
  }

  AddContentLiveState copyWithRemove(
      {required String id, required Uint8List media}) {
    final ous = AddContentLiveState(
        checks,
        id,
        "",
        media,
        "Subiendo...",
        false,
        false,
        null,
        0,
        0);
    return ous;
  }

  AddContentLiveState copyWithProgressIndicator(
      {required bool localProgress, required bool remoteProgress}) {
    final ous = AddContentLiveState(
        checks,
        fileId,
        filename,
        mediafile,
        "",
        localProgress,
        remoteProgress,
        null,
        0,
        0);
    return ous;
  }

  AddContentLiveState copyWithCloudFile({
    required CloudFile cloudFile,
    required int mediaHeight,
    required int mediaWidth,
  }) {
    final ous = AddContentLiveState(
        checks,
        fileId,
        cloudFile.name,
        mediafile,
        "",
        false,
        false,
        cloudFile,
        mediaHeight,
        mediaWidth,);
    return ous;
  }

}
