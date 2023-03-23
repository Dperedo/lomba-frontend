import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/data/models/session_model.dart';
import 'package:lomba_frontend/domain/entities/user.dart';
import 'package:lomba_frontend/domain/usecases/local/get_session_status.dart';
import 'package:lomba_frontend/domain/usecases/login/register_user.dart';
import 'package:lomba_frontend/domain/usecases/users/add_user.dart';
import 'package:lomba_frontend/domain/usecases/users/delete_user.dart';
import 'package:lomba_frontend/domain/usecases/users/enable_user.dart';
import 'package:lomba_frontend/domain/usecases/users/exists_user.dart';
import 'package:lomba_frontend/domain/usecases/users/get_user.dart';
import 'package:lomba_frontend/domain/usecases/users/get_users.dart';
import 'package:lomba_frontend/domain/usecases/users/update_user.dart';
import 'package:lomba_frontend/domain/usecases/users/update_user_password.dart';
import 'package:lomba_frontend/presentation/users/bloc/user_bloc.dart';
import 'package:lomba_frontend/presentation/users/bloc/user_event.dart';
import 'package:lomba_frontend/presentation/users/bloc/user_state.dart';
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
  MockSpec<UpdateUserPassword>(),
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
  late UpdateUserPassword mockUpdateUserPassword;

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
    mockUpdateUserPassword = MockUpdateUserPassword();

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
        mockUpdateUserPassword);

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
        mockUpdateUserPassword);
  });

  const testSession = SessionModel(
      token: SystemKeys.tokenSuperAdmin2023,
      name: 'Administrador',
      username: 'admin');

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
      expect(userBloc.state, const UserStart(""));
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
        UserLoaded(tUser, ""),
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
        when(mockRegisterUser.execute(tUser.name, tUser.username, tUser.email,
                '00000100-0100-0100-0100-000000000100', '1234', 'user'))
            .thenAnswer((_) async => const Right(true));
        when(mockGetSession.execute())
            .thenAnswer((_) async => const Right(testSession));
        return userBloc;
      },
      act: (bloc) =>
          bloc.add(OnUserAdd(tUser.name, tUser.username, tUser.email, '1234')),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        UserLoading(),
        UserStart(" El usuario ${tUser.username} fue creado")
      ],
      verify: (bloc) {
        verify(mockRegisterUser.execute(tUser.name, tUser.username, tUser.email,
            '00000100-0100-0100-0100-000000000100', '1234', 'user'));
      },
    );

    blocTest<UserBloc, UserState>(
      'debe preparar el estado para agregar un user',
      build: () {
        return userBloc;
      },
      act: (bloc) => bloc.add(OnUserPrepareForAdd()),
      wait: const Duration(milliseconds: 500),
      expect: () => [UserAdding(false, false)],
      verify: (bloc) {},
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
      act: (bloc) => bloc.add(OnUserDelete(newUserId, 'user')),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          [UserLoading(), const UserStart(" El usuario user fue eliminado")],
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
      act: (bloc) => bloc.add(OnUserEnable(newUserId, false, 'user')),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        UserLoading(),
        UserLoaded(tUser, " El usuario user fue deshabilitado")
      ],
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
      expect: () => [
        UserLoading(),
        UserStart(" El usuario ${tUser.username} fue actualizado")
      ],
      verify: (bloc) {
        verify(mockUpdateUser.execute(newUserId, tUser));
      },
    );

    blocTest<UserBloc, UserState>(
      'debe preparar el estado para editar un user',
      build: () {
        return userBloc;
      },
      act: (bloc) => bloc.add(OnUserPrepareForEdit(tUser)),
      wait: const Duration(milliseconds: 500),
      expect: () => [UserEditing(false, false, tUser)],
      verify: (bloc) {},
    );
  });

  group('Modificar password', () {
    blocTest<UserBloc, UserState>(
      'debe actualizar una password',
      build: () {
        when(mockUpdateUserPassword.execute(newUserId, '1234'))
            .thenAnswer((_) async => const Right(true));
        return userBloc;
      },
      act: (bloc) => bloc.add(OnUserSaveNewPassword('1234', tUser)),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          [UserLoading(), UserLoaded(tUser, " Contraseña Modificada")],
      verify: (bloc) {
        verify(mockUpdateUserPassword.execute(newUserId, '1234'));
      },
    );
  });
  group('mostrar formulario de cambio de password', () {
    blocTest<UserBloc, UserState>(
      'debe mostrar formulario',
      build: () {
        when(mockUpdateUserPassword.execute(newUserId, '1234'))
            .thenAnswer((_) async => const Right(true));
        return userBloc;
      },
      act: (bloc) => bloc.add(OnUserShowPasswordModifyForm(tUser)),
      wait: const Duration(milliseconds: 500),
      expect: () => [UserLoading(), UserUpdatePassword(tUser)],
    );
  });

  group('validar los datos usuario ingresados', () {
    blocTest<UserBloc, UserState>(
      'debe validar los datos para nuevo usuario (no devuelve null)',
      build: () {
        when(mockExistsUser.execute('', tUser.username, tUser.email))
            .thenAnswer((_) async => Right(tUser));
        return userBloc;
      },
      act: (bloc) => bloc.add(
          OnUserValidate(tUser.username, tUser.email, UserAdding(true, true))),
      wait: const Duration(milliseconds: 500),
      expect: () => [],
      verify: (bloc) {
        verify(mockExistsUser.execute('', tUser.username, tUser.email));
      },
    );

    blocTest<UserBloc, UserState>(
      'debe validar los datos para nuevo usuario (devuelve null)',
      build: () {
        when(mockExistsUser.execute('', tUser.username, tUser.email))
            .thenAnswer((_) async => const Right(null));
        return userBloc;
      },
      act: (bloc) => bloc.add(
          OnUserValidate(tUser.username, tUser.email, UserAdding(true, true))),
      wait: const Duration(milliseconds: 500),
      expect: () => [],
      verify: (bloc) {
        verify(mockExistsUser.execute('', tUser.username, tUser.email));
      },
    );

    blocTest<UserBloc, UserState>(
      'debe validar los datos para edit de usuario (no devuelve null)',
      build: () {
        when(mockExistsUser.execute(tUser.id, tUser.username, tUser.email))
            .thenAnswer((_) async => Right(tUser));
        return userBloc;
      },
      act: (bloc) => bloc.add(OnUserValidateEdit(tUser.id, tUser.username,
          tUser.email, UserEditing(true, true, tUser))),
      wait: const Duration(milliseconds: 500),
      expect: () => [],
      verify: (bloc) {
        verify(mockExistsUser.execute(tUser.id, tUser.username, tUser.email));
      },
    );

    blocTest<UserBloc, UserState>(
      'debe validar los datos para edit de usuario (devuelve null)',
      build: () {
        when(mockExistsUser.execute(tUser.id, tUser.username, tUser.email))
            .thenAnswer((_) async => const Right(null));
        return userBloc;
      },
      act: (bloc) => bloc.add(OnUserValidateEdit(tUser.id, tUser.username,
          tUser.email, UserEditing(true, true, tUser))),
      wait: const Duration(milliseconds: 500),
      expect: () => [],
      verify: (bloc) {
        verify(mockExistsUser.execute(tUser.id, tUser.username, tUser.email));
      },
    );
  });
}
