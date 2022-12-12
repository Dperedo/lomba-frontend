import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/data/models/session_model.dart';
import 'package:lomba_frontend/core/domain/repositories/local_repository.dart';
import 'package:lomba_frontend/core/domain/usecases/get_has_login.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_has_login_test.mocks.dart';

@GenerateMocks([LocalRepository])
void main() {
  late MockLocalRepository mockLocalRepository;
  late GetHasLogIn usecase;

  const tSessionModel = SessionModel(
      token: SystemKeys.tokenSuperAdmin2023,
      username: 'mp@mp.com',
      name: 'Miguel');

  const tEmptySessionModel = SessionModel(token: "", username: "", name: "");
  const tInvalidTokenSessionModel = SessionModel(
      token: SystemKeys.tokenExpiredSuperAdmin,
      username: 'mp@mp.com',
      name: 'Miguel');

  setUp(() {
    mockLocalRepository = MockLocalRepository();
    usecase = GetHasLogIn(mockLocalRepository);
  });

  test('debe responder session activa con session OK', () async {
    //arrange
    when(mockLocalRepository.hasLogIn())
        .thenAnswer((_) async => const Right(true));

    //act
    final result = await usecase.execute();

    //assert
    expect(result, const Right(true));
  });

  test('debe responder session inactiva con Session empty', () async {
    //arrange
    when(mockLocalRepository.hasLogIn())
        .thenAnswer((_) async => const Right(false));

    //act
    final result = await usecase.execute();

    //assert
    expect(result, const Right(false));
  });
}
