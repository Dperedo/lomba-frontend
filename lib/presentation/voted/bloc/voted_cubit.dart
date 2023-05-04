import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../domain/usecases/bookmark/post_bookmark.dart';

class VotedLiveCubit extends Cubit<VotedLiveState> {
  final PostBookmark _postBookmark;
  VotedLiveCubit(
    this._postBookmark,
  )
      : super(const VotedLiveState(
            <String, bool>{'positive': false, 'negative': false},
            <String, int>{}, <String, bool>{}, <String, bool>{},));

  void makeVote(String postId, int voteValue) {
    emit(state.copyWithMakeVote(postId: postId, voteValue: voteValue));
  }

  void changeCheckValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }

  void makeBookmark(String userId, String postId, String markType, bool giveOrTakeAway) async {

    final resultBookmark = await _postBookmark.execute(userId, postId, markType, giveOrTakeAway);
    resultBookmark.fold((l) => null, (r) {
      
      if(r.markType == BookmarkCodes.saveCode) {
        emit(state.copyWithSave(postId: postId, saveValue: giveOrTakeAway));
      } else if(r.markType == BookmarkCodes.favCode) {
        emit(state.copyWithFav(postId: postId, favValue: giveOrTakeAway));
      }
    });

  }
}

class VotedLiveState extends Equatable {
  final Map<String, bool> checks;
  final Map<String, int> votes;
  final Map<String, bool> favs;
  final Map<String, bool> saves;
  @override
  List<Object?> get props => [checks, votes, votes.length, saves, favs];

  const VotedLiveState(this.checks, this.votes, this.saves, this.favs);

  VotedLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    Map<String, bool> nchecks = <String, bool>{};
    nchecks.addAll(checks);
    nchecks[name] = changeState;
    if (name == "positive" && changeState) nchecks["negative"] = !changeState;
    if (name == "negative" && changeState) nchecks["positive"] = !changeState;
    final ous = VotedLiveState(nchecks, votes, saves, favs);
    return ous;
  }

  VotedLiveState copyWithMakeVote(
      {required String postId, required int voteValue}) {
    Map<String, int> nvotes = <String, int>{};
    nvotes.addAll(votes);
    nvotes[postId] = voteValue;
    final ous = VotedLiveState(checks, nvotes, saves, favs);
    return ous;
  }

  VotedLiveState copyWithSave({required String postId, required bool saveValue}) {
    Map<String, bool> nsaves = <String, bool>{};
    nsaves.addAll(saves);
    nsaves[postId] = saveValue;
    final ous = VotedLiveState(checks, votes, nsaves, favs);
    return ous;
  }

  VotedLiveState copyWithFav({required String postId, required bool favValue}) {
    Map<String, bool> nfavs = <String, bool>{};
    nfavs.addAll(favs);
    nfavs[postId] = favValue;
    final ous = VotedLiveState(checks, votes, saves, nfavs);
    return ous;
  }
}
