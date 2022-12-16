import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/features/users/domain/entities/user.dart';
import 'package:lomba_frontend/features/users/domain/usecases/enable_user.dart';
import 'package:mockito/mockito.dart';

import 'user_test_helper.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late EnableUser usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = EnableUser(mockUserRepository);
  });

  final newUserId = Guid.newGuid.toString();

  final tUser = User(
      id: newUserId,
      name: 'Test User',
      username: 'test',
      email: 'te@mp.com',
      enabled: true,
      builtIn: false);

  test('debe deshabilitar un user', () async {
    //arrange
    when(mockUserRepository.enableUser(any, any))
        .thenAnswer((_) async => Right(tUser));

    //act
    final result = await usecase.execute(newUserId, false);

    //assert
    expect(result, Right(tUser));
  });
}
