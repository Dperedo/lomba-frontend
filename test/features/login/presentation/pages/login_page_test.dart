import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:lomba_frontend/core/constants.dart';
import 'package:lomba_frontend/features/login/domain/entities/token.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_bloc.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_event.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_state.dart';
import 'package:lomba_frontend/features/login/presentation/pages/login_page.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

class FakeLoginState extends Fake implements LoginState {}

class FakeLoginEvent extends Fake implements LoginEvent {}

void main() {
  late MockLoginBloc mockLoginBloc;

  setUpAll(() async {
    HttpOverrides.global = null;
    registerFallbackValue(FakeLoginState());
    registerFallbackValue(FakeLoginEvent());

    final di = GetIt.instance;
    di.registerFactory(() => mockLoginBloc);
  });

  setUp(() {
    mockLoginBloc = MockLoginBloc();
  });

  const tToken = Token(id: 'mp', username: 'mp');

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<LoginBloc>.value(
      value: mockLoginBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'debe accionar la consulta del login luego de presionar botón',
    (WidgetTester tester) async {
      // arrange
      when(() => mockLoginBloc.state).thenReturn(LoginEmpty());

      // act
      await tester.pumpWidget(_makeTestableWidget(LoginPage()));
      Finder userNameTextField = find.byKey(const ValueKey("email_id"));
      Finder passwordTextField = find.byKey(const ValueKey("password"));

      await tester.enterText(userNameTextField, 'mp@mp.com');
      await tester.enterText(passwordTextField, '12345678');

      Finder loginButton = find.byType(ElevatedButton);
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // assert
      verify(() => mockLoginBloc.add(OnLoginTriest('mp@mp.com', '12345678')))
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
      await tester.pumpWidget(_makeTestableWidget(LoginPage()));

      // assert
      expect(find.byType(CircularProgressIndicator), equals(findsOneWidget));
    },
  );

  testWidgets(
    'debe pasar a la siguiente página si se consigue el token',
    (WidgetTester tester) async {
      // arrange
      when(() => mockLoginBloc.state).thenReturn(LoginGot(tToken));

      // act
      await tester.pumpWidget(_makeTestableWidget(LoginPage()));
      await tester.runAsync(() async {
        final HttpClient client = HttpClient();
        await client.getUrl(Uri.parse(Urls.weatherIcon('02d')));
      });
      await tester.pumpAndSettle();

      // assert
      expect(find.text("Welcome Home!"), equals(findsOneWidget));
    },
  );
}
