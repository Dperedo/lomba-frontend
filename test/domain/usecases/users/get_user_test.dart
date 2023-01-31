import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/domain/entities/user.dart';
import 'package:lomba_frontend/domain/usecases/users/get_user.dart';
import 'package:mockito/mockito.dart';

import 'user_test_helper.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late GetUser usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = GetUser(mockUserRepository);
  });

  final newUserId = Guid.newGuid.toString();

  final tUser = User(
      id: newUserId,
      name: 'Test User',
      username: 'test',
      email: 'te@mp.com',
      enabled: true,
      builtIn: false);

  test('debe conserguir un user', () async {
    //arrange
    when(mockUserRepository.getUser(any)).thenAnswer((_) async => Right(tUser));

    //act
    final result = await usecase.execute(newUserId);

    //assert
    expect(result, Right(tUser));
  });
}
