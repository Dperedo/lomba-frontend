import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/exceptions.dart';
import 'package:lomba_frontend/data/datasources/login_data_source.dart';
import 'package:lomba_frontend/data/models/login_access_model.dart';
import 'package:lomba_frontend/data/models/session_model.dart';
import 'package:lomba_frontend/data/models/user_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../repositories/local_repository_impl_test.mocks.dart';
import 'login_data_source_test.mocks.dart';

@GenerateMocks([RemoteDataSourceImpl],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {
  late MockHttpClient mockHttpClient;
  late RemoteDataSource dataSource;
  late MockLocalDataSourceImpl mockLocalDataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockLocalDataSource = MockLocalDataSourceImpl();
    dataSource = RemoteDataSourceImpl(
        client: mockHttpClient, localDataSource: mockLocalDataSource);
  });

  const tSession = SessionModel(
      token: SystemKeys.tokenSuperAdmin2023,
      username: 'admin@mp.com',
      name: 'admin@mp.com');

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

  const testUserId = '00000001-0001-0001-0001-000000000001';
  const testUserModel = UserModel(
      id: '00000001-0001-0001-0001-000000000001',
      name: 'Súper',
      username: 'super',
      email: 'super@mp.com',
      enabled: true,
      builtIn: true);

  const testUserModelAdmin = UserModel(
      id: '00000002-0002-0002-0002-000000000002',
      name: 'admin@mp.com',
      username: 'admin@mp.com',
      email: 'admin@mp.com',
      enabled: true,
      builtIn: true);

  const testOrgaId = '00000100-0100-0100-0100-000000000100';

  const testGetauthenticateResponse =
      '{"apiVersion":"1.0","method":"post","context":"access ok","id":"8e4d664c-cb0b-4fa3-8304-f344f0160dac","_id":"8e4d664c-cb0b-4fa3-8304-f344f0160dac","data":{"items":[{"value":"${SystemKeys.tokenSuperAdmin2023}","orgas":[{"_id":"00000100-0100-0100-0100-000000000100","id":"00000100-0100-0100-0100-000000000100","name":"System","code":"sys","builtIn":true,"enabled":true}],"orgaId":"00000100-0100-0100-0100-000000000100"}],"kind":"string","currentItemCount":1,"updated":"2023-01-11T19:50:55.020Z"}}';

  const testRegisterUserResponse =
      '{"apiVersion":"1.0","method":"post","context":"access ok","id":"8e4d664c-cb0b-4fa3-8304-f344f0160dac","_id":"8e4d664c-cb0b-4fa3-8304-f344f0160dac","data":{"items":[true],"kind":"string","currentItemCount":1,"updated":"2023-01-11T19:50:55.020Z"}}';

  const testResponseError1 =
      '{"apiVersion":"1.0","method":"post","context":"no access","id":"23d3c089-38bb-4e50-a73b-4a91c09bec2c","_id":"23d3c089-38bb-4e50-a73b-4a91c09bec2c","error":{"code":-1,"message":"Not found"}}';

  const testSession = SessionModel(
      token: SystemKeys.tokenSuperAdmin2023, name: 'Súper', username: 'super');
  const testHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer ${SystemKeys.tokenSuperAdmin2023}",
  };
  group('obtener login', () {
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
        (_) async => http.Response(testGetauthenticateResponse, 200),
      );
      //act
      final result = await dataSource.getAuthenticate(tusername, tpassword);

      //assert
      expect(result, equals(tSession));
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
          (_) async => http.Response(testResponseError1, 404),
        );

        // act
        final call = dataSource.getAuthenticate(tusername, tpassword);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('registra usuario', () {
    test('debe retornar true cuando registra usuario', () async {
      //arrange
      final Map<String, dynamic> authData = {
        'username': testUserModel.username,
        'password': '1234',
        'orgaId': testOrgaId
      };
      final Map<String, dynamic> regData = {
        'user': testUserModel,
        'auth': authData,
        'roles': 'user'
      };
      when(
        mockHttpClient.post(
            Uri.parse('${UrlBackend.base}/api/v1/auth/registration'),
            body: json.encode(regData),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json",
            }),
      ).thenAnswer(
        (_) async => http.Response(testRegisterUserResponse, 200),
      );
      //act
      final result = await dataSource.registerUser(
          testUserModel, testOrgaId, '1234', 'user');

      //assert
      expect(result, equals(true));
    });

    test('debe retornar error al registra usuario', () async {
      //arrange
      final Map<String, dynamic> authData = {
        'username': testUserModel.username,
        'password': '1234',
        'orgaId': testOrgaId
      };
      final Map<String, dynamic> regData = {
        'user': testUserModel,
        'auth': authData,
        'roles': 'user'
      };
      when(
        mockHttpClient.post(
            Uri.parse('${UrlBackend.base}/api/v1/auth/registration'),
            body: json.encode(regData),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json",
            }),
      ).thenAnswer(
        (_) async => http.Response(testResponseError1, 500),
      );
      //act
      final call =
          dataSource.registerUser(testUserModel, testOrgaId, '1234', 'user');

      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('cambio de organización usuario', () {
    test('debe retornar token cuando cambia organización usuario', () async {
      //arrange
      final Map<String, dynamic> userAndOrgaId = {
        'username': 'admin@mp.com',
        'orgaId': testOrgaId
      };
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      when(
        mockHttpClient.put(Uri.parse('${UrlBackend.base}/api/v1/auth'),
            body: json.encode(userAndOrgaId), headers: testHeaders),
      ).thenAnswer(
        (_) async => http.Response(testGetauthenticateResponse, 200),
      );
      //act
      final result = await dataSource.changeOrga('admin@mp.com', testOrgaId);

      //assert
      expect(result, equals(tSession));
    });

    test('debe retornar error cuando cambia organización usuario', () async {
      //arrange
      final Map<String, dynamic> userAndOrgaId = {
        'username': 'admin@mp.com',
        'orgaId': testOrgaId
      };
      when(mockLocalDataSource.getSavedSession())
          .thenAnswer((realInvocation) async => testSession);
      when(
        mockHttpClient.put(Uri.parse('${UrlBackend.base}/api/v1/auth'),
            body: json.encode(userAndOrgaId), headers: testHeaders),
      ).thenAnswer(
        (_) async => http.Response(testResponseError1, 500),
      );
      //act
      final call = dataSource.changeOrga('admin@mp.com', testOrgaId);

      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('obtener login con google', () {
    test('debe retornar el login access con google cuando la respuesta es 200',
        () async {
      //arrange
      final Map<String, dynamic> googleAuth = {
        'user': testUserModelAdmin,
        'googleToken': 'googleToken'
      };
      when(
        mockHttpClient.post(
            Uri.parse('${UrlBackend.base}/api/v1/auth/withgoogle'),
            body: json.encode(googleAuth),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json",
            }),
      ).thenAnswer(
        (_) async => http.Response(testGetauthenticateResponse, 200),
      );
      //act
      final result = await dataSource.getAuthenticateGoogle(
          testUserModelAdmin, 'googleToken');

      //assert
      expect(result, equals(tLoginAccess));
    });

    test(
      'debe lanzar un error de servidor cuando la respuesta es 404',
      () async {
        // arrange
        final Map<String, dynamic> googleAuth = {
          'user': testUserModelAdmin,
          'googleToken': 'googleToken'
        };
        when(
          mockHttpClient.post(
              Uri.parse('${UrlBackend.base}/api/v1/auth/withgoogle'),
              body: json.encode(googleAuth),
              headers: {
                "Accept": "application/json",
                "Content-Type": "application/json",
              }),
        ).thenAnswer(
          (_) async => http.Response(testResponseError1, 404),
        );

        // act
        final call =
            dataSource.getAuthenticateGoogle(testUserModelAdmin, 'googleToken');

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
