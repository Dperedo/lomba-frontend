import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/exceptions.dart';
import 'package:lomba_frontend/features/login/data/datasources/remote_data_source.dart';
import 'package:lomba_frontend/features/login/data/models/token_model.dart';
import 'package:lomba_frontend/features/login/domain/entities/token.dart';
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
    const tToken = TokenModel(id: SystemKeys.token2030, username: 'mp');
    const tusername = 'mp';
    const tpassword = 'ps';

    test('debe retornar el token cuando la respuesta es 200', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName("London"))))
          .thenAnswer((realInvocation) async => http.Response(
              "{'token':'${SystemKeys.token2030}', 'username':'mp'}", 200));

      //act
      final result = await dataSource.getAuthenticate(tusername, tpassword);

      //assert
      expect(result, equals(tToken));
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
