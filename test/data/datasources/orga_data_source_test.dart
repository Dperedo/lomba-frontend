import 'dart:convert';

import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/exceptions.dart';
import 'package:lomba_frontend/core/fakedata.dart';
import 'package:lomba_frontend/data/datasources/orga_data_source.dart';
import 'package:lomba_frontend/data/models/session_model.dart';
import 'package:lomba_frontend/data/models/orga_model.dart';
import 'package:lomba_frontend/data/models/orgauser_model.dart';
import 'package:lomba_frontend/data/models/role_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../repositories/local_repository_impl_test.mocks.dart';
import 'orga_data_source_test.mocks.dart';

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
    dataSource = OrgaRemoteDataSourceImpl(
        client: mockHttpClient, localDataSource: mockLocalDataSource);

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
      builtIn: true);

  const testOrgaUserId = '00000200-0200-0200-0200-000000000200';
  const testOrgaUserModel = OrgaUserModel(
      userId: '00000001-0001-0001-0001-000000000001',
      orgaId: '00000100-0100-0100-0100-000000000100',
      roles: ['super'],
      enabled: true,
      builtIn: true);

  const testOrgaUserModelOne = OrgaUserModel(
      userId: '00000001-0001-0001-0001-000000000001',
      orgaId: '00000100-0100-0100-0100-000000000100',
      roles: [''],
      enabled: true,
      builtIn: true);

  const testOrgaId01 = "00000100-0100-0100-0100-000000000100";
  const testUserId01 = "00000001-0001-0001-0001-000000000001";

  const testGetResponseUpdate =
      '{"apiVersion":"1.0","method":"get","params":{"id":"00000001-0001-0001-0001-000000000001"},"context":"geted by id","id":"37f93961-a189-4182-96b0-28491a8b78df","_id":"37f93961-a189-4182-96b0-28491a8b78df","data":{"items":[{"_id":"00000001-0001-0001-0001-000000000001","id":"00000001-0001-0001-0001-000000000001","name":"Editado","username":"edited","email":"ed@mp.com","enabled":true,"builtin":false,"created":"2023-01-11T15:50:26.921Z","orgas":[{"id":"00000100-0100-0100-0100-000000000100","code":"sys"}],"updated":"2023-01-11T15:50:33.444Z"}],"kind":"string","currentItemCount":1,"updated":"2023-01-12T14:23:00.142Z"}}';

  const testGetOrgaUserResponseOne =
      '{"apiVersion":"1.0","method":"get","params":{"orgaId":"00000100-0100-0100-0100-000000000100","userId":"00000001-0001-0001-0001-000000000001"},"context":"geted by orga id","id":"54eb6d7b-ddcd-4406-8442-d1d4c6f653f0","_id":"54eb6d7b-ddcd-4406-8442-d1d4c6f653f0","data":{"items":[{"_id":"A0000001-0000-0000-1000-000000000000","id":"A0000001-0000-0000-1000-000000000000","orgaId":"00000100-0100-0100-0100-000000000100","userId":"00000001-0001-0001-0001-000000000001","roles":[{"name":"super"}],"enabled":true,"builtIn":true,"created":"2023-01-11T15:50:27.211Z"}],"kind":"string","currentItemCount":1,"updated":"2023-01-16T19:27:45.948Z"}}';

  const testGetOrgaUserResponse =
      '{"apiVersion":"1.0","method":"get","params":{"orgaId":"00000100-0100-0100-0100-000000000100"},"context":"geted by orga id","id":"581905aa-d46d-4cad-b960-12380acd9c3e","_id":"581905aa-d46d-4cad-b960-12380acd9c3e","data":{"items":[{"_id":"A0000001-0000-0000-1000-000000000000","id":"A0000001-0000-0000-1000-000000000000","orgaId":"00000100-0100-0100-0100-000000000100","userId":"00000001-0001-0001-0001-000000000001","roles":[{"name":"super"}],"enabled":true,"builtIn":true,"created":"2023-01-11T15:50:27.211Z"}],"kind":"string","currentItemCount":1,"updated":"2023-01-13T19:23:11.241Z"}}';

  const testGetResponse =
      '{"apiVersion":"1.0","method":"get","params":{"orgaId":"00000200-0200-0200-0200-000000000200"},"context":"geted by orga id","id":"480893fa-0b81-4ce6-9e2f-e4439ce0ba9a","_id":"480893fa-0b81-4ce6-9e2f-e4439ce0ba9a","data":{"items":[{"_id":"00000200-0200-0200-0200-000000000200","id":"00000200-0200-0200-0200-000000000200","name":"Default","code":"def","builtIn":true,"enabled":true}],"kind":"string","currentItemCount":1,"updated":"2023-01-13T15:25:05.437Z"}}';

  const testBoolResponse =
      '{"apiVersion":"1.0","method":"put","params":{"id":"00000200-0200-0200-0200-000000000200","enable":"true"},"context":"orga enabled","id":"cc0794b7-7bea-49a7-92e6-3b0dfad86058","_id":"cc0794b7-7bea-49a7-92e6-3b0dfad86058","data":{"items":[true],"kind":"boolean","currentItemCount":1,"updated":"2023-01-16T22:49:38.210Z"}}';

  const testSession = SessionModel(
      token: SystemKeys.tokenSuperAdmin2023, name: 'Súper', username: 'super');

  const testHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer ${SystemKeys.tokenSuperAdmin2023}",
  };

  group('obtener datos orga, orgas, orgauser y orgausers', () {
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
          (realInvocation) async =>
              http.Response(testGetOrgaUserResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      //act
      final result = await dataSource.getOrgaUsers(orgaId);

      //assert
      expect(result, equals(<OrgaUserModel>[testOrgaUserModel]));
    });
    test('obtener una orgauser', () async {
      //arrange
      when(mockHttpClient.get(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async =>
              http.Response(testGetOrgaUserResponseOne, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      //act
      final result = await dataSource.getOrgaUser(
          testOrgaUserModel.orgaId, testOrgaUserModel.userId);

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
      OrgaModel toEdit = const OrgaModel(
          id: '00000001-0001-0001-0001-000000000001',
          name: "Editado",
          code: 'null',
          enabled: true,
          builtIn: false);
      when(mockHttpClient.put(any,
              body: json.encode(toEdit), headers: testHeaders))
          .thenAnswer((realInvocation) async =>
              http.Response(testGetResponseUpdate, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      //act

      final result = await dataSource.updateOrga(orgaIdSampleUpdate, toEdit);

      //assert
      expect(result, equals(toEdit));
      //expect(toEdit, equals(fakeListOrgas[2]));
    });
    test('actualizar una orgauser', () async {
      //arrange
      const toEdit = OrgaUserModel(
          orgaId: testOrgaId01,
          userId: testUserId01,
          roles: <String>["super"],
          enabled: true,
          builtIn: true);

      List<RoleModel> listInRoles = [];
      for (var element in toEdit.roles) {
        listInRoles.add(RoleModel(name: element, enabled: true));
      }

      final Map<String, dynamic> orgaUserBackend = {
        'orgaId': toEdit.orgaId,
        'userId': toEdit.userId,
        'roles': listInRoles,
        'enabled': toEdit.enabled
      };

      final url = Uri.parse(
          '${UrlBackend.base}/api/v1/orgauser/${toEdit.orgaId}/${toEdit.userId}');

      when(mockHttpClient.put(url,
              body: json.encode(orgaUserBackend), headers: testHeaders))
          .thenAnswer((realInvocation) async =>
              http.Response(testGetOrgaUserResponseOne, 200));

      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      //act

      final result =
          await dataSource.updateOrgaUser(toEdit.orgaId, toEdit.userId, toEdit);

      //assert
      expect(result, equals(toEdit));
    });
  });
  group('agregar datos orga y orgauser', () {
    test('agregar una organización', () async {
      //arrange
      OrgaModel toAdd = const OrgaModel(
          id: '00000001-0001-0001-0001-000000000001',
          name: "Editado",
          code: "null",
          enabled: true,
          builtIn: false);
      when(mockHttpClient.post(any,
              body: json.encode(toAdd), headers: testHeaders))
          .thenAnswer((realInvocation) async =>
              http.Response(testGetResponseUpdate, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act

      final result = await dataSource.addOrga(toAdd);

      //assert
      expect(result, equals(toAdd));
      //expect(fakeListOrgas.length, nearEqual(a, b, epsilon));
    });
    test('agregar una orgauser', () async {
      //arrange

      const toAdd = OrgaUserModel(
          orgaId: testOrgaId01,
          userId: testUserId01,
          roles: <String>["super"],
          enabled: true,
          builtIn: true);

      List<RoleModel> listInRoles = [];
      for (var element in toAdd.roles) {
        listInRoles.add(RoleModel(name: element, enabled: true));
      }

      final Map<String, dynamic> orgaUserBackend = {
        'orgaId': toAdd.orgaId,
        'userId': toAdd.userId,
        'roles': listInRoles,
        'enabled': toAdd.enabled,
        'builtIn': true
      };

      final url = Uri.parse('${UrlBackend.base}/api/v1/orgauser');

      when(mockHttpClient.post(url,
              body: json.encode(orgaUserBackend), headers: testHeaders))
          .thenAnswer((realInvocation) async =>
              http.Response(testGetOrgaUserResponseOne, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act

      final result = await dataSource.addOrgaUser(toAdd);

      //assert
      expect(result, equals(toAdd));
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
      expect(result, equals(true));
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
      expect(result, equals(true));
      //expect(fakeListOrgaUsers.length, equals(count + 1));
    });
  });
  group('habilitar datos orga y orgauser', () {
    test('habilitar una organización', () async {
      //arrange
      when(mockHttpClient.put(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testBoolResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act
      final result = await dataSource.enableOrga(fakeListOrgas[1].id, false);

      //assert
      expect(result, equals(true));
    });
    test('habilitar una orgauser', () async {
      //arrange
      when(mockHttpClient.put(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testBoolResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act
      final result = await dataSource.enableOrgaUser(
          testOrgaUserModel.orgaId, testOrgaUserModel.userId, false);

      //assert
      expect(result, equals(true));
    });
  });
}
