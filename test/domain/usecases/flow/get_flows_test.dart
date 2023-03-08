import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/domain/entities/role.dart';
import 'package:lomba_frontend/domain/entities/workflow/flow.dart';
import 'package:lomba_frontend/domain/usecases/flow/get_flows.dart';
import 'package:lomba_frontend/domain/usecases/roles/get_roles.dart';
import 'package:mockito/mockito.dart';

import 'flow_test_helper.mocks.dart';

void main() {
  late MockFlowRepository mockFlowRepository;
  late GetFlows usecase;

  setUp(() {
    mockFlowRepository = MockFlowRepository();
    usecase = GetFlows(mockFlowRepository);
  });

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

  test('debe conseguir lista de roles', () async {
    //arrange
    when(mockFlowRepository.getFlows())
        .thenAnswer((_) async => Right(<Flow>[tFlow]));

    //act
    final result = await usecase.execute();
    List<Flow> list = [];

    result.fold((l) => {}, (r) => {list = r});

    //assert
    expect(list, <Flow>[tFlow]);
  });
}
