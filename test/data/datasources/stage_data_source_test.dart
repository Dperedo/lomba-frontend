import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/exceptions.dart';
import 'package:lomba_frontend/data/datasources/stage_data_source.dart';
import 'package:lomba_frontend/data/models/session_model.dart';
import 'package:lomba_frontend/data/models/workflow/stage_model.dart';
import 'package:lomba_frontend/domain/entities/workflow/stage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../repositories/local_repository_impl_test.mocks.dart';
import 'role_data_source_test.mocks.dart';

@GenerateMocks([StageRemoteDataSourceImpl],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {
  late MockHttpClient mockHttpClient;
  late StageRemoteDataSourceImpl dataSource;
  late MockLocalDataSourceImpl mockLocalDataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockLocalDataSource = MockLocalDataSourceImpl();
    dataSource = StageRemoteDataSourceImpl(
        client: mockHttpClient, localDataSource: mockLocalDataSource);
  });

  const fakeStageId = '1';

  final tStage = Stage(
    id: '1',
    name: 'Aprobación',
    order: 2,
    queryOut: null,
    enabled: true,
    builtIn: true,
    created: DateTime.parse('2023-02-17T19:16:06.648Z'),
    updated: null,
    deleted: null,
    expires: null
    );

  final tStageModel = StageModel(
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

  const testGetResponse =
      '{"apiVersion":"1.0","method":"get","params":{"stageId":"1"},"context":"geted by stage id","id":"5eec0895-4702-4a13-beef-aa5f7d566e7c","_id":"5eec0895-4702-4a13-beef-aa5f7d566e7c","data":{"items":[{"_id":"1","id":"1","name":"Aprobación","order":2,"queryOut":null,"enabled":true,"builtIn":true,"created":"2023-02-17 19:16:08.700Z"}],"kind":"string","currentItemCount":1,"updated":"2023-03-08T19:04:38.750Z"}}';

  const testSession = SessionModel(
      token: SystemKeys.tokenSuperAdmin2023, name: 'Súper', username: 'super');

  const testHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer ${SystemKeys.tokenSuperAdmin2023}",
  };

  group('obtener datos de stage, stages', () {
    test('obtener un stage', () async {
      //arrange
      when(mockHttpClient.get(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testGetResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act
      final result = await dataSource.getStage(fakeStageId);

      //assert
      expect(result, equals(tStageModel));
    });
    test('obtener lista de stages sin filtrar', () async {
      //arrange
      when(mockHttpClient.get(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testGetResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act
      final result = await dataSource.getStages();

      //assert
      expect(result, equals(<Stage>[tStageModel]));
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
        final call1 = dataSource.getStage(fakeStageId);
        final call2 = dataSource.getStages();

        // assert
        expect(() => call1, throwsA(isA<ServerException>()));
        expect(() => call2, throwsA(isA<ServerException>()));
      },
    );
  });
}
