import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLiveCubit extends Cubit<HomeLiveState> {
  HomeLiveCubit()
      : super(const HomeLiveState(<String, bool>{}, <String, int>{}));

  void changeCheckValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }

  void makeVote(String postId, int voteValue) {
    emit(state.copyWithMakeVote(postId: postId, voteValue: voteValue));
  }
}

class HomeLiveState extends Equatable {
  final Map<String, bool> checks;
  final Map<String, int> votes;

  @override
  List<Object?> get props => [checks, votes, votes.length];

  const HomeLiveState(this.checks, this.votes);

  HomeLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    Map<String, bool> nchecks = <String, bool>{};
    nchecks.addAll(checks);
    nchecks[name] = changeState;
    final ous = HomeLiveState(nchecks, votes);
    return ous;
  }

  HomeLiveState copyWithMakeVote(
      {required String postId, required int voteValue}) {
    Map<String, int> nvotes = <String, int>{};
    nvotes.addAll(votes);
    nvotes[postId] = voteValue;
    final ous = HomeLiveState(checks, nvotes);
    return ous;
  }
}
