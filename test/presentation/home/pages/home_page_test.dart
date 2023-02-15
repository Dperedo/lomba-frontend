import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/core/fakedata.dart';
import 'package:lomba_frontend/data/models/session_model.dart';
import 'package:lomba_frontend/domain/entities/flows/post.dart';
import 'package:lomba_frontend/domain/entities/flows/postitem.dart';
import 'package:lomba_frontend/domain/entities/flows/stage.dart';
import 'package:lomba_frontend/domain/entities/flows/textcontent.dart';
import 'package:lomba_frontend/presentation/home/bloc/home_bloc.dart';
import 'package:lomba_frontend/presentation/home/bloc/home_event.dart';
import 'package:lomba_frontend/presentation/home/bloc/home_state.dart';
import 'package:lomba_frontend/presentation/home/pages/home_page.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class FakeHomeState extends Fake implements HomeState {}

class FakeHomeEvent extends Fake implements HomeEvent {}

void main() {
  late MockHomeBloc mockHomeBloc;

  setUpAll(() async {
    registerFallbackValue(FakeHomeState());
    registerFallbackValue(FakeHomeEvent());
    final di = GetIt.instance;
    di.registerFactory(() => mockHomeBloc);
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<HomeBloc>.value(
      value: mockHomeBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  setUp(() {
    mockHomeBloc = MockHomeBloc();
    //mockHomeBloc = MockHomeBloc();
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
        flowId: '',
        orgaId: test_orgaId,
        postitems: <PostItem>[
          PostItem(
              order: 1,
              content: const TextContent(text: 'texto de un post!'),
              type: 'text',
              format: '',
              builtIn: true,
              created: DateTime.now(),
              deleted: null,
              expires: null,
              updated: null)
        ],
        stageId: '',
        title: '',
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

  testWidgets('entrega mensaje bienvenido usuario logueado',
      (WidgetTester tester) async {
    //arrange
    when(() => mockHomeBloc.state).thenReturn(HomeLoaded(
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
    await tester.pumpWidget(makeTestableWidget(HomePage()));
    final message = find.text("Páginas");

    //assert
    expect(message, findsOneWidget);
  });

  testWidgets('entrega mensaje de usuario anónimo sin loguear',
      (WidgetTester tester) async {
    //arrange
    when(() => mockHomeBloc.state).thenReturn(HomeLoaded(
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
    await tester.pumpWidget(makeTestableWidget(HomePage()));
    final message = find.text("Orden");

    //assert
    expect(message, findsOneWidget);
  });

  testWidgets('mostrar circulo de progreso cuando carga información',
      (WidgetTester tester) async {
    //arrange
    when(() => mockHomeBloc.state).thenReturn(HomeLoading());

    //act
    await tester.pumpWidget(makeTestableWidget(HomePage()));
    final indicator = find.byType(CircularProgressIndicator);

    //assert
    expect(indicator, findsOneWidget);
  });
}
