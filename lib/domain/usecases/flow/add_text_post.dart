import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/model_container.dart';
import 'package:lomba_frontend/domain/entities/flows/post.dart';
import 'package:lomba_frontend/domain/entities/flows/textcontent.dart';

import '../../../core/failures.dart';
import '../../repositories/flow_repository.dart';

class AddTextPost {
  final FlowRepository repository;
  AddTextPost(this.repository);
  Future<Either<Failure, Post>> execute(
    String orgaId, String userId, TextContent text, String title, String flowId, bool isDraft)
    async{
    return await repository.addTextPost(orgaId, userId, text, title, flowId, isDraft );
    }
}