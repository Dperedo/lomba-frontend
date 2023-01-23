import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:lomba_frontend/core/fakedata.dart';
import 'package:lomba_frontend/features/users/presentation/bloc/user_bloc.dart';
import 'package:lomba_frontend/features/users/presentation/bloc/user_event.dart';
import 'package:lomba_frontend/features/users/presentation/bloc/user_state.dart';
import 'package:lomba_frontend/features/users/presentation/pages/users_page.dart';
import 'package:mocktail/mocktail.dart';

class MockUserBloc extends MockBloc<UserEvent, UserState> implements UserBloc {}

class FakeUserState extends Fake implements UserState {}

class FakeUserEvent extends Fake implements UserEvent {}

void main() {
  late MockUserBloc mockUserBloc;

  setUpAll(() async {
    HttpOverrides.global = null;
    registerFallbackValue(FakeUserState());
    registerFallbackValue(FakeUserEvent());

    mockUserBloc = MockUserBloc();

    final di = GetIt.instance;

    di.registerFactory(() => mockUserBloc);
  });

  setUp(() {});

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>.value(
          value: mockUserBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tUser2 = fakeListUsers[1].toEntity();

  group('lista de usernizaciones al entrar a la página', () {
    testWidgets(
      'en el primer estado de la página debe al menos mostrar el título',
      (WidgetTester tester) async {
        // arrange
        when(() => mockUserBloc.state).thenReturn(UserStart());

        // act
        await tester.pumpWidget(makeTestableWidget(UsersPage()));
        Finder titulo = find.text("Usuarios");
        //await tester.pumpAndSettle(const Duration(seconds: 1));

        // assert
        verify(() => mockUserBloc.add(const OnUserListLoad("", "", "", 1)))
            .called(1);

        expect(titulo, equals(findsOneWidget));
      },
    );

    testWidgets(
      'al darle tap a un usuario mostrar su información',
      (WidgetTester tester) async {
        // arrange
        when(() => mockUserBloc.state).thenReturn(UserLoaded(tUser2));

        // act
        await tester.pumpWidget(makeTestableWidget(UsersPage()));
        Finder titulo = find.text(tUser2.name);

        //assert
        expect(titulo, equals(findsOneWidget));
      },
    );
  });

  group('eliminar y deshabilitar User', () {
    testWidgets(
        'click en eliminar y luego confirmar eliminar gatilla evento de eliminación',
        (WidgetTester tester) async {
      // arrange
      when(() => mockUserBloc.state).thenReturn(UserLoaded(tUser2));

      // act
      await tester.pumpWidget(makeTestableWidget(UsersPage()));
      Finder disableButton = find.byKey(const ValueKey("btnDeleteOption"));
      await tester.tap(disableButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      Finder confirmButton = find.byKey(const ValueKey("btnConfirmDelete"));
      await tester.tap(confirmButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      //assert

      verify(() => mockUserBloc.add(OnUserDelete(tUser2.id))).called(1);
    });

    testWidgets('click en eliminar y luego cancelar debe cerrar el diálogo',
        (WidgetTester tester) async {
      // arrange
      when(() => mockUserBloc.state).thenReturn(UserLoaded(tUser2));

      // act
      await tester.pumpWidget(makeTestableWidget(UsersPage()));
      Finder disableButton = find.byKey(const ValueKey("btnDeleteOption"));
      await tester.tap(disableButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      Finder cancelButton = find.byKey(const ValueKey("btnCancelDelete"));
      await tester.tap(cancelButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      Finder showedDialog = find.byType(AlertDialog);
      //assert
      expect(showedDialog, findsNothing);
    });

    testWidgets(
        'click en deshabilitar debe mostrar dialogo de confirmación al usuario',
        (WidgetTester tester) async {
      // arrange
      when(() => mockUserBloc.state).thenReturn(UserLoaded(tUser2));

      // act
      await tester.pumpWidget(makeTestableWidget(UsersPage()));
      Finder disableButton = find.byKey(const ValueKey("btnEnableOption"));
      await tester.tap(disableButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      Finder confirmButton = find.byKey(const ValueKey("btnConfirmEnable"));
      await tester.tap(confirmButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      //assert

      verify(() => mockUserBloc.add(OnUserEnable(tUser2.id, false))).called(1);
    });

    testWidgets('click en deshabilitar y luego cancelar debe cerrar el diálogo',
        (WidgetTester tester) async {
      // arrange
      when(() => mockUserBloc.state).thenReturn(UserLoaded(tUser2));

      // act
      await tester.pumpWidget(makeTestableWidget(UsersPage()));
      Finder disableButton = find.byKey(const ValueKey("btnEnableOption"));
      await tester.tap(disableButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      Finder cancelButton = find.byKey(const ValueKey("btnCancelEnable"));
      await tester.tap(cancelButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      Finder showedDialog = find.byType(AlertDialog);
      //assert
      expect(showedDialog, findsNothing);
    });
  });
}
