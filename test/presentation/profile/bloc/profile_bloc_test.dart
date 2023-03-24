import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/data/models/session_model.dart';
import 'package:lomba_frontend/domain/usecases/local/get_session_status.dart';
import 'package:lomba_frontend/presentation/profile/bloc/profile_bloc.dart';
import 'package:lomba_frontend/presentation/profile/bloc/profile_event.dart';
import 'package:lomba_frontend/presentation/profile/bloc/profile_state.dart';
import 'package:lomba_frontend/domain/entities/user.dart';
import 'package:lomba_frontend/domain/usecases/users/get_user.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_bloc_test.mocks.dart';

@GenerateMocks([GetUser, GetSession])
void main() async {
  late MockGetUser mockGetUser;
  late MockGetSession mockGetSession;
  late ProfileBloc profileBloc;
  const testUserId = '00000001-0001-0001-0001-000000000001';
  final newUserId = Guid.newGuid.toString();
  final tUser = User(
      id: newUserId,
      name: 'Test User',
      username: 'test',
      email: 'te@mp.com',
      enabled: true,
      builtIn: false);
  const testSession = SessionModel(
      token: SystemKeys.tokenSuperAdmin2023, name: 'Súper', username: 'super');
  setUp(() {
    mockGetUser = MockGetUser();
    mockGetSession = MockGetSession();
    profileBloc = ProfileBloc(mockGetUser, mockGetSession);
  });

  test(
    'el estado inicial debe ser Start',
    () {
      //assert
      expect(profileBloc.state, const ProfileStart(''));
    },
  );

  blocTest<ProfileBloc, ProfileState>(
    'debe responder con estado de login TRUE después de cargar',
    build: () {
      when(mockGetUser.execute(testUserId))
          .thenAnswer((_) async => Right(tUser));
      when(mockGetSession.execute())
          .thenAnswer((_) async => const Right(testSession));
      return profileBloc;
    },
    act: (bloc) => bloc.add(const OnProfileLoad(testUserId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      ProfileLoading(),
      ProfileLoaded(tUser),
    ],
    verify: (bloc) {
      verify(mockGetUser.execute(testUserId));
    },
  );

  blocTest<ProfileBloc, ProfileState>(
    'debe responder con estado de login TRUE después de cargar con userId = null',
    build: () {
      when(mockGetUser.execute(testUserId))
          .thenAnswer((_) async => Right(tUser));
      when(mockGetSession.execute())
          .thenAnswer((_) async => const Right(testSession));
      return profileBloc;
    },
    act: (bloc) => bloc.add(const OnProfileLoad(null)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      ProfileLoading(),
      ProfileLoaded(tUser),
    ],
    verify: (bloc) {
      verify(mockGetUser.execute(testUserId));
    },
  );
}
