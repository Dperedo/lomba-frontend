import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/domain/entities/workflow/stage.dart';
import 'package:lomba_frontend/domain/usecases/stage/get_stages.dart';
import 'package:mockito/mockito.dart';

import 'stage_test_helper.mocks.dart';

void main() {
  late MockStageRepository mockStageRepository;
  late GetStages usecase;

  setUp(() {
    mockStageRepository = MockStageRepository();
    usecase = GetStages(mockStageRepository);
  });

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

  test('debe conseguir lista de roles', () async {
    //arrange
    when(mockStageRepository.getStages())
        .thenAnswer((_) async => Right(<Stage>[tStage]));

    //act
    final result = await usecase.execute();
    List<Stage> list = [];

    result.fold((l) => {}, (r) => {list = r});

    //assert
    expect(list, <Stage>[tStage]);
  });
}
