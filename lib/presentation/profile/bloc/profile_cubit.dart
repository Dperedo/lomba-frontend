import 'dart:async';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/storage/get_cloudfile.dart';
import 'package:lomba_frontend/domain/usecases/storage/upload_cloudfile_profile.dart';

import '../../../domain/entities/storage/cloudfile.dart';
import '../../../domain/usecases/storage/register_cloudfile_profile.dart';

class ProfileLiveCubit extends Cubit<ProfileLiveState> {
  final UploadFileProfile _uploadFileProfile;
  final RegisterCloudFileProfile _registerCloudFileProfile;
  final GetCloudFile _getCloudFile;
  late int secondsPassed;
  ProfileLiveCubit(
    this._uploadFileProfile,
    this._getCloudFile,
    this._registerCloudFileProfile,
  ) : super(ProfileLiveState( "", "",
            "", Uint8List(0), "", false, false, null, 0, 0));

  void showImage(BuildContext context, Uint8List image, String userId, String orgaId) async {
    var cloudFileId = '';
    var cloudFileIdThumbnail = '';
    secondsPassed = 0;
    var decodedImage = await decodeImageFromList(image);

    if(decodedImage.height>2000 || decodedImage.height>2000) {
      const snackBar = SnackBar(content: Text('El tamaño de la imagen es muy grande'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    } else if (image.lengthInBytes > 5500000) {
      const snackBar = SnackBar(content: Text('El peso de la imagen es muy grande'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    final imageDoubleHeight = (decodedImage.height * 450) / decodedImage.width;
    final imageHeight = imageDoubleHeight.toInt();
    const imageWidth = 450;

    final resultRegister = await _registerCloudFileProfile.execute(userId, orgaId);
    resultRegister.fold((l) => null, (r) {cloudFileId = r[0].id; cloudFileIdThumbnail = r[1].id;});

    await _uploadFileProfile.execute(userId, image, cloudFileId);

    emit(state.copyWithMedia(
        cloudFileId: cloudFileId,
        cloudFileIdThumbnail: cloudFileIdThumbnail,
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
    emit(state.copyWithRemove(cloudFileId: "", cloudFileIdThumbnail: "", media: Uint8List(0)));
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
  final String fileIdThumbnail;
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
        fileIdThumbnail,
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
      this.fileIdThumbnail,
      this.filename,
      this.mediafile,
      this.message,
      this.showLocalProgress,
      this.showRemoteProgress,
      this.cloudFile,
      this.mediaHeight,
      this.mediaWidth,);

  ProfileLiveState copyWithMedia({
    required String cloudFileId,
    required String cloudFileIdThumbnail,
    required Uint8List media,
    required int mediaHeight,
    required int mediaWidth,
  }) {
    final ous = ProfileLiveState(cloudFileId, cloudFileIdThumbnail, filename, media, "Subiendo...",
        true, true, null, mediaHeight, mediaWidth,);
    return ous;
  }

  ProfileLiveState copyWithRemove(
      {required String cloudFileId, required String cloudFileIdThumbnail, required Uint8List media}) {
    final ous = ProfileLiveState(cloudFileId, cloudFileIdThumbnail, "", media, "Subiendo...", false,
        false, null, 0, 0,);
    return ous;
  }

  ProfileLiveState copyWithProgressIndicator(
      {required bool localProgress, required bool remoteProgress}) {
    final ous = ProfileLiveState(fileId, fileIdThumbnail, filename, mediafile, "",
        localProgress, remoteProgress, null, 0, 0,);
    return ous;
  }

  ProfileLiveState copyWithCloudFile({
    required CloudFile cloudFile,
  }) {
    final ous = ProfileLiveState(fileId, fileIdThumbnail, filename, mediafile, "",
        false, false, cloudFile, mediaHeight, mediaWidth,);
    return ous;
  }

}