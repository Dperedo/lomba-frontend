import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLiveCubit extends Cubit<HomeLiveState> {
  HomeLiveCubit() : super(HomeLiveState());

  void changeCheckValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }

  void makeVote(String postId, int voteValue) {
    emit(state.copyWithMakeVote(postId: postId, voteValue: voteValue));
  }
}

class HomeLiveState extends Equatable {
  Map<String, bool> checks = <String, bool>{};
  Map<String, int> votes = <String, int>{};

  @override
  List<Object?> get props => [checks, votes];

  HomeLiveState() {
    checks.clear();
  }

  HomeLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    final ous = HomeLiveState();
    ous.checks = checks;
    ous.votes = votes;
    ous.checks[name] = changeState;
    return ous;
  }

  HomeLiveState copyWithMakeVote(
      {required String postId, required int voteValue}) {
    final ous = HomeLiveState();
    ous.checks = checks;
    ous.votes = votes;
    ous.votes[postId] = voteValue;
    return ous;
  }
}
