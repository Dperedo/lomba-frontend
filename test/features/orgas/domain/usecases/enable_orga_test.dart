import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/features/orgas/domain/entities/orga.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/enable_orga.dart';
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
