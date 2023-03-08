import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/domain/entities/workflow/stage.dart';
import 'package:lomba_frontend/domain/usecases/stage/get_stage.dart';
import 'package:mockito/mockito.dart';

import 'stage_test_helper.mocks.dart';

void main() {
  late MockStageRepository mockStageRepository;
  late GetStage usecase;

  setUp(() {
    mockStageRepository = MockStageRepository();
    usecase = GetStage(mockStageRepository);
  });

  final newStageId = Guid.newGuid.toString();

  final tStage = Stage(
    id: '1',
    name: 'Aprobación',
    order: 2,
    queryOut: null,
    enabled: true,
    builtIn: true,
    created: DateTime.parse('2023-02-17 19:16:08.700Z'),
    updated: null,
    deleted: null,
    expires: null
  );

  test('debe conserguir un flow', () async {
    //arrange
    when(mockStageRepository.getStage(any))
        .thenAnswer((_) async => Right(tStage));

    //act
    final result = await usecase.execute(newStageId);

    //assert
    expect(result, Right(tStage));
  });
}
