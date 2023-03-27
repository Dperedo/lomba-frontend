import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/domain/usecases/storage/upload_file.dart';

class AddContentLiveCubit extends Cubit<AddContentLiveState> {
  final UploadFile uploadFile;
  AddContentLiveCubit(this.uploadFile)
      : super(AddContentLiveState(
            const <String, bool>{"keepasdraft": false}, "", Uint8List(0), ""));

  void changeValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }

  void showImage(String name, Uint8List image) async {
    emit(state.copyWithImage(name: name, image: image));
    await uploadFile.execute(image, name, "1", "1");
    //.then((value) => value.fold((l) {
    //            emit(state.copyWithImage(name: name, image: image));
    //        }, (r) {
    //        emit(state.copyWithImage(name: name, image: image));
    //    }));
  }

  void removeImage() {
    emit(state.copyWithImage(name: "", image: Uint8List(0)));
  }
}

class AddContentLiveState extends Equatable {
  final Map<String, bool> checks;
  final Uint8List imagefile;
  final String filename;
  final String message;
  @override
  List<Object?> get props => [checks, imagefile, filename, message];

  const AddContentLiveState(
      this.checks, this.filename, this.imagefile, this.message);

  AddContentLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    Map<String, bool> nchecks = <String, bool>{};
    nchecks.addAll(checks);
    nchecks[name] = changeState;
    final ous = AddContentLiveState(nchecks, filename, imagefile, "");
    return ous;
  }

  AddContentLiveState copyWithImage(
      {required String name, required Uint8List image}) {
    final ous = AddContentLiveState(checks, name, image, "Subiendo...");
    return ous;
  }
}
