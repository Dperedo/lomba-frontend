import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/domain/usecases/users/delete_user.dart';
import 'package:mockito/mockito.dart';

import 'user_test_helper.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late DeleteUser usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = DeleteUser(mockUserRepository);
  });

  final newUserId = Guid.newGuid.toString();

  test('debe eliminar un nuevo user', () async {
    //arrange
    when(mockUserRepository.deleteUser(any))
        .thenAnswer((_) async => const Right(true));

    //act
    final result = await usecase.execute(newUserId);

    //assert
    expect(result, const Right(true));
  });
}
