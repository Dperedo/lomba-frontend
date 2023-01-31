import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/domain/entities/orgauser.dart';
import 'package:lomba_frontend/domain/usecases/orgas/update_orgauser.dart';
import 'package:mockito/mockito.dart';

import 'orga_repository_helper.mocks.dart';

void main() {
  late MockOrgaRepository mockOrgaRepository;
  late UpdateOrgaUser usecase;

  setUp(() {
    mockOrgaRepository = MockOrgaRepository();
    usecase = UpdateOrgaUser(mockOrgaRepository);
  });

  final newOrgaId = Guid.newGuid.toString();
  final newUserId = Guid.newGuid.toString();

  final tOrgaUser = OrgaUser(
      userId: newUserId,
      orgaId: newOrgaId,
      roles: const <String>[Roles.roleAdmin],
      enabled: true,
      builtIn: true);

  test('debe actualizar un orgauser (relación entre ellos)', () async {
    //arrange
    when(mockOrgaRepository.updateOrgaUser(any, any, any))
        .thenAnswer((_) async => Right(tOrgaUser));

    //act
    final result = await usecase.execute(newOrgaId, newUserId, tOrgaUser);

    //assert
    expect(result, Right(tOrgaUser));
  });
}
