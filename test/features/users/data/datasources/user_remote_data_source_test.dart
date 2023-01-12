import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/data/datasources/local_data_source.dart';
import 'package:lomba_frontend/core/data/models/session_model.dart';
import 'package:lomba_frontend/core/exceptions.dart';
import 'package:lomba_frontend/core/fakedata.dart';
import 'package:lomba_frontend/features/users/data/datasources/user_remote_data_source.dart';
import 'package:lomba_frontend/features/users/data/models/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_remote_data_source_test.mocks.dart';

@GenerateMocks([UserRemoteDataSourceImpl, LocalDataSourceImpl],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {
  late MockHttpClient mockHttpClient;
  late UserRemoteDataSourceImpl dataSource;
  late MockLocalDataSourceImpl mockLocalDataSource;

  late String userId; //Sistema
  late String userIdSampleUpdate;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockLocalDataSource = MockLocalDataSourceImpl();
    dataSource = UserRemoteDataSourceImpl(
        client: mockHttpClient, localDataSource: mockLocalDataSource);

    userId = fakeListUsers[0].id; //Sistema

    userIdSampleUpdate = fakeListUsers[2].id;
  });

  const testUserId = '00000001-0001-0001-0001-000000000001';
  const testUserModel = UserModel(
      id: '00000001-0001-0001-0001-000000000001',
      name: 'Súper',
      username: 'super',
      email: 'super@mp.com',
      enabled: true,
      builtIn: true);

  const testGetResponse =
      '{"apiVersion":"1.0","method":"get","params":{"id":"00000001-0001-0001-0001-000000000001"},"context":"geted by id","id":"37f93961-a189-4182-96b0-28491a8b78df","_id":"37f93961-a189-4182-96b0-28491a8b78df","data":{"items":[{"_id":"00000001-0001-0001-0001-000000000001","id":"00000001-0001-0001-0001-000000000001","name":"Súper","username":"super","email":"super@mp.com","enabled":true,"builtin":true,"created":"2023-01-11T15:50:26.921Z","orgas":[{"id":"00000100-0100-0100-0100-000000000100","code":"sys"}],"updated":"2023-01-11T15:50:33.444Z"}],"kind":"string","currentItemCount":1,"updated":"2023-01-12T14:23:00.142Z"}}';

  const testBoolResponse =
      '{"apiVersion":"1.0","method":"get","params":{"id":"00000001-0001-0001-0001-000000000001"},"context":"geted by id","id":"37f93961-a189-4182-96b0-28491a8b78df","_id":"37f93961-a189-4182-96b0-28491a8b78df","data":{"items":[true],"kind":"string","currentItemCount":1,"updated":"2023-01-12T14:23:00.142Z"}}';

  const testSession = SessionModel(
      token: SystemKeys.tokenSuperAdmin2023, name: 'Súper', username: 'super');

  const testHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer ${SystemKeys.tokenSuperAdmin2023}",
  };

  group('obtener datos user, users', () {
    test('obtener una usuarios', () async {
      //arrange
      when(mockHttpClient.get(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testGetResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act
      final result = await dataSource.getUser(testUserId);

      //assert
      expect(result, equals(testUserModel));
    });
    test('obtener lista de usuarios sin filtrar', () async {
      //arrange
      when(mockHttpClient.get(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testGetResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      //act
      final result = await dataSource.getUsers("", "", "", 1, 10);

      //assert
      expect(result, equals(<UserModel>[testUserModel]));
    });
    test('obtener lista de usuarios filtrada', () async {
      //arrange
      when(mockHttpClient.get(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testGetResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);

      //act
      final result = await dataSource.getUsers("", "Súper", "", 1, 10);

      //assert
      expect(result, equals(<UserModel>[testUserModel]));
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
        final call1 = dataSource.getUser(userId);
        final call2 = dataSource.getUsers("", "", "", 1, 10);

        // assert
        expect(() => call1, throwsA(isA<ServerException>()));
        expect(() => call2, throwsA(isA<ServerException>()));
      },
    );
  });
  group('actualizar datos user', () {
    test('actualizar un usuario', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response("", 200));

      //act
      UserModel toEdit = UserModel(
          id: userIdSampleUpdate,
          name: "Editado",
          username: "edited",
          email: "ed@mp.com",
          enabled: true,
          builtIn: false);
      final result = await dataSource.updateUser(userIdSampleUpdate, toEdit);

      //assert
      expect(result, equals(toEdit));
      expect(toEdit, equals(fakeListUsers[2]));
    });
  });
  group('agregar datos user', () {
    test('agregar una usernización', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response("", 200));

      //act
      UserModel toAdd = UserModel(
          id: Guid.newGuid.toString(),
          name: "Nuevo User",
          username: "newuser",
          email: "nw@mp.com",
          enabled: true,
          builtIn: false);
      final result = await dataSource.addUser(toAdd);

      //assert
      expect(result, equals(toAdd));
      //expect(fakeListUsers.length, nearEqual(a, b, epsilon));
    });
  });
  group('eliminar datos user y useruser', () {
    test('eliminar un usuario', () async {
      //arrange
      when(mockHttpClient.delete(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testBoolResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      //act
      final result = await dataSource.deleteUser(fakeUserIdUser01);

      //assert
      expect(result, equals(true));
      //expect(fakeListUsers.length, equals(count + 1));
    });
  });
  group('habilitar datos user', () {
    test('habilitar un usuario', () async {
      //arrange
      when(mockHttpClient.put(any, headers: testHeaders)).thenAnswer(
          (realInvocation) async => http.Response(testBoolResponse, 200));
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      //act
      final result = await dataSource.enableUser(fakeListUsers[1].id, false);

      //assert
      expect(result, equals(true));
    });
  });
}
