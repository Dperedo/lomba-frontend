import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lomba_frontend/features/users/domain/entities/user.dart';
import 'package:lomba_frontend/features/users/domain/usecases/get_users.dart';
import 'package:mockito/mockito.dart';

import 'user_test_helper.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late GetUsers usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = GetUsers(mockUserRepository);
  });

  final newUserId = Guid.newGuid.toString();

  final tUser = User(
      id: newUserId,
      name: 'Test User',
      username: 'test',
      email: 'te@mp.com',
      enabled: true,
      builtIn: false);

  test('debe conseguir lista de users', () async {
    //arrange
    when(mockUserRepository.getUsers(any, any, any, any, any))
        .thenAnswer((_) async => Right(<User>[tUser]));

    //act
    final result = await usecase.execute("", "", "", 1, 10);
    List<User> list = [];

    result.fold((l) => {}, (r) => {list = r});

    //assert
    expect(list, <User>[tUser]);
  });
}
