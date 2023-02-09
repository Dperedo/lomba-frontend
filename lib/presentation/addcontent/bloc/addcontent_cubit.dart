import 'package:flutter_bloc/flutter_bloc.dart';

class AddContentLiveCubit extends Cubit<AddContentLiveState> {
  AddContentLiveCubit() : super(AddContentLiveState("keepasdraft", false));

  void changeValue(String name, bool value) {
    emit(state.copyWith(name: name, changeState: value));
  }
}

class AddContentLiveState {
  Map<String, bool> checks = <String, bool>{};
  AddContentLiveState(String name, bool changeState) {
    checks.clear();
    checks.addEntries(<String, bool>{"keepasdraft": false}.entries);
    checks[name] = changeState;
  }

  AddContentLiveState copyWith(
      {required String name, required bool changeState}) {
    final ous = AddContentLiveState(name, changeState);
    ous.checks = checks;
    ous.checks[name] = changeState;
    return ous;
  }
}
