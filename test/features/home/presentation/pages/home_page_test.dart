import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:lomba_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:lomba_frontend/features/home/presentation/bloc/home_event.dart';
import 'package:lomba_frontend/features/home/presentation/bloc/home_state.dart';
import 'package:lomba_frontend/features/home/presentation/pages/home_page.dart';
import 'package:lomba_frontend/features/sidedrawer/presentation/widgets/sidedrawer.dart';
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

  Widget _makeTestableWidget(Widget body) {
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

  testWidgets('prueba de mensajes en home', (WidgetTester tester) async {});

  testWidgets('home muestra sidedrawer', (WidgetTester tester) async {
    //arrange
    when(() => mockHomeBloc.state).thenReturn(HomeStart());

    await tester.pumpWidget(_makeTestableWidget(const HomePage()));

    //act
    //final drawer = find.byType(AppBar);
    final drawer = find.byWidget(const SideDrawer());
    //assert
    expect(drawer, findsNothing);
  });
}
