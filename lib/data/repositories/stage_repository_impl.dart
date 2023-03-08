import 'package:dartz/dartz.dart';
import 'package:lomba_frontend/core/failures.dart';

import '../../core/exceptions.dart';
import '../../domain/entities/workflow/stage.dart';
import '../../domain/repositories/stage_repository.dart';
import '../datasources/stage_data_source.dart';

class StageRepositoryImpl implements StageRepository {
  final StageRemoteDataSource remoteDataSource;

  StageRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Stage>>> getStages() async {
    try {
      final result = await remoteDataSource.getStages();

      List<Stage> list = [];

      if (result.isNotEmpty) {
        for (var element in result) {
          list.add(element.toEntity());
        }
      }

      return Right(list);
    } on ServerException {
      return const Left(ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  @override
  Future<Either<Failure, Stage>> getStage(String stageId) async {
    try {
      final result = await remoteDataSource.getStage(stageId);

      return (Right(result.toEntity()));
    } on ServerException {
      return const Left(ServerFailure('Ocurrió un error al procesar la solicitud.'));
    } on Exception {
      return const Left(ConnectionFailure('No existe conexión con internet.'));
    }
  }

  
}
