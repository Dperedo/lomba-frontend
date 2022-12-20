import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/exceptions.dart';
import 'package:lomba_frontend/core/fakedata.dart';
import 'package:lomba_frontend/features/users/data/datasources/user_remote_data_source.dart';
import 'package:lomba_frontend/features/users/data/models/user_model.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

import 'user_remote_data_source_test.mocks.dart';

@GenerateMocks([UserRemoteDataSourceImpl],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {
  late MockHttpClient mockHttpClient;
  late UserRemoteDataSourceImpl dataSource;

  late String userId; //Sistema
  late UserModel filteredSystemUser;
  late String userIdSampleUpdate;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = UserRemoteDataSourceImpl(client: mockHttpClient);

    userId = fakeListUsers[0].id; //Sistema
    filteredSystemUser =
        fakeListUsers.singleWhere((element) => element.name.contains("Súper"));

    userIdSampleUpdate = fakeListUsers[2].id;
  });

  group('obtener datos user, users', () {
    test('obtener una usuarios', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response("", 200));

      //act
      final result = await dataSource.getUser(userId);

      //assert
      expect(result, equals(fakeListUsers[0]));
    });
    test('obtener lista de usuarios sin filtrar', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response("", 200));

      //act
      final result = await dataSource.getUsers("", "", "", 1, 10);

      //assert
      expect(result, equals(fakeListUsers));
    });
    test('obtener lista de usuarios filtrada', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response("", 200));

      //act
      final result = await dataSource.getUsers("", "Súper", "", 1, 10);

      //assert
      expect(result, equals(<UserModel>[filteredSystemUser]));
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
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response("", 200));

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
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response("", 200));

      //act
      final result = await dataSource.enableUser(fakeListUsers[1].id, false);

      //assert
      expect(result, equals(fakeListUsers[1]));
    });
  });
}
