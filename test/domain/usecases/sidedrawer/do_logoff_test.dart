import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/domain/repositories/local_repository.dart';
import 'package:lomba_frontend/domain/usecases/sidedrawer/do_logoff.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../local/get_has_login_test.mocks.dart';

@GenerateMocks([LocalRepository])
void main() {
  late MockLocalRepository mockLocalRepository;
  late DoLogOff usecase;

  setUp(() {
    mockLocalRepository = MockLocalRepository();
    usecase = DoLogOff(mockLocalRepository);
  });

  group('cerrar sesión desde el menú lateral', () {
    test('debe cerrar sesión', () async {
      //arrange

      when(mockLocalRepository.doLogOff())
          .thenAnswer((_) async => const Right(true));

      //act
      final result = await usecase.execute();
      //assert
      expect(result, const Right(true));
    });
  });
}
