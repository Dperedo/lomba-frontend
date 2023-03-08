import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:lomba_frontend/domain/entities/role.dart';
import 'package:lomba_frontend/domain/entities/workflow/flow.dart';
import 'package:lomba_frontend/domain/usecases/flow/get_flow.dart';
import 'package:lomba_frontend/domain/usecases/flow/get_flows.dart';
import 'package:lomba_frontend/domain/usecases/roles/enable_role.dart';
import 'package:lomba_frontend/domain/usecases/roles/get_role.dart';
import 'package:lomba_frontend/domain/usecases/roles/get_roles.dart';
import 'package:lomba_frontend/presentation/flow/bloc/flow_bloc.dart';
import 'package:lomba_frontend/presentation/flow/bloc/flow_event.dart';
import 'package:lomba_frontend/presentation/flow/bloc/flow_state.dart';
import 'package:lomba_frontend/presentation/roles/bloc/role_bloc.dart';
import 'package:lomba_frontend/presentation/roles/bloc/role_event.dart';
import 'package:lomba_frontend/presentation/roles/bloc/role_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'flow_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetFlow>(),
  MockSpec<GetFlows>(),
])
Future<void> main() async {
  late GetFlow mockGetFlow;
  late GetFlows mockGetFlows;

  late FlowBloc roleBloc;

  setUp(() {
    mockGetFlow = MockGetFlow();
    mockGetFlows = MockGetFlows();

    roleBloc = FlowBloc(
      mockGetFlow,
      mockGetFlows,
    );
  });

  final newFlowName = Guid.newGuid.toString();

  final tFlow = Flow(
    id: '1',
    name: 'flow1',
    enabled: true,
    builtIn: true,
    created: DateTime.parse('2023-02-17 19:16:08.700Z'),
    stages: [],
    updated: null,
    deleted: null,
    expires: null
  );

  test(
    'el estado inicial debe ser Start',
    () {
      //assert
      expect(roleBloc.state, FlowStart());
    },
  );

  group('conseguir rolenizaciones y roleroles', () {
    blocTest<FlowBloc, FlowState>(
      'debe lanzar el spinner y devolver estado con listado',
      build: () {
        when(mockGetFlows.execute())
            .thenAnswer((_) async => Right(<Flow>[tFlow]));
        return roleBloc;
      },
      act: (bloc) => bloc.add(const OnFlowListLoad()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        FlowLoading(),
        FlowListLoaded(<Flow>[tFlow]),
      ],
      verify: (bloc) {
        verify(mockGetFlows.execute());
      },
    );

    blocTest<FlowBloc, FlowState>(
      'debe lanzar el spinner y devolver estado con el flow',
      build: () {
        when(mockGetFlow.execute(newFlowName))
            .thenAnswer((_) async => Right(tFlow));
        return roleBloc;
      },
      act: (bloc) => bloc.add(OnFlowLoad(newFlowName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        FlowLoading(),
        FlowLoaded(tFlow),
      ],
      verify: (bloc) {
        verify(mockGetFlow.execute(newFlowName));
      },
    );

    blocTest<FlowBloc, FlowState>(
      'debe lanzar el spinner y devolver estado flow error',
      build: () {
        when(mockGetFlow.execute(newFlowName))
            .thenAnswer((_) async => const Left(ConnectionFailure('error')));
        return roleBloc;
      },
      act: (bloc) => bloc.add(OnFlowLoad(newFlowName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        FlowLoading(),
        const FlowError('error'),
      ],
      verify: (bloc) {
        verify(mockGetFlow.execute(newFlowName));
      },
    );
  });
}
