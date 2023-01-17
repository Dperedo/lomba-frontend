import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/constants.dart';

class OrgaUserCheckBoxesCubit extends Cubit<OrgaUserCheckBoxesState> {
  OrgaUserCheckBoxesCubit() : super(OrgaUserCheckBoxesState("enabled", false));

  void changeValue(String name, bool value) {
    emit(state.copyWith(name: name, changeState: value));
  }

  void setValues(Map<String, bool> values) {
    state.checks.addEntries(values.entries);
  }

  void cleanValues() {
    state.checks.forEach((key, value) {
      state.checks[key] = false;
    });
  }
}

class OrgaUserCheckBoxesState {
  Map<String, bool> checks = [] as Map<String, bool>;
  OrgaUserCheckBoxesState(String name, bool changeState) {
    checks.addEntries(<String, bool>{"enabled": false}.entries);
    Roles.toList().forEach((element) {
      checks.addEntries(<String, bool>{element: false}.entries);
    });
    checks[name] = changeState;
  }

  OrgaUserCheckBoxesState copyWith(
      {required String name, required bool changeState}) {
    checks[name] = changeState;

    return this;
  }
}
