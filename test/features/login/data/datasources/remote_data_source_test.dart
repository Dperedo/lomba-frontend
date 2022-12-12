import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/exceptions.dart';
import 'package:lomba_frontend/features/login/data/datasources/remote_data_source.dart';
import 'package:lomba_frontend/features/login/data/models/login_access_model.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

import 'remote_data_source_test.mocks.dart';

@GenerateMocks([RemoteDataSourceImpl],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {
  late MockHttpClient mockHttpClient;
  late RemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RemoteDataSourceImpl(client: mockHttpClient);
  });

  group('obtener login', () {
    const tLoginAccess = LoginAccessModel(
        token: SystemKeys.tokenSuperAdmin2023,
        username: 'mp@mp.com',
        name: 'Miguel');

    const tusername = 'mp@mp.com';
    const tpassword = '12345';

    test('debe retornar el login access cuando la respuesta es 200', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response(
              "{'token':'${SystemKeys.tokenSuperAdmin2023}', 'username':'mp@mp.com', 'name': 'Miguel'}",
              200));

      //act
      final result = await dataSource.getAuthenticate(tusername, tpassword);

      //assert
      expect(result, equals(tLoginAccess));
    });

    test(
      'debe lanzar un error de servidor cuando la respuesta es 404',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))),
        ).thenAnswer(
          (_) async => http.Response('Not found', 404),
        );

        // act
        final call = dataSource.getAuthenticate(tusername, tpassword);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
