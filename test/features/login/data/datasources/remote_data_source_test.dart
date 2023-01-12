import 'dart:convert';

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
  late RemoteDataSource dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RemoteDataSourceImpl(client: mockHttpClient);
  });

  group('obtener login', () {
    const tLoginAccess = LoginAccessModel(
        token: SystemKeys.tokenSuperAdmin2023,
        username: 'admin@mp.com',
        name: 'admin@mp.com');

    const tusername = 'admin@mp.com';
    const tpassword = '1234';

    final Map<String, dynamic> testAuthData = {
      'username': tusername,
      'password': tpassword
    };

    test('debe retornar el login access cuando la respuesta es 200', () async {
      //arrange

      when(
        mockHttpClient.post(Uri.parse('${UrlBackend.base}/api/v1/auth'),
            body: json.encode(testAuthData),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json",
            }),
      ).thenAnswer(
        (_) async => http.Response(
            '{"apiVersion":"1.0","method":"post","context":"access ok","id":"8e4d664c-cb0b-4fa3-8304-f344f0160dac","_id":"8e4d664c-cb0b-4fa3-8304-f344f0160dac","data":{"items":[{"value":"${SystemKeys.tokenSuperAdmin2023}","orgas":[{"_id":"00000100-0100-0100-0100-000000000100","id":"00000100-0100-0100-0100-000000000100","name":"System","code":"sys","builtin":true,"enabled":true}],"orgaId":"00000100-0100-0100-0100-000000000100"}],"kind":"string","currentItemCount":1,"updated":"2023-01-11T19:50:55.020Z"}}',
            200),
      );
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
          mockHttpClient.post(Uri.parse('${UrlBackend.base}/api/v1/auth'),
              body: json.encode(testAuthData),
              headers: {
                "Accept": "application/json",
                "Content-Type": "application/json",
              }),
        ).thenAnswer(
          (_) async => http.Response(
              '{"apiVersion":"1.0","method":"post","context":"no access","id":"23d3c089-38bb-4e50-a73b-4a91c09bec2c","_id":"23d3c089-38bb-4e50-a73b-4a91c09bec2c","error":{"code":-1,"message":"Not found"}}',
              404),
        );

        // act
        final call = dataSource.getAuthenticate(tusername, tpassword);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
