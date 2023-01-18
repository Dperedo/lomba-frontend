import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/constants.dart';

import '../../domain/entities/orgauser.dart';

class OrgaUserCheckBoxesCubit extends Cubit<OrgaUserCheckBoxesState> {
  OrgaUserCheckBoxesCubit(OrgaUser orgaUser)
      : super(OrgaUserCheckBoxesState("enabled", false)) {
    state.checks["enabled"] = orgaUser.enabled;
    for (var element in orgaUser.roles) {
      state.checks[element] = true;
    }
  }

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
  Map<String, bool> checks = <String, bool>{};
  late bool deleted;
  OrgaUserCheckBoxesState(String name, bool changeState) {
    checks.clear();
    deleted = false;
    checks.addEntries(<String, bool>{"enabled": false}.entries);
    Roles.toList().forEach((element) {
      checks.addEntries(<String, bool>{element: false}.entries);
    });
    checks[name] = changeState;
  }

  OrgaUserCheckBoxesState copyWith(
      {required String name, required bool changeState}) {
    final ous = OrgaUserCheckBoxesState(name, changeState);
    ous.checks = checks;

    ous.checks[name] = changeState;

    return ous;
  }
}
