import 'package:equatable/equatable.dart';

abstract class VotedEvent extends Equatable{
  const VotedEvent();

  @override
  List<Object?> get props => [];
}
class OnVotedLoad extends VotedEvent {
  
  final String searchText;
  final Map<String, int> fieldsOrder;
  final int pageIndex;
  final int pageSize;
  

  const OnVotedLoad(
    this.searchText, this.fieldsOrder, this.pageIndex, this.pageSize
  );

  @override
  List<Object> get props => [searchText, fieldsOrder, pageIndex, pageSize];
}

class OnVotedChangeState extends VotedEvent {
  final String postId;
  final int voteValue;

  const OnVotedChangeState (this.postId, this.voteValue);

  @override
  List<Object> get props => [postId, voteValue];
}
