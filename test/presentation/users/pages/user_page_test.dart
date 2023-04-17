import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:lomba_frontend/core/fakedata.dart';
import 'package:lomba_frontend/presentation/users/bloc/user_bloc.dart';
import 'package:lomba_frontend/presentation/users/bloc/user_event.dart';
import 'package:lomba_frontend/presentation/users/bloc/user_state.dart';
import 'package:lomba_frontend/presentation/users/pages/users_page.dart';
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

  final tOrga2 = fakeListOrgas[1].toEntity();
  final tListOrgaUser = fakeListOrgaUsers
      .where(
        (element) => element.orgaId == tOrga2.id,
      )
      .toList();
  final tListOrgas = fakeListOrgas
      .where(
        (element) => element.id == tOrga2.id,
      )
      .toList();
  final tOrgaUser = fakeListOrgaUsers[1].toEntity();

  group('lista de usernizaciones al entrar a la página', () {
    testWidgets(
      'en el primer estado de la página debe al menos mostrar el título',
      (WidgetTester tester) async {
        // arrange
        when(() => mockUserBloc.state).thenReturn(const UserStart(""));

        // act
        await tester.pumpWidget(makeTestableWidget(UsersPage()));
        Finder titulo = find.text("Usuarios");
        //await tester.pumpAndSettle(const Duration(seconds: 1));

        // assert
        verify(() => mockUserBloc.add(
                const OnUserListLoad("", "", <String, int>{"email": 1}, 1, 10)))
            .called(1);

        expect(titulo, equals(findsOneWidget));
      },
    );

    testWidgets(
      'al darle tap a un usuario mostrar su información',
      (WidgetTester tester) async {
        // arrange
        when(() => mockUserBloc.state)
            .thenReturn(UserLoaded(tUser2, tOrgaUser, ""));

        // act
        await tester.pumpWidget(makeTestableWidget(UsersPage()));
        Finder titulo = find.text(tUser2.name);

        //assert
        expect(titulo, equals(findsOneWidget));
      },
    );
    testWidgets(
      'Mostrar boton de agregar',
      (WidgetTester tester) async {
        when(() => mockUserBloc.state)
            .thenReturn(UserLoaded(tUser2, tOrgaUser, ""));
        when(() => mockUserBloc.state).thenReturn(const UserStart(""));
        await tester.pumpWidget(makeTestableWidget(UsersPage()));
        Finder addButton = find.byKey(const ValueKey('btnAddOption'));
        await tester.tap(addButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 600));

        expect(addButton, equals(findsOneWidget));
      },
    );
  });

  group('eliminar y deshabilitar User', () {
    testWidgets(
      'Mostrar boton de editar',
      (WidgetTester tester) async {
        when(() => mockUserBloc.state)
            .thenReturn(UserLoaded(tUser2, tOrgaUser, ""));
        await tester.pumpWidget(makeTestableWidget(UsersPage()));
        Finder editButton = find.byKey(const ValueKey('btnEditOption'));
        await tester.tap(editButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 600));

        expect(editButton, equals(findsOneWidget));
      },
    );
    testWidgets(
        'click en eliminar y luego confirmar eliminar gatilla evento de eliminación',
        (WidgetTester tester) async {
      // arrange
      when(() => mockUserBloc.state)
          .thenReturn(UserLoaded(tUser2, tOrgaUser, ""));

      // act
      await tester.pumpWidget(makeTestableWidget(UsersPage()));
      Finder disableButton = find.byKey(const ValueKey("btnDeleteOption"));
      await tester.tap(disableButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      Finder confirmButton = find.byKey(const ValueKey("btnConfirmDelete"));
      await tester.tap(confirmButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      //assert

      verify(() => mockUserBloc.add(OnUserDelete(tUser2.id, tUser2.name)))
          .called(1);
    });

    testWidgets('click en eliminar y luego cancelar debe cerrar el diálogo',
        (WidgetTester tester) async {
      // arrange
      when(() => mockUserBloc.state)
          .thenReturn(UserLoaded(tUser2, tListOrgaUser[0], ""));

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
      when(() => mockUserBloc.state)
          .thenReturn(UserLoaded(tUser2, tOrgaUser, ""));

      // act
      await tester.pumpWidget(makeTestableWidget(UsersPage()));
      Finder disableButton = find.byKey(const ValueKey("btnEnableOption"));
      await tester.tap(disableButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      Finder confirmButton = find.byKey(const ValueKey("btnConfirmEnable"));
      await tester.tap(confirmButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      //assert

      verify(() =>
              mockUserBloc.add(OnUserEnable(tUser2.id, false, tUser2.name)))
          .called(1);
    });

    testWidgets('click en deshabilitar y luego cancelar debe cerrar el diálogo',
        (WidgetTester tester) async {
      // arrange
      when(() => mockUserBloc.state)
          .thenReturn(UserLoaded(tUser2, tOrgaUser, ""));

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
  group('Mostrar formulario para password y botones de cancelar y guardar', () {
    testWidgets(
      'mostrar fomulario para cambiar password',
      (WidgetTester tester) async {
        // arrange
        when(() => mockUserBloc.state).thenReturn(UserUpdatePassword(tUser2));
        await tester.pumpWidget(makeTestableWidget(UsersPage()));
        Finder widgetPass = find.byKey(const ValueKey('password'));
        Finder widgetRepeatPass = find.byKey(const ValueKey('repeatPassword'));
        expect(widgetRepeatPass, equals(findsOneWidget));
        expect(widgetPass, equals(findsOneWidget));
      },
    );
    testWidgets(
      'Mostrar boton de cancelar',
      (WidgetTester tester) async {
        when(() => mockUserBloc.state).thenReturn(UserUpdatePassword(tUser2));
        await tester.pumpWidget(makeTestableWidget(UsersPage()));
        Finder cancelButton =
            find.byKey(const ValueKey('btnViewCancelarCambios'));
        await tester.tap(cancelButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 600));

        expect(cancelButton, equals(findsOneWidget));
      },
    );
    // testWidgets('Mostrar boton de guardar cambios',
    // (WidgetTester tester) async{
    // when(() => mockUserBloc.state).thenReturn(UserUpdatePassword(tUser2));
    // await tester.pumpWidget(makeTestableWidget(UsersPage()));
    // Finder saveButton = find.byKey(const ValueKey('btnViewSaveNewPassword'));
    // await tester.tap(saveButton);
    // await tester.pumpAndSettle(const Duration(milliseconds: 600));
    // Finder passwordModifiedText = find.text('Contraseña modificada');
    // expect(passwordModifiedText, equals(findsOneWidget));
    // expect(saveButton, equals(findsOneWidget));

    // },
    // );
    // testWidgets('Mostrar boton de guardar cambios',
    // (WidgetTester tester) async{
    // when(() => mockUserBloc.state).thenReturn(UserUpdatePassword(tUser2));
    // when(() => mockUserBloc.state).thenReturn(UserLoaded(tUser2));
    // await tester.pumpWidget(makeTestableWidget(UsersPage()));
    // Finder passwordModifiedText = find.text('Contraseña modificada');
    // expect(passwordModifiedText, equals(findsOneWidget));

    // },
    // );
  });

  testWidgets(
    'Mostrar boton de cambiar password',
    (WidgetTester tester) async {
      when(() => mockUserBloc.state)
          .thenReturn(UserLoaded(tUser2, tOrgaUser, ""));
      await tester.pumpWidget(makeTestableWidget(UsersPage()));
      Finder editButton =
          find.byKey(const ValueKey('btnViewModifyPasswordFormOption'));
      await tester.tap(editButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));

      expect(editButton, equals(findsOneWidget));
    },
  );
  testWidgets(
    'Mostrar boton de volver',
    (WidgetTester tester) async {
      when(() => mockUserBloc.state)
          .thenReturn(UserLoaded(tUser2, tOrgaUser, ""));
      await tester.pumpWidget(makeTestableWidget(UsersPage()));
      Finder backButton = find.byKey(const ValueKey('btnVolver'));
      await tester.tap(backButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));

      expect(backButton, equals(findsOneWidget));
    },
  );
  group('mostrar agregar usuario', () {
    testWidgets(
      'mostrar campo para nombre',
      (WidgetTester tester) async {
        // arrange
        when(() => mockUserBloc.state).thenReturn(UserAdding(true, true));
        await tester.pumpWidget(makeTestableWidget(UsersPage()));
        Finder nombreText = find.byKey(const ValueKey('txtNombre'));
        expect(nombreText, equals(findsOneWidget));
      },
    );
  });
  testWidgets(
    'mostrar campo para nombre',
    (WidgetTester tester) async {
      // arrange
      when(() => mockUserBloc.state)
          .thenReturn(UserEditing(true, true, tUser2));
      await tester.pumpWidget(makeTestableWidget(UsersPage()));
      Finder nombreText = find.text('Nombre');
      expect(nombreText, equals(findsOneWidget));
    },
  );
  testWidgets(
    'mostrar campo para nombre',
    (WidgetTester tester) async {
      // arrange
      when(() => mockUserBloc.state)
          .thenReturn(UserEditing(true, true, tUser2));
      await tester.pumpWidget(makeTestableWidget(UsersPage()));
      Finder nombreText = find.text('Nombre');
      expect(nombreText, equals(findsOneWidget));
    },
  );
}
