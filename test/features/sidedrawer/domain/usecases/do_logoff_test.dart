import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/domain/repositories/local_repository.dart';
import 'package:lomba_frontend/features/sidedrawer/domain/usecases/do_logoff.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/domain/usecases/get_has_login_test.mocks.dart';

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
