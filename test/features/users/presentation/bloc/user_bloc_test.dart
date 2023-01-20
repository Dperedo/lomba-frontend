import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/domain/usecases/get_session_status.dart';
import 'package:lomba_frontend/features/login/domain/usecases/register_user.dart';
import 'package:lomba_frontend/features/users/domain/entities/user.dart';
import 'package:lomba_frontend/features/users/domain/usecases/add_user.dart';
import 'package:lomba_frontend/features/users/domain/usecases/delete_user.dart';
import 'package:lomba_frontend/features/users/domain/usecases/enable_user.dart';
import 'package:lomba_frontend/features/users/domain/usecases/exists_user.dart';
import 'package:lomba_frontend/features/users/domain/usecases/get_user.dart';
import 'package:lomba_frontend/features/users/domain/usecases/get_users.dart';
import 'package:lomba_frontend/features/users/domain/usecases/update_user.dart';
import 'package:lomba_frontend/features/users/domain/usecases/exists_user.dart';
import 'package:lomba_frontend/features/users/presentation/bloc/user_bloc.dart';
import 'package:lomba_frontend/features/users/presentation/bloc/user_event.dart';
import 'package:lomba_frontend/features/users/presentation/bloc/user_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AddUser>(),
  MockSpec<DeleteUser>(),
  MockSpec<EnableUser>(),
  MockSpec<GetUser>(),
  MockSpec<GetUsers>(),
  MockSpec<UpdateUser>(),
  MockSpec<RegisterUser>(),
  MockSpec<GetSession>(),
  MockSpec<ExistsUser>(),
])
Future<void> main() async {
  late AddUser mockAddUser;
  late DeleteUser mockDeleteUser;
  late EnableUser mockEnableUser;
  late GetUser mockGetUser;
  late GetUsers mockGetUsers;
  late UpdateUser mockUpdateUser;
  late RegisterUser mockRegisterUser;
  late GetSession mockGetSession;
  late ExistsUser mockExistsUser;

  late UserBloc userBloc;

  setUp(() {
    mockAddUser = MockAddUser();
    mockDeleteUser = MockDeleteUser();
    mockEnableUser = MockEnableUser();
    mockGetUser = MockGetUser();
    mockGetUsers = MockGetUsers();
    mockUpdateUser = MockUpdateUser();
    mockRegisterUser = MockRegisterUser();
    mockGetSession = MockGetSession();
    mockExistsUser = MockExistsUser();

    userBloc = UserBloc(
      mockAddUser,
      mockDeleteUser,
      mockEnableUser,
      mockGetUser,
      mockGetUsers,
      mockUpdateUser,
      mockRegisterUser,
      mockGetSession,
      mockExistsUser,
    );
  });

  final newUserId = Guid.newGuid.toString();

  final tUser = User(
      id: newUserId,
      name: 'Test User',
      username: 'test',
      email: 'te@mp.com',
      enabled: true,
      builtIn: false);

  test(
    'el estado inicial debe ser Start',
    () {
      //assert
      expect(userBloc.state, UserStart());
    },
  );

  group('conseguir usernizaciones y userusers', () {
    blocTest<UserBloc, UserState>(
      'debe lanzar el spinner y devolver estado con listado',
      build: () {
        when(mockGetUsers.execute("", "", "", 1, 10))
            .thenAnswer((_) async => Right(<User>[tUser]));
        return userBloc;
      },
      act: (bloc) => bloc.add(const OnUserListLoad("", "", "", 1)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        UserLoading(),
        UserListLoaded(<User>[tUser]),
      ],
      verify: (bloc) {
        verify(mockGetUsers.execute("", "", "", 1, 10));
      },
    );

    blocTest<UserBloc, UserState>(
      'debe lanzar el spinner y devolver estado con la user',
      build: () {
        when(mockGetUser.execute(newUserId))
            .thenAnswer((_) async => Right(tUser));
        return userBloc;
      },
      act: (bloc) => bloc.add(OnUserLoad(newUserId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        UserLoading(),
        UserLoaded(tUser),
      ],
      verify: (bloc) {
        verify(mockGetUser.execute(newUserId));
      },
    );
  });

  group('agregar usernizaciones y userusers', () {
    blocTest<UserBloc, UserState>(
      'debe agregar un user',
      build: () {
        when(mockAddUser.execute(
                tUser.name, tUser.username, tUser.email, tUser.enabled))
            .thenAnswer((_) async => Right(tUser));
        return userBloc;
      },
      act: (bloc) => bloc.add(
          OnUserAdd(tUser.name, tUser.username, tUser.email, '1234')),
      wait: const Duration(milliseconds: 500),
      expect: () => [UserLoading(), UserStart()],
      verify: (bloc) {
        verify(mockAddUser.execute(
            tUser.name, tUser.username, tUser.email, tUser.enabled));
      },
    );
  });

  group('eliminar users y userusers', () {
    blocTest<UserBloc, UserState>(
      'debe eliminar un user',
      build: () {
        when(mockDeleteUser.execute(newUserId))
            .thenAnswer((_) async => const Right(true));
        return userBloc;
      },
      act: (bloc) => bloc.add(OnUserDelete(newUserId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [UserLoading(), UserStart()],
      verify: (bloc) {
        verify(mockDeleteUser.execute(newUserId));
      },
    );
  });
  group('deshabilitar users y userusers', () {
    blocTest<UserBloc, UserState>(
      'debe deshabilitar un user',
      build: () {
        when(mockEnableUser.execute(newUserId, false))
            .thenAnswer((_) async => Right(tUser));
        return userBloc;
      },
      act: (bloc) => bloc.add(OnUserEnable(newUserId, false)),
      wait: const Duration(milliseconds: 500),
      expect: () => [UserLoading(), UserLoaded(tUser)],
      verify: (bloc) {
        verify(mockEnableUser.execute(newUserId, false));
      },
    );
  });
  group('actualizar users y userusers', () {
    blocTest<UserBloc, UserState>(
      'debe actualizar un user',
      build: () {
        when(mockUpdateUser.execute(newUserId, tUser))
            .thenAnswer((_) async => Right(tUser));
        return userBloc;
      },
      act: (bloc) => bloc.add(OnUserEdit(
          newUserId, tUser.name, tUser.username, tUser.email, tUser.enabled)),
      wait: const Duration(milliseconds: 500),
      expect: () => [UserLoading(), UserStart()],
      verify: (bloc) {
        verify(mockUpdateUser.execute(newUserId, tUser));
      },
    );
  });
}
