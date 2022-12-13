import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:lomba_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:lomba_frontend/features/home/presentation/bloc/home_event.dart';
import 'package:lomba_frontend/features/home/presentation/bloc/home_state.dart';
import 'package:lomba_frontend/features/home/presentation/pages/home_page.dart';
import 'package:lomba_frontend/features/sidedrawer/presentation/pages/sidedrawer_page.dart';
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

  testWidgets('entrega mensaje bienvenido usuario logueado',
      (WidgetTester tester) async {
    //arrange
    when(() => mockHomeBloc.state).thenReturn(const HomeLoaded(true));

    //act
    await tester.pumpWidget(_makeTestableWidget(const HomePage()));
    final message = find.text("Bienvenido usuario logueado!");

    //assert
    expect(message, findsOneWidget);
  });

  testWidgets('entrega mensaje de usuario anónimo sin loguear',
      (WidgetTester tester) async {
    //arrange
    when(() => mockHomeBloc.state).thenReturn(const HomeLoaded(false));

    //act
    await tester.pumpWidget(_makeTestableWidget(const HomePage()));
    final message = find.text("Usuario anónimo. Bienvenido.");

    //assert
    expect(message, findsOneWidget);
  });
}
