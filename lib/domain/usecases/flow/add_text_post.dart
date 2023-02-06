import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../core/failures.dart';
import '../../repositories/flow_repository.dart';

class AddTextPost {
  final FlowRepository repository;
  AddTextPost(this.repository);
  Future<Either<Failure, Flow>> execute(
    String orgaId, String userId, String text, String title, String flowId, bool isDraft)
    async{
    return await repository.addTextPost(orgaId, userId, text, title, flowId, isDraft );
    }
}