import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/features/login/domain/entities/token.dart';
import 'package:lomba_frontend/features/login/domain/repositories/login_repository.dart';
import 'package:lomba_frontend/features/login/domain/usecases/get_authenticate.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_authenticate_test.mocks.dart';

@GenerateMocks([LoginRepository])
void main() {
  late MockLoginRepository mockLoginRepository;
  late GetAuthenticate usecase;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = GetAuthenticate(mockLoginRepository);
  });

  const tToken = Token(id: 'mp', username: 'mp');
  const tusername = 'mp';
  const tpassword = 'ps';

  test('debe conseguir la autenticación correcta desde el repositorio',
      () async {
    //arrange
    when(mockLoginRepository.getAuthenticate(tusername, tpassword))
        .thenAnswer((_) async => const Right(tToken));

    //act
    final result = await usecase.execute(tusername, tpassword);

    //assert
    expect(result, const Right(tToken));
  });
}
