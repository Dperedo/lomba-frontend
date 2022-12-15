import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/exceptions.dart';
import 'package:lomba_frontend/core/fakedata.dart';
import 'package:lomba_frontend/features/orgas/data/datasources/orga_remote_data_source.dart';
import 'package:lomba_frontend/features/orgas/data/models/orga_model.dart';
import 'package:lomba_frontend/features/orgas/data/models/orgauser_model.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

import 'orga_remote_data_source_test.mocks.dart';

@GenerateMocks([OrgaRemoteDataSourceImpl],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {
  late MockHttpClient mockHttpClient;
  late OrgaRemoteDataSourceImpl dataSource;

  late String orgaId; //Sistema
  late OrgaModel filteredSystemOrga;
  late List<OrgaUserModel> listOrgaUsersSystem;
  late String orgaIdSampleUpdate;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = OrgaRemoteDataSourceImpl(client: mockHttpClient);

    orgaId = fakeListOrgas[0].id; //Sistema
    filteredSystemOrga = fakeListOrgas
        .singleWhere((element) => element.name.contains("Sistema"));
    listOrgaUsersSystem =
        fakeListOrgaUsers.where((element) => element.orgaId == orgaId).toList();

    orgaIdSampleUpdate = fakeListOrgas[2].id;
  });

  group('obtener datos orga, orgas y orgausers', () {
    test('obtener una organización', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response("", 200));

      //act
      final result = await dataSource.getOrga(orgaId);

      //assert
      expect(result, equals(fakeListOrgas[0]));
    });
    test('obtener lista de organizaciones sin filtrar', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response("", 200));

      //act
      final result = await dataSource.getOrgas("", "", 1, 10);

      //assert
      expect(result, equals(fakeListOrgas));
    });
    test('obtener lista de organizaciones filtrada', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response("", 200));

      //act
      final result = await dataSource.getOrgas("Sistema", "", 1, 10);

      //assert
      expect(result, equals(<OrgaModel>[filteredSystemOrga]));
    });
    test('obtener lista de orgausers', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response("", 200));

      //act
      final result = await dataSource.getOrgaUsers(orgaId);

      //assert
      expect(result, equals(listOrgaUsersSystem));
    });

    test(
      '''debe lanzar un error de servidor al conseguir 
      cuando la respuesta es distinta a 200''',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))),
        ).thenAnswer(
          (_) async => http.Response('', 404),
        );

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

      final count = fakeListOrgas.length;
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

      final count = fakeListOrgaUsers.length;
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
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response("", 200));

      final count = fakeListOrgas.length;
      //act
      final result = await dataSource.deleteOrga(fakeOrgaIdSample03);

      //assert
      expect(result, equals(true));
      //expect(fakeListOrgas.length, equals(count + 1));
    });
    test('eliminar una orgauser', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response("", 200));

      final count = fakeListOrgaUsers.length;
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
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response("", 200));

      //act
      final result = await dataSource.enableOrga(fakeListOrgas[1].id, false);

      //assert
      expect(result, equals(fakeListOrgas[1]));
    });
    test('habilitar una orgauser', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response("", 200));

      //act
      final result = await dataSource.enableOrgaUser(
          fakeListOrgas[1].id, fakeListOrgaUsers[1].userId, false);

      //assert
      expect(result.enabled, equals(false));
    });
  });
}
