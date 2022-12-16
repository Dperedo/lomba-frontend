import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_bloc.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_event.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_state.dart';
import 'package:lomba_frontend/features/login/presentation/pages/login_page.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

//class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class FakeLoginState extends Fake implements LoginState {}

class FakeLoginEvent extends Fake implements LoginEvent {}

//class FakeHomeEvent extends Fake implements HomeEvent {}

//class FakeHomeState extends Fake implements HomeState {}

void main() {
  late MockLoginBloc mockLoginBloc;
  //late MockHomeBloc mockHomeBloc;

  setUpAll(() async {
    HttpOverrides.global = null;
    registerFallbackValue(FakeLoginState());
    registerFallbackValue(FakeLoginEvent());
    //registerFallbackValue(FakeHomeState());
    //registerFallbackValue(FakeHomeEvent());
    final di = GetIt.instance;
    di.registerFactory(() => mockLoginBloc);
    //di.registerFactory(() => mockHomeBloc);
  });

  setUp(() {
    mockLoginBloc = MockLoginBloc();
    //mockHomeBloc = MockHomeBloc();
  });

  //const tT = Token(id: SystemKeys.token2030, username: 'mp@mp.com');

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<LoginBloc>.value(
      value: mockLoginBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

/*
  Widget makeTestableWidgetHome(Widget body) {
    return BlocProvider<HomeBloc>.value(
      value: mockHomeBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }
*/
  testWidgets(
    'debe accionar la consulta del login luego de presionar botón',
    (WidgetTester tester) async {
      // arrange
      when(() => mockLoginBloc.state).thenReturn(LoginEmpty());

      // act
      await tester.pumpWidget(makeTestableWidget(LoginPage()));
      Finder userNameTextField = find.byKey(const ValueKey("email_id"));
      Finder passwordTextField = find.byKey(const ValueKey("password"));

      await tester.enterText(userNameTextField, 'mp@mp.com');
      await tester.enterText(passwordTextField, '12345');

      Finder loginButton = find.byType(ElevatedButton);
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // assert
      verify(() => mockLoginBloc.add(const OnLoginTriest('mp@mp.com', '12345')))
          .called(1);

      expect(find.byKey(const ValueKey("btn_login")), equals(findsOneWidget));
    },
  );

  testWidgets(
    'debe mostrar spiner cuando está consiguiente la autenticación',
    (WidgetTester tester) async {
      // arrange
      when(() => mockLoginBloc.state).thenReturn(LoginGetting());

      // act
      await tester.pumpWidget(makeTestableWidget(LoginPage()));

      // assert
      expect(find.byType(CircularProgressIndicator), equals(findsOneWidget));
    },
  );

/*
  testWidgets(
    'debe pasar a la siguiente página si se consigue el token',
    (WidgetTester tester) async {
      // arrange

      when(() => mockLoginBloc.state).thenReturn(const LoginGoted(true));
      //when(() => mockHomeBloc.state).thenReturn(HomeStart());
      // act
      await tester
          .pumpWidget(MaterialApp(home: makeTestableWidget(LoginPage())));

      //verify(mockObserver.didPush(route, previousRoute));
      //await tester.pumpAndSettle();
      //await tester.pumpWidget(makeTestableWidgetHome(const HomePage()));
      //await tester.pumpAndSettle();

      // assert
      expect(find.byType(HomePage), equals(findsOneWidget));
    },
  );
  */
}
