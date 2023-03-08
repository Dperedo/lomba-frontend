import 'package:equatable/equatable.dart';
import 'package:lomba_frontend/domain/entities/workflow/vote.dart';

class PostVotes extends Equatable {
  const PostVotes({
    required this.votes});

    final List<Vote> votes;

  @override
  
  List<Object?> get props => [
    votes
  ];
}
  
    