import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesLiveCubit extends Cubit<FavoritesLiveState> {
  FavoritesLiveCubit()
      : super(const FavoritesLiveState(
            <String, bool>{'positive': false, 'negative': false},
            <String, int>{}));

  void makeVote(String postId, int voteValue) {
    emit(state.copyWithMakeVote(postId: postId, voteValue: voteValue));
  }

  void changeCheckValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }
}

class FavoritesLiveState extends Equatable {
  final Map<String, bool> checks;
  final Map<String, int> votes;
  @override
  List<Object?> get props => [checks, votes, votes.length];

  const FavoritesLiveState(this.checks, this.votes);

  FavoritesLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    Map<String, bool> nchecks = <String, bool>{};
    nchecks.addAll(checks);
    nchecks[name] = changeState;
    if (name == "positive" && changeState) nchecks["negative"] = !changeState;
    if (name == "negative" && changeState) nchecks["positive"] = !changeState;
    final ous = FavoritesLiveState(nchecks, votes);
    return ous;
  }

  FavoritesLiveState copyWithMakeVote(
      {required String postId, required int voteValue}) {
    Map<String, int> nvotes = <String, int>{};
    nvotes.addAll(votes);
    nvotes[postId] = voteValue;
    final ous = FavoritesLiveState(checks, nvotes);
    return ous;
  }
}
