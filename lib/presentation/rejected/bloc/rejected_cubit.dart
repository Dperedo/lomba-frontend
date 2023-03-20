import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RejectedLiveCubit extends Cubit<RejectedLiveState> {
  RejectedLiveCubit()
      : super(const RejectedLiveState(<String, bool>{}, <String, int>{}, ""));

  void changeCheckValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }

  void makeVote(String postId, int voteValue) {
    emit(state.copyWithMakeVote(postId: postId, voteValue: voteValue));
  }
}

class RejectedLiveState extends Equatable {
  final Map<String, bool> checks;
  final Map<String, int> votes;
  final String message;

  @override
  List<Object?> get props => [checks, votes, votes.length, message];

  const RejectedLiveState(this.checks, this.votes, this.message);

  RejectedLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    Map<String, bool> nchecks = <String, bool>{};
    nchecks.addAll(checks);
    nchecks[name] = changeState;
    final ous = RejectedLiveState(nchecks, votes, "");
    return ous;
  }

  RejectedLiveState copyWithMakeVote(
      {required String postId, required int voteValue}) {
    Map<String, int> nvotes = <String, int>{};
    nvotes.addAll(votes);
    nvotes[postId] = voteValue;
    final ous = RejectedLiveState(checks, nvotes,
        voteValue > 0 ? "Publicación aprobada" : "Publicación rechazada");
    return ous;
  }
}
