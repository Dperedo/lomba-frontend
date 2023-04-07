import 'dart:async';
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
    this._registerCloudFile,)
      : super(AddContentLiveState(
            const <String, bool>{"keepasdraft": false}, "", Uint8List(0), "", Uint8List(0), "", false, false, null, 0, 0));

  void changeValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
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
    emit(state.copyWithImage(name: cloudFileId, image: image));
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      secondsPassed++;
      print(secondsPassed);
      final resultCloudFile = await _getCloudFile.execute(cloudFileId);
      resultCloudFile.fold((l) => null, (r) {
        if(r.size != 0) {
          timer.cancel();
          emit(state.copyWithCloudFile(cloudFile: r, imageHeight:imageHeight, imageWidth:imageWidth));
        }
        else if (secondsPassed >= 10) {
          timer.cancel();
          emit(state.copyWithProgressIndicator(localProgress: false, remoteProgress: false));
        }
      });
    });
  }

  void showVideo(Uint8List video, String userId, String orgaId) async {
    var cloudFileId = '';
    secondsPassed = 0;
    VideoPlayerController controller = VideoPlayerController.memory(video);
    await controller.initialize();
    final imageHeight = controller.value.size.height.toInt();
    final imageWidth = controller.value.size.width.toInt();
    final resultRegister = await _registerCloudFile.execute(userId, orgaId);
    resultRegister.fold((l) => null, (r) => cloudFileId = r.id);
    await uploadFile.execute(video, cloudFileId);
    emit(state.copyWithVideo(nameVideo: cloudFileId, video: video));
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      secondsPassed++;
      print(secondsPassed);
      final resultCloudFile = await _getCloudFile.execute(cloudFileId);
      resultCloudFile.fold((l) => null, (r) {
        if(r.size != 0) {
          timer.cancel();
          emit(state.copyWithCloudFile(cloudFile: r, imageHeight:imageHeight, imageWidth:imageWidth));
        }
        else if (secondsPassed >= 10) {
          timer.cancel();
          emit(state.copyWithProgressIndicator(localProgress: false, remoteProgress: false));
        }
      });
    });
  }

  void removeImage() {
    emit(state.copyWithImage(name: "", image: Uint8List(0)));
  }

  void removeVideo() {
    emit(state.copyWithVideo(nameVideo: "", video: Uint8List(0)));
  }

  void startProgressIndicators() {
    emit(state.copyWithProgressIndicator(localProgress: true, remoteProgress: true));
  }

  void stopLocalProgressIndicators() {
    emit(state.copyWithProgressIndicator(localProgress: false, remoteProgress: true));
  }

  void stopRemoteProgressIndicators() {
    emit(state.copyWithProgressIndicator(localProgress: false, remoteProgress: false));
  }
}

class AddContentLiveState extends Equatable {
  final Map<String, bool> checks;
  final String filename;
  final Uint8List imagefile;
  final String filenameVideo;
  final Uint8List videofile;
  final String message;
  final bool showLocalProgress;
  final bool showRemoteProgress;
  final CloudFile? cloudFile;
  final int imageHeight;
  final int imageWidth;
  @override
  List<Object?> get props => [
    checks,
    filename,
    imagefile,
    filenameVideo,
    videofile,
    message,
    showLocalProgress,
    showRemoteProgress,
    cloudFile,
    imageHeight,
    imageWidth
  ];

  const AddContentLiveState(
      this.checks,
      this.filename,
      this.imagefile,
      this.filenameVideo,
      this.videofile,
      this.message,
      this.showLocalProgress,
      this.showRemoteProgress,
      this.cloudFile,
      this.imageHeight,
      this.imageWidth
    );

  AddContentLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    Map<String, bool> nchecks = <String, bool>{};
    nchecks.addAll(checks);
    nchecks[name] = changeState;
    final ous = AddContentLiveState(nchecks, filename, imagefile, filenameVideo, videofile, "",showLocalProgress, showRemoteProgress, null,0,0);
    return ous;
  }

  AddContentLiveState copyWithImage(
      {required String name, required Uint8List image}) {
    final ous = AddContentLiveState(checks, name, image, filenameVideo, videofile, "Subiendo...",true, true, null,0,0);
    return ous;
  }

  AddContentLiveState copyWithVideo(
      {required String nameVideo, required Uint8List video}) {
    final ous = AddContentLiveState(checks, filename, imagefile, nameVideo, video, "Subiendo...",true, true, null,0,0);
    return ous;
  }

  AddContentLiveState copyWithProgressIndicator(
      {required bool localProgress, required bool remoteProgress}) {
    final ous = AddContentLiveState(checks, filename, imagefile, filenameVideo, videofile, "", localProgress, remoteProgress, null,0,0);
    return ous;
  }

  AddContentLiveState copyWithCloudFile(
      {required CloudFile cloudFile, required int imageHeight, required int imageWidth, }) {
    final ous = AddContentLiveState(checks, filename, imagefile, filenameVideo, videofile, "", false, false, cloudFile, imageHeight, imageWidth);
    return ous;
  }
}
