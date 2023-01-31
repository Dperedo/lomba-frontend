import 'package:flutter_bloc/flutter_bloc.dart';

class CheckboxCubit extends Cubit<CheckboxState> {
  CheckboxCubit() : super(CheckboxState(ischecked: false));

  void changeValue(bool value) {
    emit(state.copyWith(changeState: value));
  }
}

class CheckboxState {
  bool ischecked = false;
  CheckboxState({required this.ischecked});

  CheckboxState copyWith({required bool changeState}) {
    return CheckboxState(ischecked: changeState);
  }
}
