import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:lomba_frontend/core/fakedata.dart';
import 'package:lomba_frontend/presentation/roles/bloc/role_bloc.dart';
import 'package:lomba_frontend/presentation/roles/bloc/role_event.dart';
import 'package:lomba_frontend/presentation/roles/bloc/role_state.dart';
import 'package:lomba_frontend/presentation/roles/pages/role_page.dart';
import 'package:mocktail/mocktail.dart';

class MockRoleBloc extends MockBloc<RoleEvent, RoleState> implements RoleBloc {}

class FakeRoleState extends Fake implements RoleState {}

class FakeRoleEvent extends Fake implements RoleEvent {}

void main() {
  late MockRoleBloc mockRoleBloc;

  setUpAll(() async {
    HttpOverrides.global = null;
    registerFallbackValue(FakeRoleState());
    registerFallbackValue(FakeRoleEvent());

    mockRoleBloc = MockRoleBloc();

    final di = GetIt.instance;

    di.registerFactory(() => mockRoleBloc);
  });

  setUp(() {});

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RoleBloc>.value(
          value: mockRoleBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tRole2 = fakeRoles[1].toEntity();

  group('lista de rolenizaciones al entrar a la página', () {
    testWidgets(
      'en el primer estado de la página debe al menos mostrar el título',
      (WidgetTester tester) async {
        // arrange
        when(() => mockRoleBloc.state).thenReturn(RoleStart());

        // act
        await tester.pumpWidget(makeTestableWidget(const RolesPage()));
        Finder titulo = find.text("Roles");
        //await tester.pumpAndSettle(const Duration(seconds: 1));

        // assert
        verify(() => mockRoleBloc.add(const OnRoleListLoad())).called(1);

        expect(titulo, equals(findsOneWidget));
      },
    );

    testWidgets(
      'al darle tap a un rol mostrar su información',
      (WidgetTester tester) async {
        // arrange
        when(() => mockRoleBloc.state).thenReturn(RoleLoaded(tRole2));

        // act
        await tester.pumpWidget(makeTestableWidget(const RolesPage()));
        Finder titulo = find.text(tRole2.name);

        //assert
        expect(titulo, equals(findsOneWidget));
      },
    );
  });

  group('deshabilitar Role', () {
    testWidgets(
        'click en deshabilitar debe mostrar dialogo de confirmación al rol',
        (WidgetTester tester) async {
      // arrange
      when(() => mockRoleBloc.state).thenReturn(RoleLoaded(tRole2));

      // act
      await tester.pumpWidget(makeTestableWidget(const RolesPage()));
      Finder disableButton = find.byKey(const ValueKey("btnEnableOption"));
      await tester.tap(disableButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      Finder confirmButton = find.byKey(const ValueKey("btnConfirmEnable"));
      await tester.tap(confirmButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      //assert

      verify(() => mockRoleBloc.add(OnRoleEnable(tRole2.name, false)))
          .called(1);
    });

    testWidgets('click en deshabilitar y luego cancelar debe cerrar el diálogo',
        (WidgetTester tester) async {
      // arrange
      when(() => mockRoleBloc.state).thenReturn(RoleLoaded(tRole2));

      // act
      await tester.pumpWidget(makeTestableWidget(const RolesPage()));
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
