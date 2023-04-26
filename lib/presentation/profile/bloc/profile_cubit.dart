import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/storage/get_cloudfile.dart';
import 'package:lomba_frontend/domain/usecases/storage/register_cloudfile.dart';
import 'package:lomba_frontend/domain/usecases/storage/upload_cloudfile.dart';

import '../../../domain/entities/storage/cloudfile.dart';

class ProfileLiveCubit extends Cubit<ProfileLiveState> {
  final UploadFile uploadFile;
  final RegisterCloudFile _registerCloudFile;
  final GetCloudFile _getCloudFile;
  late int secondsPassed;
  ProfileLiveCubit(
    this.uploadFile,
    this._getCloudFile,
    this._registerCloudFile,
  ) : super(ProfileLiveState( "",
            "", Uint8List(0), "", false, false, null, 0, 0));

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
      print(secondsPassed);
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

class ProfileLiveState extends Equatable {
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

  const ProfileLiveState(
      this.fileId,
      this.filename,
      this.mediafile,
      this.message,
      this.showLocalProgress,
      this.showRemoteProgress,
      this.cloudFile,
      this.mediaHeight,
      this.mediaWidth,);

  ProfileLiveState copyWithMedia({
    required String id,
    required Uint8List media,
    required int mediaHeight,
    required int mediaWidth,
  }) {
    final ous = ProfileLiveState(id, filename, media, "Subiendo...",
        true, true, null, mediaHeight, mediaWidth,);
    return ous;
  }

  ProfileLiveState copyWithRemove(
      {required String id, required Uint8List media}) {
    final ous = ProfileLiveState(id, "", media, "Subiendo...", false,
        false, null, 0, 0,);
    return ous;
  }

  ProfileLiveState copyWithProgressIndicator(
      {required bool localProgress, required bool remoteProgress}) {
    final ous = ProfileLiveState(fileId, filename, mediafile, "",
        localProgress, remoteProgress, null, 0, 0,);
    return ous;
  }

  ProfileLiveState copyWithCloudFile({
    required CloudFile cloudFile,
  }) {
    final ous = ProfileLiveState(fileId, filename, mediafile, "",
        false, false, cloudFile, mediaHeight, mediaWidth,);
    return ous;
  }

}