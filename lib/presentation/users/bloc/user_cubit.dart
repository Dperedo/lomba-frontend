import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/constants.dart';

import '../../../domain/entities/orgauser.dart';

class UserOrgaDialogEditCubit extends Cubit<UserOrgaDialogEditState> {
  UserOrgaDialogEditCubit(OrgaUser orgaUser)
      : super(UserOrgaDialogEditState("enabled", false)) {
    state.checks["enabled"] = orgaUser.enabled;
    for (var element in orgaUser.roles) {
      state.checks[element] = true;
    }
  }

  void changeValue(String name, bool value) {
    emit(state.copyWith(name: name, changeState: value));
  }
}

class UserOrgaDialogEditState extends Equatable {
  late Map<String, bool> checks;
  late bool deleted;

  @override
  List<Object?> get props => [deleted, checks];

  UserOrgaDialogEditState(String name, bool changeState) {
    deleted = false;
    checks = <String, bool>{};
    checks.addEntries(<String, bool>{"enabled": false}.entries);
    Roles.toList().forEach((element) {
      checks.addEntries(<String, bool>{element: false}.entries);
    });
    checks[name] = changeState;
  }

  UserOrgaDialogEditState copyWith(
      {required String name, required bool changeState}) {
    Map<String, bool> nchecks = <String, bool>{};
    nchecks.addAll(checks);
    nchecks[name] = changeState;
    final ous = UserOrgaDialogEditState(name, changeState);
    ous.checks = nchecks;
    return ous;
  }
}
