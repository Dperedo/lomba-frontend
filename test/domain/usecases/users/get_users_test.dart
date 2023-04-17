import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/model_container.dart';

import 'package:lomba_frontend/domain/entities/user.dart';
import 'package:lomba_frontend/domain/usecases/users/get_users.dart';
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
        .thenAnswer((_) async => Right(ModelContainer.fromItem(tUser)));

    //act
    final result =
        await usecase.execute("", "", <String, int>{"email": 1}, 1, 10);
    ModelContainer<User> list = ModelContainer.empty();

    result.fold((l) => {}, (r) => {list = r});

    //assert
    expect(list, ModelContainer.fromItem(tUser));
  });
}
