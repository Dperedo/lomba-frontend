import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/exceptions.dart';
import 'package:lomba_frontend/data/datasources/flow_data_source.dart';
import 'package:lomba_frontend/data/models/session_model.dart';
import 'package:lomba_frontend/data/models/workflow/flow_model.dart';
import 'package:lomba_frontend/domain/entities/workflow/flow.dart';
import 'package:lomba_frontend/domain/entities/workflow/stage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../repositories/local_repository_impl_test.mocks.dart';
import 'role_data_source_test.mocks.dart';

@GenerateMocks([FlowRemoteDataSourceImpl],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {
  late MockHttpClient mockHttpClient;
  late FlowRemoteDataSourceImpl dataSource;
  late MockLocalDataSourceImpl mockLocalDataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockLocalDataSource = MockLocalDataSourceImpl();
    dataSource = FlowRemoteDataSourceImpl(
        client: mockHttpClient, localDataSource: mockLocalDataSource);

    //roleName = fakeFlows[0].name; //Sistema
  });

  const fakeFlowId = '1';

  final testStage = Stage(
    id: '1',
    name: 'Carga',
    order: 1,
    queryOut: null,
    enabled: true,
    builtIn: true,
    created: DateTime.parse('2023-02-17T19:16:06.648Z'),
    updated: null,
    deleted: null,
    expires: null
    );

  final testFlowModel = FlowModel(
    id: '1',
    name: 'flow1',
    enabled: true,
    builtIn: true,
    created: DateTime.parse('2023-02-17 19:16:08.700Z'),
    stages: [testStage],
    updated: null,
    deleted: null,
    expires: null
  );

  const testGetResponse =
      '{"apiVersion":"1.0","method":"get","params":{"flowId":"1"},"context":"geted by flow id","id":"42594fb7-b273-40b4-94ef-411a11b93fa0","_id":"42594fb7-b273-40b4-94ef-411a11b93fa0","data":{"items":[{"_id":"1","id":"1","name":"flow1","stages":[{"name":"Carga","order":1,"queryOut":null,"_id":"1","id":"1","enabled":true,"builtIn":true,"created":"2023-02-17T19:16:06.648Z"}],"enabled":true,"builtIn":true,"created":"2023-02-17T19:16:08.700Z"}],"kind":"string","currentItemCount":1,"updated":"2023-03-07T16:33:21.154Z"}}';

  const testBoolResponse =
      '{"apiVersion":"1.0","method":"put","params":{"id":"anonymous","enable":"false"},"context":"role disabled","id":"675a7573-49b7-440d-9765-3da2df1b4115","_id":"675a7573-49b7-440d-9765-3da2df1b4115","data":{"items":[true],"kind":"boolean","currentItemCount":1,"updated":"2023-01-16T22:55:20.752Z"}}';

  const testSession = SessionModel(
      token: SystemKeys.tokenSuperAdmin2023, name: 'Súper', username: 'super');

  const testHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer ${SystemKeys.tokenSuperAdmin2023}",
  };

  group('obtener datos de flow, flows', () {
    test('obtener un flow', () async {
      //arrange
      when(mockHttpClient.get(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testGetResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act
      final result = await dataSource.getFlow(fakeFlowId);

      //assert
      expect(result, equals(testFlowModel));
    });
    test('obtener lista de flows sin filtrar', () async {
      //arrange
      when(mockHttpClient.get(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testGetResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act
      final result = await dataSource.getFlows();

      //assert
      expect(result, equals(<Flow>[testFlowModel]));
    });

    test('''debe lanzar un error de servidor al conseguir 
      cuando la respuesta es distinta a 200''',
      () async {
        // arrange
        when(
          mockHttpClient.get(any, headers: testHeaders),
        ).thenAnswer(
          (_) async => http.Response('', 404),
        );
        when(mockLocalDataSource.getSavedSession())
            .thenAnswer((realInvocation) async => testSession);

        // act
        final call1 = dataSource.getFlow(fakeFlowId);
        final call2 = dataSource.getFlows();

        // assert
        expect(() => call1, throwsA(isA<ServerException>()));
        expect(() => call2, throwsA(isA<ServerException>()));
      },
    );
  });

  /*group('habilitar rol', () {
    test('habilitar un rol', () async {
      //arrange
      when(mockHttpClient.put(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testBoolResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act
      final result = await dataSource.enableFlow(fakeFlows[1].name, false);

      //assert
      expect(result, equals(true));
    });

    test('habilitar un rol y arroja error', () async {
      //arrange
      when(mockHttpClient.put(any, headers: testHeaders))
          .thenAnswer((realInvocation) async => http.Response('', 500));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act
      final call = dataSource.enableFlow(fakeFlows[1].name, false);

      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });*/
}
