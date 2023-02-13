import 'package:equatable/equatable.dart';
import 'package:lomba_frontend/presentation/voted/bloc/voted_state.dart';

abstract class VotedEvent extends Equatable {
  const VotedEvent();

  @override
  List<Object?> get props => [];
}

class OnVotedLoad extends VotedEvent {
  final String searchText;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;
  final bool positive;
  final bool negative;

  const OnVotedLoad(
      this.searchText, this.fieldsOrder, this.pageIndex, this.pageSize, this.positive, this.negative);

  @override
  List<Object> get props => [searchText, fieldsOrder, pageIndex, pageSize, positive, negative];
}

class OnVotedAddVote extends VotedEvent {
  final String postId;
  final int voteValue;
  
  const OnVotedAddVote(this.postId, this.voteValue);

  @override
  List<Object> get props => [postId, voteValue];
}
