import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../domain/usecases/bookmark/post_bookmark.dart';

class PopularLiveCubit extends Cubit<PopularLiveState> {
  final PostBookmark _postBookmark;
  PopularLiveCubit(
    this._postBookmark,
  )
      : super(const PopularLiveState(<String, bool>{}, <String, int>{}, <String, bool>{}, <String, bool>{},));

  void changeCheckValue(String name, bool value) {
    emit(state.copyWithChangeCheck(name: name, changeState: value));
  }

  void makeVote(String postId, int voteValue) {
    emit(state.copyWithMakeVote(postId: postId, voteValue: voteValue));
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

class PopularLiveState extends Equatable {
  final Map<String, bool> checks;
  final Map<String, int> votes;
  final Map<String, bool> favs;
  final Map<String, bool> saves;

  @override
  List<Object?> get props => [checks, votes, votes.length, favs, saves];

  const PopularLiveState(this.checks, this.votes, this.favs, this.saves);

  PopularLiveState copyWithChangeCheck(
      {required String name, required bool changeState}) {
    Map<String, bool> nchecks = <String, bool>{};
    nchecks.addAll(checks);
    nchecks[name] = changeState;
    final ous = PopularLiveState(nchecks, votes, favs, saves);
    return ous;
  }

  PopularLiveState copyWithMakeVote(
      {required String postId, required int voteValue}) {
    Map<String, int> nvotes = <String, int>{};
    nvotes.addAll(votes);
    nvotes[postId] = voteValue;
    final ous = PopularLiveState(checks, nvotes, favs, saves);
    return ous;
  }

  PopularLiveState copyWithSave({required String postId, required bool saveValue}) {
    Map<String, bool> nsaves = <String, bool>{};
    nsaves.addAll(saves);
    nsaves[postId] = saveValue;
    final ous = PopularLiveState(checks, votes, nsaves, favs);
    return ous;
  }

  PopularLiveState copyWithFav({required String postId, required bool favValue}) {
    Map<String, bool> nfavs = <String, bool>{};
    nfavs.addAll(favs);
    nfavs[postId] = favValue;
    final ous = PopularLiveState(checks, votes, saves, nfavs);
    return ous;
  }
}
