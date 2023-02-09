import 'package:flutter_bloc/flutter_bloc.dart';

class UploadedLiveCubit extends Cubit<UploadedLiveState> {
  UploadedLiveCubit() : super(UploadedLiveState("onlydrafts", false));

  void changeValue(String name, bool value) {
    emit(state.copyWith(name: name, changeState: value));
  }
}

class UploadedLiveState {
  Map<String, bool> checks = <String, bool>{};
  UploadedLiveState(String name, bool changeState) {
    checks.clear();
    checks.addEntries(<String, bool>{"onlydrafts": false}.entries);
    checks[name] = changeState;
  }

  UploadedLiveState copyWith(
      {required String name, required bool changeState}) {
    final ous = UploadedLiveState(name, changeState);
    ous.checks = checks;
    ous.checks[name] = changeState;
    return ous;
  }
}
