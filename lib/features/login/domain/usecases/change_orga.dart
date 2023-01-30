import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:lomba_frontend/features/orgas/data/models/orga_model.dart';

import '../../../../core/domain/entities/session.dart';
import '../../../orgas/domain/entities/orga.dart';
import '../../data/models/login_access_model.dart';
import '../repositories/login_repository.dart';

class ChangeOrga {
  final LoginRepository repository;
  ChangeOrga(this.repository);
  Future<Either<Failure, Session>> execute(
      String username, String orgaId) async {
    return await repository.changeOrga(username, orgaId);
  }
}