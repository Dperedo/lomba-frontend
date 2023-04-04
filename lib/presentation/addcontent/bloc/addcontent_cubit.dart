import 'dart:async';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/storage/get_cloudfile.dart';
import 'package:lomba_frontend/domain/usecases/storage/register_cloudfile.dart';
import 'package:lomba_frontend/domain/usecases/storage/upload_cloudfile.dart';

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
            const <String, bool>{"keepasdraft": false}, "", Uint8List(0), "", false, false, null, 0, 0));

  void changeValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }

  void showImage(Uint8List image, String userId, String orgaId) async {
    var cloudFileId = '';
    secondsPassed = 0;
    var decodedImage = await decodeImageFromList(image);
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
          emit(state.copyWithProgressIndicator(localProgress: false, remoteProgress: false));
          emit(state.copyWithCloudFile(cloudFile: r, imageHeight:decodedImage.height, imageWidth:decodedImage.width));
        }
        if (secondsPassed >= 5) {
          timer.cancel();
          emit(state.copyWithProgressIndicator(localProgress: false, remoteProgress: false));
        }
      });
    });
  }

  void removeImage() {
    emit(state.copyWithImage(name: "", image: Uint8List(0)));
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
  final Uint8List imagefile;
  final String filename;
  final String message;
  final bool showLocalProgress;
  final bool showRemoteProgress;
  final CloudFile? cloudFile;
  final int imageHeight;
  final int imageWidth;
  @override
  List<Object?> get props => [
    checks,
    imagefile,
    filename,
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
    final ous = AddContentLiveState(nchecks, filename, imagefile, "",showLocalProgress, showRemoteProgress, null,0,0);
    return ous;
  }

  AddContentLiveState copyWithImage(
      {required String name, required Uint8List image}) {
    final ous = AddContentLiveState(checks, name, image, "Subiendo...",false, false, null,0,0);
    return ous;
  }

  AddContentLiveState copyWithProgressIndicator(
      {required bool localProgress, required bool remoteProgress}) {
    final ous = AddContentLiveState(checks, filename, imagefile, "", localProgress, remoteProgress, null,0,0);
    return ous;
  }

  AddContentLiveState copyWithCloudFile(
      {required CloudFile cloudFile, required int imageHeight, required int imageWidth}) {
    final ous = AddContentLiveState(checks, filename, imagefile, "", false, false, cloudFile, imageHeight, imageWidth);
    return ous;
  }
}
