import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:lomba_frontend/features/orgas/data/datasources/orga_remote_data_source.dart';
import 'package:lomba_frontend/features/orgas/data/models/orga_model.dart';

import '../../../../core/exceptions.dart';
import '../../../../core/failures.dart';
import '../../domain/entities/orga.dart';
import '../../domain/entities/orgauser.dart';
import '../../domain/repositories/orga_repository.dart';
import '../models/orgauser_model.dart';

///Implementación del [OrgaRepository] del dominio.
///
///Esta implementación controla las excepciones que pueden generarse en
///el DataSource (origen de los datos) cuando existen problemas de (por ejemplo)
///comunicación con el origen.
///Es en esta implementación que los errores se capturan y se convierten en
///retornos Left() con mensaje de falla (Failure)
class OrgaRepositoryImpl implements OrgaRepository {
  final OrgaRemoteDataSource remoteDataSource;

  ///El constructor de esta implementación recibe datasource remoto y local.
  ///
  ///Recibe dos dataSources porque debe conectar con el backend y depositar
  ///además la sesión en el localStorage.
  OrgaRepositoryImpl({required this.remoteDataSource});

  ///Entrega una lista de organizaciones [Orga] según los filtros
  ///
  ///[filter] es de tipo texto y si no hay filtro debe venir vacío.
  ///[fieldOrder] es el nombre del campo por el cual filtrar ascendentemente
  ///[pageNumber] es el número de página de la lista de organizaciones
  ///[pageSize] es el tamaño de cada página. Sólo se traerá una página.
  @override
  Future<Either<Failure, List<Orga>>> getOrgas(
      String filter, String fieldOrder, double pageNumber, int pageSize) async {
    try {
      final result = await remoteDataSource.getOrgas(
          filter, fieldOrder, pageNumber, pageSize);

      List<Orga> list = [];

      if (result.isNotEmpty) {
        for (var element in result) {
          list.add(element.toEntity());
        }
      }

      return Right(list);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  ///Entrega un [Orga] según el Id de organización
  @override
  Future<Either<Failure, Orga>> getOrga(String orgaId) async {
    try {
      final result = await remoteDataSource.getOrga(orgaId);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  ///Entrega una lista de [OrgaUser] según el Id organización especificado
  @override
  Future<Either<Failure, List<OrgaUser>>> getOrgaUsers(String orgaId) async {
    try {
      final result = await remoteDataSource.getOrgaUsers(orgaId);

      List<OrgaUser> list = [];

      if (result.isNotEmpty) {
        for (var element in result) {
          list.add(element.toEntity());
        }
      }

      return Right(list);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  ///Entrega un [OrgaUser] según el Id de organización
  @override
  Future<Either<Failure, List<OrgaUser>>> getOrgaUser(String orgaId, String userId) async {
    try {
      final result = await remoteDataSource.getOrgaUser(orgaId, userId);

      List<OrgaUser> list = [];

      if (result.isNotEmpty) {
        for (var element in result) {
          list.add(element.toEntity());
        }
      }

      return Right(list);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  ///Agrega un nuevo Orga y se deben especificar los valores
  ///
  ///[name] es el nombre de la organización.
  ///[code] es el código de la organización.
  ///[enabled] indica si la organización está habilitada.
  @override
  Future<Either<Failure, Orga>> addOrga(
      String name, String code, bool enabled) async {
    try {
      OrgaModel orgaModel = OrgaModel(
          id: Guid.newGuid.toString(),
          name: name,
          code: code,
          enabled: enabled,
          builtIn: false);

      final result = await remoteDataSource.addOrga(orgaModel);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  ///Agrega una relación [OrgaUser]
  ///
  ///[orgaId] Id de la organización
  ///[userId] Id del usuario
  ///[roles] lista de roles en [String]
  ///[enabled] especifica si la relación de OrgaUser está habilitada.
  @override
  Future<Either<Failure, OrgaUser>> addOrgaUser(
      String orgaId, String userId, List<String> roles, bool enabled) async {
    try {
      OrgaUserModel orgaUserModel = OrgaUserModel(
          orgaId: orgaId,
          userId: userId,
          roles: roles,
          enabled: enabled,
          builtIn: false);

      final result = await remoteDataSource.addOrgaUser(orgaUserModel);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  ///Elimina una organización según su [orgaId] invocando al DataSource
  @override
  Future<Either<Failure, bool>> deleteOrga(String orgaId) async {
    try {
      final result = await remoteDataSource.deleteOrga(orgaId);

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  ///Elimina una [OrgaUser] según su [orgaId] y [userId] invocando al DataSource
  @override
  Future<Either<Failure, bool>> deleteOrgaUser(
      String orgaId, String userId) async {
    try {
      final result = await remoteDataSource.deleteOrgaUser(orgaId, userId);

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  ///Habilita o deshabilita una [Orga] según Id y el parámetro [enableOrDisable]
  @override
  Future<Either<Failure, Orga>> enableOrga(
      String orgaId, bool enableOrDisable) async {
    try {
      final result = await remoteDataSource.enableOrga(orgaId, enableOrDisable);
      if (result) {
        final resultItem = await remoteDataSource.getOrga(orgaId);
        return Right(resultItem.toEntity());
      }
      return const Left(ServerFailure('No fue posible realizar la acción'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  ///Habilita una [OrgaUser] según Id de orga, user y el parám [enableOrDisable]
  @override
  Future<Either<Failure, OrgaUser>> enableOrgaUser(
      String orgaId, String userId, bool enableOrDisable) async {
    try {
      final result = await remoteDataSource.enableOrgaUser(
          orgaId, userId, enableOrDisable);

      if (result) {
        final resultItem = await remoteDataSource.getOrgaUser(orgaId, userId);
        List<OrgaUser> list = [];

        if (resultItem.isNotEmpty) {
          for (var element in resultItem) {
            list.add(element.toEntity());
          }
        }

      return Right(list[0]);
      }
      return const Left(ServerFailure(''));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  ///Actualiza un [Orga] especificando un Id y el [Orga] en [orga]
  @override
  Future<Either<Failure, Orga>> updateOrga(String orgaId, Orga orga) async {
    try {
      OrgaModel orgaModel = OrgaModel(
          id: orgaId,
          name: orga.name,
          code: orga.code,
          enabled: orga.enabled,
          builtIn: orga.builtIn);

      final result = await remoteDataSource.updateOrga(orgaId, orgaModel);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  ///Actualiza un [OrgaUser] especificando un Id y el [OrgaUser] en [orgaUser]
  @override
  Future<Either<Failure, OrgaUser>> updateOrgaUser(
      String orgaId, String userId, OrgaUser orgaUser) async {
    try {
      OrgaUserModel orgaUserModel = OrgaUserModel(
          orgaId: orgaId,
          userId: userId,
          roles: orgaUser.roles,
          enabled: orgaUser.enabled,
          builtIn: orgaUser.builtIn);

      final result =
          await remoteDataSource.updateOrgaUser(orgaId, userId, orgaUserModel);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
  
  @override
  Future<Either<Failure, Orga?>> existsOrga(String orgaId, String code)async {
    try {
      final result = await remoteDataSource.existsOrga(orgaId, code);

      if (result == null) {
        return const Right(null);
      } else {
        return Right(result.toEntity());
      }
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
    
  }

  @override
  Future<Either<Failure, List<Orga>>> getOrgasByUser(
      String userId) async {
    try {
      final result = await remoteDataSource.getOrgasByUser(
          userId);

      List<Orga> list = [];

      if (result.isNotEmpty) {
        for (var element in result) {
          list.add(element.toEntity());
        }
      }

      return Right(list);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
