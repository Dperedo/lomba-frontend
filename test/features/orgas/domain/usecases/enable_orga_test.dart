import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/features/orgas/data/models/orga_model.dart';
import 'package:lomba_frontend/features/orgas/domain/entities/orga.dart';
import 'package:lomba_frontend/features/orgas/domain/repositories/orga_repository.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/add_orga.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/delete_orga.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/enable_orga.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orga_repository_helper.mocks.dart';

void main() {
  late MockOrgaRepository mockOrgaRepository;
  late EnableOrga usecase;

  setUp(() {
    mockOrgaRepository = MockOrgaRepository();
    usecase = EnableOrga(mockOrgaRepository);
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

  test('debe deshabilitar un orga', () async {
    //arrange
    when(mockOrgaRepository.enableOrga(any, any))
        .thenAnswer((_) async => Right(tOrga));

    //act
    final result = await usecase.execute(newOrgaId, false);

    //assert
    expect(result, Right(tOrga));
  });
}
