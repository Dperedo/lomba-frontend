import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:http/http.dart' as http;
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/data/models/session_model.dart';
import 'package:lomba_frontend/core/exceptions.dart';
import 'package:lomba_frontend/core/fakedata.dart';
import 'package:lomba_frontend/data/datasources/role_data_source.dart';
import 'package:lomba_frontend/data/models/role_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../repositories/local_repository_impl_test.mocks.dart';
import 'role_data_source_test.mocks.dart';

@GenerateMocks([RoleRemoteDataSourceImpl],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {
  late MockHttpClient mockHttpClient;
  late RoleRemoteDataSourceImpl dataSource;
  late MockLocalDataSourceImpl mockLocalDataSource;

  late String roleName; //Sistema
  late String roleIdSampleUpdate;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockLocalDataSource = MockLocalDataSourceImpl();
    dataSource = RoleRemoteDataSourceImpl(
        client: mockHttpClient, localDataSource: mockLocalDataSource);

    roleName = fakeRoles[0].name; //Sistema
  });

  const testRoleModel = RoleModel(name: 'super', enabled: true);

  const testGetResponse =
      '{"apiVersion":"1.0","method":"get","params":{"id":"super"},"context":"geted by orga id","id":"53052260-b794-4215-a633-7f16b9a78d15","_id":"53052260-b794-4215-a633-7f16b9a78d15","data":{"items":[{"_id":"super","id":"super","name":"super","enabled":true}],"kind":"string","currentItemCount":1,"updated":"2023-01-16T15:07:02.673Z"}}';

  const testBoolResponse =
      '{"apiVersion":"1.0","method":"put","params":{"id":"anonymous","enable":"false"},"context":"role disabled","id":"675a7573-49b7-440d-9765-3da2df1b4115","_id":"675a7573-49b7-440d-9765-3da2df1b4115","data":{"items":[true],"kind":"boolean","currentItemCount":1,"updated":"2023-01-16T22:55:20.752Z"}}';

  const testSession = SessionModel(
      token: SystemKeys.tokenSuperAdmin2023, name: 'Súper', username: 'super');

  const testHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer ${SystemKeys.tokenSuperAdmin2023}",
  };

  group('obtener datos de rol, roles', () {
    test('obtener un rol', () async {
      //arrange
      when(mockHttpClient.get(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testGetResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act
      final result = await dataSource.getRole(roleName);

      //assert
      expect(result, equals(fakeRoles[0]));
    });
    test('obtener lista de roles sin filtrar', () async {
      //arrange
      when(mockHttpClient.get(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testGetResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act
      final result = await dataSource.getRoles();

      //assert
      expect(result, equals(<RoleModel>[testRoleModel]));
    });

    test(
      '''debe lanzar un error de servidor al conseguir 
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
        final call1 = dataSource.getRole(roleName);
        final call2 = dataSource.getRoles();

        // assert
        expect(() => call1, throwsA(isA<ServerException>()));
        expect(() => call2, throwsA(isA<ServerException>()));
      },
    );
  });

  group('habilitar rol', () {
    test('habilitar un rol', () async {
      //arrange
      when(mockHttpClient.put(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testBoolResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act
      final result = await dataSource.enableRole(fakeRoles[1].name, false);

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
      final call = dataSource.enableRole(fakeRoles[1].name, false);

      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
