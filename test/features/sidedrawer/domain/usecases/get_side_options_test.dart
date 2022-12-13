import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/domain/repositories/local_repository.dart';
import 'package:lomba_frontend/core/domain/usecases/get_session_status.dart';
import 'package:lomba_frontend/features/login/domain/usecases/get_authenticate.dart';
import 'package:lomba_frontend/features/sidedrawer/domain/usecases/get_side_options.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/domain/usecases/get_has_login_test.mocks.dart';

@GenerateMocks([LocalRepository])
void main() {
  late MockLocalRepository mockLocalRepository;
  late GetSideOptions usecase;

  setUp(() {
    mockLocalRepository = MockLocalRepository();
    usecase = GetSideOptions(mockLocalRepository);
  });

  const listAnonymous = <String>["home", "login"];
  const listUser = <String>["home", "logoff", "profile"];
  const listAdmin = <String>["home", "logoff", "profile", "users"];
  const listSuperAdmin = <String>[
    "home",
    "logoff",
    "profile",
    "orgas",
    "users",
    "roles"
  ];

  group('caso de uso de traer opciones de menú', () {
    test('debe conseguir lista de opciones de un anónimo', () async {
      //arrange

      when(mockLocalRepository.getSideMenuListOptions())
          .thenAnswer((_) async => const Right(listAnonymous));

      when(mockLocalRepository.getSessionRole())
          .thenAnswer((_) async => const Right(Roles.Anonymous));

      //act
      final result = await usecase.execute();
      //assert
      expect(result, const Right(listAnonymous));
    });

    test('debe conseguir lista de opciones de un usuario', () async {
      //arrange

      when(mockLocalRepository.getSideMenuListOptions())
          .thenAnswer((_) async => const Right(listUser));

      when(mockLocalRepository.getSessionRole())
          .thenAnswer((_) async => const Right(Roles.User));

      //act
      final result = await usecase.execute();
      //assert
      expect(result, const Right(listUser));
    });

    test('debe conseguir lista de opciones de un admin', () async {
      //arrange

      when(mockLocalRepository.getSideMenuListOptions())
          .thenAnswer((_) async => const Right(listAdmin));

      when(mockLocalRepository.getSessionRole())
          .thenAnswer((_) async => const Right(Roles.Admin));

      //act
      final result = await usecase.execute();
      //assert
      expect(result, const Right(listAdmin));
    });

    test('debe conseguir lista de opciones de un superadmin', () async {
      //arrange

      when(mockLocalRepository.getSideMenuListOptions())
          .thenAnswer((_) async => const Right(listSuperAdmin));

      when(mockLocalRepository.getSessionRole())
          .thenAnswer((_) async => const Right(Roles.SuperAdmin));

      //act
      final result = await usecase.execute();
      //assert
      expect(result, const Right(listSuperAdmin));
    });
  });
}
