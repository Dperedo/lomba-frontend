import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingSuperLiveCubit extends Cubit<SettingSuperLiveState> {
  SettingSuperLiveCubit()
      : super(const SettingSuperLiveState(
            <String, bool>{"onlydrafts": false}, <String, int>{}));

  void changeCheckValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }

  void makeVote(String postId, int voteValue) {
    emit(state.copyWithMakeVote(postId: postId, voteValue: voteValue));
  }
}

class SettingSuperLiveState extends Equatable {
  final Map<String, bool> checks;
  final Map<String, int> votes;

  @override
  List<Object?> get props => [checks, votes, votes.length];

  const SettingSuperLiveState(this.checks, this.votes);

  SettingSuperLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    Map<String, bool> nchecks = <String, bool>{};
    nchecks.addAll(checks);
    nchecks[name] = changeState;
    final ous = SettingSuperLiveState(nchecks, votes);
    return ous;
  }

  SettingSuperLiveState copyWithMakeVote(
      {required String postId, required int voteValue}) {
    Map<String, int> nvotes = <String, int>{};
    nvotes.addAll(votes);
    nvotes[postId] = voteValue;
    final ous = SettingSuperLiveState(checks, nvotes);
    return ous;
  }
}
