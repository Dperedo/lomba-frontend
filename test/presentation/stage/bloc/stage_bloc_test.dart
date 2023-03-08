import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:lomba_frontend/domain/entities/workflow/stage.dart';
import 'package:lomba_frontend/domain/usecases/stage/get_stage.dart';
import 'package:lomba_frontend/domain/usecases/stage/get_stages.dart';
import 'package:lomba_frontend/presentation/stage/bloc/stage_bloc.dart';
import 'package:lomba_frontend/presentation/stage/bloc/stage_event.dart';
import 'package:lomba_frontend/presentation/stage/bloc/stage_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'stage_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetStage>(),
  MockSpec<GetStages>(),
])
Future<void> main() async {
  late GetStage mockGetStage;
  late GetStages mockGetStages;

  late StageBloc roleBloc;

  setUp(() {
    mockGetStage = MockGetStage();
    mockGetStages = MockGetStages();

    roleBloc = StageBloc(
      mockGetStage,
      mockGetStages,
    );
  });

  final newStageName = Guid.newGuid.toString();

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

  test(
    'el estado inicial debe ser Start',
    () {
      //assert
      expect(roleBloc.state, StageStart());
    },
  );

  group('conseguir rolenizaciones y roleroles', () {
    blocTest<StageBloc, StageState>(
      'debe lanzar el spinner y devolver estado con listado',
      build: () {
        when(mockGetStages.execute())
            .thenAnswer((_) async => Right(<Stage>[tStage]));
        return roleBloc;
      },
      act: (bloc) => bloc.add(const OnStageListLoad()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        StageLoading(),
        StageListLoaded(<Stage>[tStage]),
      ],
      verify: (bloc) {
        verify(mockGetStages.execute());
      },
    );

    blocTest<StageBloc, StageState>(
      'debe lanzar el spinner y devolver estado con el flow',
      build: () {
        when(mockGetStage.execute(newStageName))
            .thenAnswer((_) async => Right(tStage));
        return roleBloc;
      },
      act: (bloc) => bloc.add(OnStageLoad(newStageName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        StageLoading(),
        StageLoaded(tStage),
      ],
      verify: (bloc) {
        verify(mockGetStage.execute(newStageName));
      },
    );

    blocTest<StageBloc, StageState>(
      'debe lanzar el spinner y devolver estado flow error',
      build: () {
        when(mockGetStage.execute(newStageName))
            .thenAnswer((_) async => const Left(ConnectionFailure('error')));
        return roleBloc;
      },
      act: (bloc) => bloc.add(OnStageLoad(newStageName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        StageLoading(),
        const StageError('error'),
      ],
      verify: (bloc) {
        verify(mockGetStage.execute(newStageName));
      },
    );
  });
}
