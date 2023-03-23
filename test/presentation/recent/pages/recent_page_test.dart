import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/fakedata.dart';
import 'package:lomba_frontend/data/models/session_model.dart';
import 'package:lomba_frontend/domain/entities/workflow/post.dart';
import 'package:lomba_frontend/domain/entities/workflow/postitem.dart';
import 'package:lomba_frontend/domain/entities/workflow/stage.dart';
import 'package:lomba_frontend/domain/entities/workflow/textcontent.dart';
import 'package:lomba_frontend/presentation/recent/bloc/recent_bloc.dart';
import 'package:lomba_frontend/presentation/recent/bloc/recent_event.dart';
import 'package:lomba_frontend/presentation/recent/bloc/recent_state.dart';
import 'package:lomba_frontend/presentation/recent/pages/recent_page.dart';
import 'package:mocktail/mocktail.dart';

class MockRecentBloc extends MockBloc<RecentEvent, RecentState>
    implements RecentBloc {}

class FakeRecentState extends Fake implements RecentState {}

class FakeRecentEvent extends Fake implements RecentEvent {}

void main() {
  late MockRecentBloc mockRecentBloc;

  setUpAll(() async {
    registerFallbackValue(FakeRecentState());
    registerFallbackValue(FakeRecentEvent());
    final di = GetIt.instance;
    di.registerFactory(() => mockRecentBloc);
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<RecentBloc>.value(
      value: mockRecentBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  setUp(() {
    mockRecentBloc = MockRecentBloc();
    //mockRecentBloc = MockRecentBloc();
  });

  /*
  Datos de pruebas
   */

  final test_stages = <Stage>[
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
  final String test_orgaId = fakeOrgaIdSample02;
  final String test_userId = fakeUserIdUser01;
  final String test_flowId = Flows.votationFlowId;
  final String test_stageId = StagesVotationFlow.stageId03Voting;
  final String test_searchText = '';
  final Map<String, int> test_fieldsOrder = <String, int>{"created": 1};
  final Map<String, int> test_fieldsOrderLatest = <String, int>{"latest": 1};

  final int test_pageIndex = 1;
  final int test_pageSize = 10;
  final List<Post> test_listItems = <Post>[
    Post(
        builtIn: false,
        id: 'post1',
        enabled: true,
        created: DateTime.now(),
        stages: test_stages,
        deleted: null,
        expires: null,
        flowId: Flows.votationFlowId,
        orgaId: test_orgaId,
        postitems: <PostItem>[
          PostItem(
              order: 1,
              content: const TextContent(text: 'texto de un post!'),
              type: 'text',
              format: '',
              builtIn: false,
              created: DateTime.now(),
              deleted: null,
              expires: null,
              updated: null)
        ],
        stageId: StagesVotationFlow.stageId01Load,
        title: 'título del post',
        totals: const [],
        tracks: const [],
        updated: null,
        userId: test_userId,
        votes: const [])
  ];

  final int test_itemCount = 1;
  final int test_totalItems = 1;
  final int test_totalPages = 1;

  const test_Session = SessionModel(
      token: SystemKeys.tokenSuperAdmin2023,
      username: 'rev@mp.com',
      name: 'Revisor');

  testWidgets('Muestra caja de búsqueda', (WidgetTester tester) async {
    //arrange
    when(() => mockRecentBloc.state).thenReturn(RecentLoaded(
        test_validLogin,
        test_orgaId,
        test_userId,
        test_flowId,
        test_stageId,
        test_searchText,
        test_fieldsOrderLatest,
        test_pageIndex,
        test_pageSize,
        test_listItems,
        test_itemCount,
        test_totalItems,
        test_totalPages));

    //act
    await tester.pumpWidget(makeTestableWidget(RecentPage()));
    final searchField = find.byKey(const ValueKey("search_field"));

    //assert
    expect(searchField, findsOneWidget);
  });

/*
  //este test debe cambiar para cuando se apliquen los post en él

  testWidgets('entrega mensaje de usuario anónimo sin loguear',
      (WidgetTester tester) async {
    //arrange
    when(() => mockRecentBloc.state).thenReturn(RecentLoaded(
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
        test_totalPages));

    //act
    await tester.pumpWidget(makeTestableWidget(RecentPage()));
    final message = find.text("Orden");

    //assert
    expect(message, findsOneWidget);
  });
*/
  testWidgets('mostrar circulo de progreso cuando carga información',
      (WidgetTester tester) async {
    //arrange
    when(() => mockRecentBloc.state).thenReturn(RecentLoading());

    //act
    await tester.pumpWidget(makeTestableWidget(RecentPage()));
    final indicator = find.byType(CircularProgressIndicator);

    //assert
    expect(indicator, findsOneWidget);
  });

  testWidgets('mostrar el texto recientes en el título',
      (WidgetTester tester) async {
    //arrange
    when(() => mockRecentBloc.state).thenReturn(const RecentStart(''));

    //act
    await tester.pumpWidget(makeTestableWidget(RecentPage()));
    final recientes = find.text("Recientes");

    //assert
    expect(recientes, findsOneWidget);
  });

  /*testWidgets('debe emitir el evento OnRecentLoading',
      (WidgetTester tester) async {
    //arrange
    when(() => mockRecentBloc.state).thenReturn(const RecentStart(''));

    //act
    await tester.pumpWidget(makeTestableWidget(RecentPage()));
    Finder title = find.text("");

    //assert
    verify(() => mockRecentBloc.add(OnRecentLoading(
                '', test_fieldsOrderLatest, 1, test_pageSize))).called(1);
    expect(title, findsOneWidget);
  });*/
}
