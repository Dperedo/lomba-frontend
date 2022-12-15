import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/features/orgas/data/models/orga_model.dart';
import 'package:lomba_frontend/features/orgas/domain/entities/orga.dart';
import 'package:lomba_frontend/features/orgas/domain/entities/orgauser.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/add_orga.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/get_orga.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/get_orgausers.dart';
import 'package:mockito/mockito.dart';

import 'orga_repository_helper.mocks.dart';

void main() {
  late MockOrgaRepository mockOrgaRepository;
  late GetOrgaUsers usecase;

  setUp(() {
    mockOrgaRepository = MockOrgaRepository();
    usecase = GetOrgaUsers(mockOrgaRepository);
  });

  final newOrgaId = Guid.newGuid.toString();
  final newUserId = Guid.newGuid.toString();

  final tOrgaModel = OrgaModel(
      id: newOrgaId,
      name: 'Test Orga',
      code: 'test',
      enabled: true,
      builtIn: false);

  final tOrga = Orga(
      id: newOrgaId,
      name: 'Test Orga',
      code: 'test',
      enabled: true,
      builtIn: false);

  final tOrgaUser = OrgaUser(
      userId: newUserId,
      orgaId: newOrgaId,
      roles: const <String>[Roles.Admin],
      enabled: true,
      builtIn: true);

  test('debe conserguir un orgausers (relación entre ellos)', () async {
    //arrange
    when(mockOrgaRepository.getOrgaUsers(any))
        .thenAnswer((_) async => Right(<OrgaUser>[tOrgaUser]));

    //act
    final result = await usecase.execute(newOrgaId);

    List<OrgaUser> list = [];

    result.fold((l) => {}, (r) => {list = r});

    //assert
    expect(list, <OrgaUser>[tOrgaUser]);
  });
}
