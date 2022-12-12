import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/data/models/session_model.dart';
import 'package:lomba_frontend/core/domain/repositories/local_repository.dart';
import 'package:lomba_frontend/core/domain/usecases/get_has_login.dart';
import 'package:lomba_frontend/core/domain/usecases/get_session_status.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_session_status_test.mocks.dart';

@GenerateMocks([LocalRepository])
void main() {
  late MockLocalRepository mockLocalRepository;
  late GetSession usecase;

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
    usecase = GetSession(mockLocalRepository);
  });

  test('debe responder session activa', () async {
    //arrange
    when(mockLocalRepository.getSession())
        .thenAnswer((_) async => const Right(tSessionModel));

    //act
    final result = await usecase.execute();

    //assert
    expect(result, const Right(tSessionModel));
  });

  test('debe responder session vacía', () async {
    //arrange
    when(mockLocalRepository.getSession())
        .thenAnswer((_) async => const Right(tEmptySessionModel));

    //act
    final result = await usecase.execute();

    //assert
    expect(result, const Right(tEmptySessionModel));
  });

  test('debe responder session vacía cuando es invalid', () async {
    //arrange
    when(mockLocalRepository.getSession())
        .thenAnswer((_) async => const Right(tEmptySessionModel));

    //act
    final result = await usecase.execute();

    //assert
    expect(result, const Right(tEmptySessionModel));
  });
}
