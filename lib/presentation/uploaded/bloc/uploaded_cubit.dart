import 'package:flutter_bloc/flutter_bloc.dart';

class UploadedLiveCubit extends Cubit<UploadedLiveState> {
  UploadedLiveCubit() : super(UploadedLiveState());

  void changeCheckValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }

  void makeVote(String postId, int voteValue) {
    emit(state.copyWithMakeVote(postId: postId, voteValue: voteValue));
  }
}

class UploadedLiveState {
  Map<String, bool> checks = <String, bool>{};
  Map<String, int> votes = <String, int>{};

  UploadedLiveState() {
    checks.clear();
    checks.addEntries(<String, bool>{"onlydrafts": false}.entries);
  }

  UploadedLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    final ous = UploadedLiveState();
    ous.checks = checks;
    ous.votes = votes;
    ous.checks[name] = changeState;
    return ous;
  }

  UploadedLiveState copyWithMakeVote(
      {required String postId, required int voteValue}) {
    final ous = UploadedLiveState();
    ous.checks = checks;
    ous.votes = votes;
    ous.votes[postId] = voteValue;
    return ous;
  }
}
