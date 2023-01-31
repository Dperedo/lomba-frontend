import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/domain/entities/orgauser.dart';
import 'package:lomba_frontend/domain/usecases/orgas/add_orgauser.dart';
import 'package:mockito/mockito.dart';

import 'orga_repository_helper.mocks.dart';

void main() {
  late MockOrgaRepository mockOrgaRepository;
  late AddOrgaUser usecase;

  setUp(() {
    mockOrgaRepository = MockOrgaRepository();
    usecase = AddOrgaUser(mockOrgaRepository);
  });

  final newOrgaId = Guid.newGuid.toString();
  final newUserId = Guid.newGuid.toString();

  final tOrgaUser = OrgaUser(
      userId: newUserId,
      orgaId: newOrgaId,
      roles: const <String>[Roles.roleAdmin],
      enabled: true,
      builtIn: true);

  test('debe agregar un nuevo orgauser (relación entre ellos)', () async {
    //arrange
    when(mockOrgaRepository.addOrgaUser(any, any, any, any))
        .thenAnswer((_) async => Right(tOrgaUser));

    //act
    final result = await usecase.execute(
        tOrgaUser.orgaId, tOrgaUser.userId, tOrgaUser.roles, tOrgaUser.enabled);

    //assert
    expect(result, Right(tOrgaUser));
  });
}
