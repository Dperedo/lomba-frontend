import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/features/orgas/domain/entities/orga.dart';
import 'package:lomba_frontend/features/orgas/domain/usecases/get_orga.dart';
import 'package:mockito/mockito.dart';

import 'orga_repository_helper.mocks.dart';

void main() {
  late MockOrgaRepository mockOrgaRepository;
  late GetOrga usecase;

  setUp(() {
    mockOrgaRepository = MockOrgaRepository();
    usecase = GetOrga(mockOrgaRepository);
  });

  final newOrgaId = Guid.newGuid.toString();

  final tOrga = Orga(
      id: newOrgaId,
      name: 'Test Orga',
      code: 'test',
      enabled: true,
      builtIn: false);

  test('debe conserguir un orga', () async {
    //arrange
    when(mockOrgaRepository.getOrga(any)).thenAnswer((_) async => Right(tOrga));

    //act
    final result = await usecase.execute(newOrgaId);

    //assert
    expect(result, Right(tOrga));
  });
}
