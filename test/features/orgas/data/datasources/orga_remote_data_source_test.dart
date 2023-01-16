import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/data/datasources/local_data_source.dart';
import 'package:lomba_frontend/core/exceptions.dart';
import 'package:lomba_frontend/core/fakedata.dart';
import 'package:lomba_frontend/features/orgas/data/datasources/orga_remote_data_source.dart';
import 'package:lomba_frontend/core/data/models/session_model.dart';
import 'package:lomba_frontend/features/orgas/data/models/orga_model.dart';
import 'package:lomba_frontend/features/orgas/data/models/orgauser_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/data/repositories/local_repository_impl_test.mocks.dart';
import 'orga_remote_data_source_test.mocks.dart';

@GenerateMocks([OrgaRemoteDataSourceImpl],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {
  late MockHttpClient mockHttpClient;
  late OrgaRemoteDataSourceImpl dataSource;
  late MockLocalDataSourceImpl mockLocalDataSource;

  late String orgaId; //Sistema
  late OrgaModel filteredSystemOrga;
  late List<OrgaUserModel> listOrgaUsersSystem;
  late String orgaIdSampleUpdate;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockLocalDataSource = MockLocalDataSourceImpl();
    dataSource = OrgaRemoteDataSourceImpl(client: mockHttpClient, localDataSource: mockLocalDataSource);

    orgaId = fakeListOrgas[0].id; //Sistema
    filteredSystemOrga = fakeListOrgas
        .singleWhere((element) => element.name.contains("Sistema"));
    listOrgaUsersSystem =
        fakeListOrgaUsers.where((element) => element.orgaId == orgaId).toList();

    orgaIdSampleUpdate = fakeListOrgas[2].id;
  });

  const testOrgaId = '00000200-0200-0200-0200-000000000200';
  const testOrgaModel = OrgaModel(
      id: '00000200-0200-0200-0200-000000000200',
      name: 'Default',
      code: 'def',
      enabled: true,
      builtIn: false);

  const testOrgaUserId = '00000200-0200-0200-0200-000000000200';
  const testOrgaUserModel = OrgaUserModel(
    userId: '00000001-0001-0001-0001-000000000001',
    orgaId: '00000100-0100-0100-0100-000000000100',
    roles: ['super'],
    enabled: true,
    builtIn: true );

  const testGetOrgaUserResponse = 
      '{"apiVersion":"1.0","method":"get","params":{"orgaId":"00000100-0100-0100-0100-000000000100"},"context":"geted by orga id","id":"581905aa-d46d-4cad-b960-12380acd9c3e","_id":"581905aa-d46d-4cad-b960-12380acd9c3e","data":{"items":[{"_id":"A0000001-0000-0000-1000-000000000000","id":"A0000001-0000-0000-1000-000000000000","orgaId":"00000100-0100-0100-0100-000000000100","userId":"00000001-0001-0001-0001-000000000001","roles":[{"name":"super"}],"enabled":true,"builtin":true,"created":"2023-01-11T15:50:27.211Z"}],"kind":"string","currentItemCount":1,"updated":"2023-01-13T19:23:11.241Z"}}';

  const testGetResponse = 
      '{"apiVersion":"1.0","method":"get","params":{"orgaId":"00000200-0200-0200-0200-000000000200"},"context":"geted by orga id","id":"480893fa-0b81-4ce6-9e2f-e4439ce0ba9a","_id":"480893fa-0b81-4ce6-9e2f-e4439ce0ba9a","data":{"items":[{"_id":"00000200-0200-0200-0200-000000000200","id":"00000200-0200-0200-0200-000000000200","name":"Default","code":"def","builtin":true,"enabled":true}],"kind":"string","currentItemCount":1,"updated":"2023-01-13T15:25:05.437Z"}}';

  const testBoolResponse =
      '{"apiVersion":"1.0","method":"put","params":{"id":"00000200-0200-0200-0200-000000000200","enable":"false"},"context":"orga disabled","id":"38c8cb4d-a460-4056-b5ea-d1bcc323de39","_id":"38c8cb4d-a460-4056-b5ea-d1bcc323de39","data":{"items":[{"value":false}],"kind":"object","currentItemCount":1,"updated":"2023-01-13T15:01:56.006Z"}}';

  const testSession = SessionModel(
      token: SystemKeys.tokenSuperAdmin2023, name: 'Súper', username: 'super');

  const testHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer ${SystemKeys.tokenSuperAdmin2023}",
  };


  group('obtener datos orga, orgas y orgausers', () {
    test('obtener una organización', () async {
      //arrange
      when(mockHttpClient.get(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testGetResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      //act
      final result = await dataSource.getOrga(testOrgaId);

      //assert
      expect(result, equals(testOrgaModel));
    });
    test('obtener lista de organizaciones sin filtrar', () async {
      //arrange
      when(mockHttpClient.get(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testGetResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      //act
      final result = await dataSource.getOrgas("", "", 1, 10);

      //assert
      expect(result, equals(<OrgaModel>[testOrgaModel]));
    });
    test('obtener lista de organizaciones filtrada', () async {
      //arrange
      when(mockHttpClient.get(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testGetResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      //act
      final result = await dataSource.getOrgas("Sistema", "", 1, 10);

      //assert
      expect(result, equals(<OrgaModel>[testOrgaModel]));
    });
    test('obtener orgausers por orgaId', () async {
      //arrange
      when(mockHttpClient.get(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testGetOrgaUserResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      //act
      final result = await dataSource.getOrgaUsers(orgaId);

      //assert
      expect(result, equals(<OrgaUserModel>[testOrgaUserModel]));
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
        final call1 = dataSource.getOrga(orgaId);
        final call2 = dataSource.getOrgas("", "", 1, 10);
        final call3 = dataSource.getOrgaUsers(orgaId);

        // assert
        expect(() => call1, throwsA(isA<ServerException>()));
        expect(() => call2, throwsA(isA<ServerException>()));
        expect(() => call3, throwsA(isA<ServerException>()));
      },
    );
  });
  group('actualizar datos orga y orgauser', () {
    test('actualizar una organización', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response("", 200));

      //act
      OrgaModel toEdit = OrgaModel(
          id: orgaIdSampleUpdate,
          name: "Editado",
          code: "edi",
          enabled: true,
          builtIn: false);
      final result = await dataSource.updateOrga(orgaIdSampleUpdate, toEdit);

      //assert
      expect(result, equals(toEdit));
      expect(toEdit, equals(fakeListOrgas[2]));
    });
    test('actualizar una orgauser', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response("", 200));

      //act
      OrgaUserModel toEdit = OrgaUserModel(
          orgaId: orgaIdSampleUpdate,
          userId: fakeUserIdUser01,
          roles: const <String>["admin"],
          enabled: true,
          builtIn: false);
      final result = await dataSource.updateOrgaUser(
          orgaIdSampleUpdate, fakeUserIdUser01, toEdit);

      //assert
      expect(result, equals(toEdit));
      expect(toEdit, equals(fakeListOrgaUsers[2]));
    });
  });
  group('agregar datos orga y orgauser', () {
    test('agregar una organización', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response("", 200));

      //act
      OrgaModel toAdd = OrgaModel(
          id: Guid.newGuid.toString(),
          name: "Nueva Orga",
          code: "nva",
          enabled: true,
          builtIn: false);
      final result = await dataSource.addOrga(toAdd);

      //assert
      expect(result, equals(toAdd));
      //expect(fakeListOrgas.length, nearEqual(a, b, epsilon));
    });
    test('agregar una orgauser', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response("", 200));

      //act
      OrgaUserModel toAdd = OrgaUserModel(
          orgaId: Guid.newGuid.toString(),
          userId: Guid.newGuid.toString(),
          roles: const <String>["user"],
          enabled: true,
          builtIn: false);
      final result = await dataSource.addOrgaUser(toAdd);

      //assert
      expect(result, equals(toAdd));
      //expect(fakeListOrgaUsers.length, equals(count - 1));
    });
  });
  group('eliminar datos orga y orgauser', () {
    test('eliminar una organización', () async {
      //arrange
      when(mockHttpClient.delete(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testBoolResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act
      final result = await dataSource.deleteOrga(fakeOrgaIdSystem);

      //assert
      expect(result, equals(false));
      //expect(fakeListOrgas.length, equals(count + 1));
    });
    test('eliminar una orgauser', () async {
      //arrange
      when(mockHttpClient.delete(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testBoolResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act
      final result =
          await dataSource.deleteOrgaUser(fakeOrgaIdSample03, fakeUserIdUser02);

      //assert
      expect(result, equals(false));
      //expect(fakeListOrgaUsers.length, equals(count + 1));
    });
  });
  group('habilitar datos orga y orgauser', () {
    test('habilitar una organización', () async {
      //arrange
      when(mockHttpClient.delete(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testBoolResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act
      final result = await dataSource.enableOrga(fakeListOrgas[1].id, false);

      //assert
      expect(result, equals(false));
    });
    test('habilitar una orgauser', () async {
      //arrange
      when(mockHttpClient.delete(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testBoolResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act
      final result = await dataSource.enableOrgaUser(
          fakeListOrgas[1].id, fakeListOrgaUsers[1].userId, false);

      //assert
      expect(result.enabled, equals(false));
    });
  });
}
