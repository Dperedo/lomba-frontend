import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/domain/repositories/local_repository.dart';
import 'package:lomba_frontend/domain/usecases/local/get_has_login.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_has_login_test.mocks.dart';

@GenerateMocks([LocalRepository])
void main() {
  late MockLocalRepository mockLocalRepository;
  late GetHasLogIn usecase;

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
