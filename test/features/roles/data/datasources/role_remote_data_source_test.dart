import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/exceptions.dart';
import 'package:lomba_frontend/core/fakedata.dart';
import 'package:lomba_frontend/features/roles/data/datasources/role_remote_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'role_remote_data_source_test.mocks.dart';

@GenerateMocks([RoleRemoteDataSourceImpl],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {
  late MockHttpClient mockHttpClient;
  late RoleRemoteDataSourceImpl dataSource;

  late String roleName; //Sistema

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RoleRemoteDataSourceImpl(client: mockHttpClient);

    roleName = fakeRoles[0].name; //Sistema

  });

  group('obtener datos de rol, roles', () {
    test('obtener un rol', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response("", 200));

      //act
      final result = await dataSource.getRole(roleName);

      //assert
      expect(result, equals(fakeRoles[0]));
    });
    test('obtener lista de roles sin filtrar', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response("", 200));

      //act
      final result = await dataSource.getRoles();

      //assert
      expect(result, equals(fakeRoles));
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
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response("", 200));

      //act
      final result = await dataSource.enableRole(fakeRoles[1].name, false);

      //assert
      expect(result, equals(fakeRoles[1]));
    });
  });
}
