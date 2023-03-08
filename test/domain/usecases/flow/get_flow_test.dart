import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/domain/entities/workflow/flow.dart';
import 'package:lomba_frontend/domain/usecases/flow/get_flow.dart';
import 'package:mockito/mockito.dart';

import 'flow_test_helper.mocks.dart';

//import 'role_test_helper.mocks.dart';

void main() {
  late MockFlowRepository mockFlowRepository;
  late GetFlow usecase;

  setUp(() {
    mockFlowRepository = MockFlowRepository();
    usecase = GetFlow(mockFlowRepository);
  });

  final newFlowId = Guid.newGuid.toString();

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

  test('debe conserguir un flow', () async {
    //arrange
    when(mockFlowRepository.getFlow(any))
        .thenAnswer((_) async => Right(tFlow));

    //act
    final result = await usecase.execute(newFlowId);

    //assert
    expect(result, Right(tFlow));
  });
}
