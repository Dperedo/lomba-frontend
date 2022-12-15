import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/features/orgas/data/models/orga_model.dart';
import 'package:lomba_frontend/features/orgas/domain/entities/orga.dart';
import 'package:lomba_frontend/features/orgas/domain/entities/orgauser.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/update_orgauser.dart';
import 'package:mockito/annotations.dart';
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
      roles: const <String>[Roles.Admin],
      enabled: true,
      builtIn: true);

  final tOrga = Orga(
      id: newOrgaId,
      name: 'Test Orga',
      code: 'test',
      enabled: true,
      builtIn: false);

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
