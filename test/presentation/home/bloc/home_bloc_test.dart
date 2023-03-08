import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/failures.dart';
import 'package:lomba_frontend/core/model_container.dart';
import 'package:lomba_frontend/data/models/session_model.dart';
import 'package:lomba_frontend/domain/entities/workflow/post.dart';
import 'package:lomba_frontend/domain/entities/workflow/stage.dart';
import 'package:lomba_frontend/domain/entities/workflow/vote.dart';
import 'package:lomba_frontend/domain/usecases/post/get_latest_posts.dart';
import 'package:lomba_frontend/domain/usecases/post/vote_publication.dart';
import 'package:lomba_frontend/domain/usecases/local/get_has_login.dart';
import 'package:lomba_frontend/domain/usecases/local/get_session_role.dart';
import 'package:lomba_frontend/domain/usecases/local/get_session_status.dart';
import 'package:lomba_frontend/presentation/home/bloc/home_bloc.dart';
import 'package:lomba_frontend/presentation/home/bloc/home_event.dart';
import 'package:lomba_frontend/presentation/home/bloc/home_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_bloc_test.mocks.dart';

@GenerateMocks([
  GetHasLogIn,
  FirebaseAuth,
  GetLatestPosts,
  GetSession,
  VotePublication,
  GetSessionRole
])
void main() {
  late MockGetHasLogIn mockGetHasLogIn;
  late HomeBloc homeBloc;
  late MockFirebaseAuth mockFirebaseAuthInstance;
  late MockGetLatestPosts mockGetLatestPosts;
  late MockGetSession mockGetSession;
  late MockVotePublication mockVotePublication;
  late MockGetSessionRole mockGetSessionRole;

  setUp(() {
    mockGetHasLogIn = MockGetHasLogIn();
    mockFirebaseAuthInstance = MockFirebaseAuth();
    mockGetSession = MockGetSession();
    mockGetLatestPosts = MockGetLatestPosts();
    mockVotePublication = MockVotePublication();
    mockGetSessionRole = MockGetSessionRole();
    homeBloc = HomeBloc(
        mockFirebaseAuthInstance,
        mockGetHasLogIn,
        mockGetSession,
        mockGetLatestPosts,
        mockVotePublication,
        mockGetSessionRole);
  });

  /*
  Datos de pruebas
   */

  final testStages = <Stage>[
    Stage(
        name: 'Carga',
        order: 1,
        queryOut: const {'votes.value': 1},
        id: StagesVotationFlow.stageId01Load,
        enabled: true,
        builtIn: true,
        created: DateTime.now(),
        deleted: null,
        expires: null,
        updated: null),
    Stage(
        name: 'Aprobación',
        order: 2,
        queryOut: const {'totals.totalpositive': 2, 'totals.totalcount': 2},
        id: StagesVotationFlow.stageId02Approval,
        enabled: true,
        builtIn: true,
        created: DateTime.now(),
        deleted: null,
        expires: null,
        updated: null),
    Stage(
        name: 'Votación',
        order: 3,
        queryOut: null,
        id: StagesVotationFlow.stageId03Voting,
        enabled: true,
        builtIn: true,
        created: DateTime.now(),
        expires: null,
        updated: null,
        deleted: null)
  ];

  const bool test_validLogin = true;
  final String test_orgaId = "00000200-0200-0200-0200-000000000200";
  final String test_userId = "00000005-0005-0005-0005-000000000005";
  final String test_flowId = Flows.votationFlowId;
  final String test_stageId = StagesVotationFlow.stageId03Voting;
  final String test_searchText = '';
  const String test_postId = 'post1';
  final Map<String, int> test_fieldsOrder = <String, int>{};
  final int test_pageIndex = 1;
  final int test_pageSize = 10;
  final List<Post> test_listItems = <Post>[
    Post(
        builtIn: false,
        id: 'post1',
        enabled: true,
        created: DateTime.now(),
        stages: testStages,
        deleted: null,
        expires: null,
        flowId: '',
        orgaId: test_orgaId,
        postitems: const [],
        stageId: '',
        title: '',
        totals: const [],
        tracks: const [],
        updated: null,
        userId: test_userId,
        votes: const [])
  ];

  const List<Vote> test_listItemsVote = <Vote>[];

  final int test_itemCount = 1;
  final int test_totalItems = 1;
  final int test_totalPages = 1;
  const String test_connection_failure = 'No existe conexión con internet.';
  const String test_log_off = "Sesión Cerrada";

  const test_Session = SessionModel(
      token: SystemKeys.tokenUser012023, username: 'user@mp.com', name: 'User');

  test(
    'debe tener un mensaje inicial en el home',
    () {
      expect(homeBloc.state, const HomeStart(""));
    },
  );

  blocTest<HomeBloc, HomeState>(
    'debe responder con estado con home cargado con user',
    build: () {
      when(mockGetHasLogIn.execute())
          .thenAnswer((_) async => const Right(true));
      when(mockFirebaseAuthInstance.signInAnonymously())
          .thenAnswer((realInvocation) async => any as UserCredential);
      when(mockGetLatestPosts.execute(test_orgaId, test_userId, test_flowId,
              test_stageId, test_searchText, test_pageIndex, test_pageSize))
          .thenAnswer((realInvocation) async => Right(ModelContainer(
              test_listItems,
              test_itemCount,
              test_pageSize,
              1 + ((test_pageIndex - 1) * test_pageSize),
              test_totalItems,
              test_pageIndex,
              test_totalPages,
              'kind')));
      when(mockGetSession.execute())
          .thenAnswer((_) async => const Right(test_Session));
      when(mockGetSessionRole.execute())
          .thenAnswer((_) async => const Right(<String>['user']));
      return homeBloc;
    },
    act: (bloc) =>
        bloc.add(const OnHomeLoading('', <String, int>{'created': 1}, 1, 10)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      HomeLoading(),
      HomeLoaded(
          test_validLogin,
          test_orgaId,
          test_userId,
          test_flowId,
          test_stageId,
          test_searchText,
          test_fieldsOrder,
          test_pageIndex,
          test_pageSize,
          test_listItems,
          test_itemCount,
          test_totalItems,
          test_totalPages),
    ],
    verify: (bloc) {
      verify(mockGetHasLogIn.execute());
    },
  );

  blocTest<HomeBloc, HomeState>(
    'debe responder con estado con home onlyUser con admin',
    build: () {
      when(mockGetHasLogIn.execute())
          .thenAnswer((_) async => const Right(true));
      when(mockFirebaseAuthInstance.signInAnonymously())
          .thenAnswer((realInvocation) async => any as UserCredential);
      when(mockGetSession.execute())
          .thenAnswer((_) async => const Right(test_Session));
      when(mockGetSessionRole.execute())
          .thenAnswer((_) async => const Right(<String>['admin']));
      return homeBloc;
    },
    act: (bloc) =>
        bloc.add(const OnHomeLoading('', <String, int>{'created': 1}, 1, 10)),
    wait: const Duration(milliseconds: 500),
    expect: () => [HomeLoading(), HomeOnlyUser()],
    verify: (bloc) {
      verify(mockGetHasLogIn.execute());
    },
  );

  blocTest<HomeBloc, HomeState>(
    'debe responder con estado con home error',
    build: () {
      when(mockGetHasLogIn.execute())
          .thenAnswer((_) async => const Right(true));
      when(mockFirebaseAuthInstance.signInAnonymously())
          .thenAnswer((realInvocation) async => any as UserCredential);
      when(mockGetLatestPosts.execute(test_orgaId, test_userId, test_flowId,
              test_stageId, test_searchText, test_pageIndex, test_pageSize))
          .thenAnswer((realInvocation) async =>
              const Left(ConnectionFailure(test_connection_failure)));
      when(mockGetSession.execute())
          .thenAnswer((_) async => const Right(test_Session));
      when(mockGetSessionRole.execute())
          .thenAnswer((_) async => const Right(<String>['user']));
      return homeBloc;
    },
    act: (bloc) =>
        bloc.add(const OnHomeLoading('', <String, int>{'created': 1}, 1, 10)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      HomeLoading(),
      const HomeError(test_connection_failure),
    ],
    verify: (bloc) {
      verify(mockGetHasLogIn.execute());
    },
  );

  blocTest<HomeBloc, HomeState>(
    'debe responder con estado de login FALSE después de cargar',
    build: () {
      when(mockGetHasLogIn.execute())
          .thenAnswer((_) async => const Right(false));
      when(mockFirebaseAuthInstance.signInAnonymously())
          .thenAnswer((realInvocation) async => any as UserCredential);
      when(mockGetLatestPosts.execute(test_orgaId, test_userId, test_flowId,
              test_stageId, test_searchText, test_pageIndex, test_pageSize))
          .thenAnswer((realInvocation) async => Right(ModelContainer(
              test_listItems,
              test_itemCount,
              test_pageSize,
              1 + ((test_pageIndex - 1) * test_pageSize),
              test_totalItems,
              test_pageIndex,
              test_totalPages,
              'kind')));
      when(mockGetSession.execute())
          .thenAnswer((_) async => const Right(test_Session));
      return homeBloc;
    },
    act: (bloc) =>
        bloc.add(const OnHomeLoading('', <String, int>{'created': 1}, 1, 10)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      HomeLoading(),
      HomeLoaded(
          !test_validLogin,
          test_orgaId,
          test_userId,
          test_flowId,
          test_stageId,
          test_searchText,
          test_fieldsOrder,
          test_pageIndex,
          test_pageSize,
          test_listItems,
          test_itemCount,
          test_totalItems,
          test_totalPages),
    ],
    verify: (bloc) {
      verify(mockGetHasLogIn.execute());
      verify(mockFirebaseAuthInstance.signInAnonymously());
      verify(mockGetLatestPosts.execute(test_orgaId, test_userId, test_flowId,
          test_stageId, test_searchText, test_pageIndex, test_pageSize));
    },
  );

  blocTest<HomeBloc, HomeState>(
    'debe responder con estado de login FALSE y cargar home error',
    build: () {
      when(mockGetHasLogIn.execute())
          .thenAnswer((_) async => const Right(false));
      when(mockFirebaseAuthInstance.signInAnonymously())
          .thenAnswer((realInvocation) async => any as UserCredential);
      when(mockGetLatestPosts.execute(test_orgaId, test_userId, test_flowId,
              test_stageId, test_searchText, test_pageIndex, test_pageSize))
          .thenAnswer((realInvocation) async =>
              const Left(ConnectionFailure(test_connection_failure)));
      when(mockGetSession.execute())
          .thenAnswer((_) async => const Right(test_Session));
      return homeBloc;
    },
    act: (bloc) =>
        bloc.add(const OnHomeLoading('', <String, int>{'created': 1}, 1, 10)),
    wait: const Duration(milliseconds: 500),
    expect: () => [HomeLoading(), const HomeError(test_connection_failure)],
    verify: (bloc) {
      verify(mockGetHasLogIn.execute());
      verify(mockFirebaseAuthInstance.signInAnonymously());
      verify(mockGetLatestPosts.execute(test_orgaId, test_userId, test_flowId,
          test_stageId, test_searchText, test_pageIndex, test_pageSize));
    },
  );

  blocTest<HomeBloc, HomeState>(
    'debe responder con estado home star y enviar el mensaje de cierre de sesión',
    build: () {
      return homeBloc;
    },
    act: (bloc) => bloc.add(const OnRestartHome(test_log_off)),
    wait: const Duration(milliseconds: 500),
    expect: () => [const HomeStart(test_log_off)],
  );

  blocTest<HomeBloc, HomeState>(
    'debe enviar el voto y responder con el estado home star',
    build: () {
      when(mockGetSession.execute())
          .thenAnswer((_) async => const Right(test_Session));
      when(mockVotePublication.execute(test_orgaId, test_userId, test_flowId,
              test_stageId, test_postId, 1))
          .thenAnswer((_) async => const Right(ModelContainer(
              test_listItemsVote, 1, null, null, null, null, null, 'kind')));
      return homeBloc;
    },
    act: (bloc) => bloc.add(const OnHomeVote(test_postId, 1)),
    wait: const Duration(milliseconds: 500),
    expect: () => [const HomeStart("")],
    verify: (bloc) {
      verify(mockGetSession.execute());
    },
  );
}
