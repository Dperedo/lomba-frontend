import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:lomba_frontend/core/fakedata.dart';
import 'package:lomba_frontend/features/orgas/presentation/bloc/orga_bloc.dart';
import 'package:lomba_frontend/features/orgas/presentation/bloc/orga_event.dart';
import 'package:lomba_frontend/features/orgas/presentation/bloc/orga_state.dart';
import 'package:lomba_frontend/features/orgas/presentation/bloc/orgauser_bloc.dart';
import 'package:lomba_frontend/features/orgas/presentation/bloc/orgauser_event.dart';
import 'package:lomba_frontend/features/orgas/presentation/bloc/orgauser_state.dart';
import 'package:lomba_frontend/features/orgas/presentation/pages/orgas_page.dart';
import 'package:lomba_frontend/features/users/domain/entities/user.dart';
import 'package:mocktail/mocktail.dart';

class MockOrgaBloc extends MockBloc<OrgaEvent, OrgaState> implements OrgaBloc {}

class MockOrgaUserBloc extends MockBloc<OrgaUserEvent, OrgaUserState>
    implements OrgaUserBloc {}

class FakeOrgaState extends Fake implements OrgaState {}

class FakeOrgaEvent extends Fake implements OrgaEvent {}

class FakeOrgaUserState extends Fake implements OrgaUserState {}

class FakeOrgaUserEvent extends Fake implements OrgaUserEvent {}

void main() {
  late MockOrgaBloc mockOrgaBloc;
  late MockOrgaUserBloc mockOrgaUserBloc;

  setUpAll(() async {
    HttpOverrides.global = null;
    registerFallbackValue(FakeOrgaState());
    registerFallbackValue(FakeOrgaEvent());

    registerFallbackValue(FakeOrgaUserState());
    registerFallbackValue(FakeOrgaUserEvent());

    mockOrgaBloc = MockOrgaBloc();
    mockOrgaUserBloc = MockOrgaUserBloc();

    final di = GetIt.instance;

    di.registerFactory(() => mockOrgaBloc);
    di.registerFactory(() => mockOrgaUserBloc);
  });

  setUp(() {});

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OrgaUserBloc>.value(
          value: mockOrgaUserBloc,
        ),
        BlocProvider<OrgaBloc>.value(
          value: mockOrgaBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

/*
  Widget makeTestableWidget(Widget body) {
    return BlocProvider<OrgaBloc>.value(
      value: mockOrgaBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }
*/
  final tUser2 = fakeListUsers[1].toEntity();
  final tOrga2 = fakeListOrgas[1].toEntity();
  final tListOrgaUser = fakeListOrgaUsers
      .where(
        (element) => element.orgaId == tOrga2.id,
      )
      .toList();

  group('lista de organizaciones al entrar a la página', () {
    testWidgets(
      'en el primer estado de la página debe al menos mostrar el título',
      (WidgetTester tester) async {
        // arrange
        when(() => mockOrgaBloc.state).thenReturn(OrgaStart());

        // act
        await tester.pumpWidget(makeTestableWidget( OrgasPage()));
        Finder titulo = find.text("Organizaciones");
        //await tester.pumpAndSettle(const Duration(seconds: 1));

        // assert
        verify(() => mockOrgaBloc.add(const OnOrgaListLoad("", "", 1)))
            .called(1);

        expect(titulo, equals(findsOneWidget));
      },
    );

    testWidgets(
      'al darle tap a una organización mostrar su información',
      (WidgetTester tester) async {
        // arrange
        when(() => mockOrgaBloc.state).thenReturn(OrgaLoaded(tOrga2));
        when(() => mockOrgaUserBloc.state).thenReturn(OrgaUserStart());

        // act
        await tester.pumpWidget(makeTestableWidget( OrgasPage()));
        Finder titulo = find.text(tOrga2.name);

        //assert
        expect(titulo, equals(findsOneWidget));
      },
    );
  });

  group('eliminar y deshabilitar Orga', () {
    testWidgets(
        'click en eliminar y luego confirmar eliminar gatilla evento de eliminación',
        (WidgetTester tester) async {
      // arrange
      when(() => mockOrgaBloc.state).thenReturn(OrgaLoaded(tOrga2));
      when(() => mockOrgaUserBloc.state).thenReturn(OrgaUserStart());

      // act
      await tester.pumpWidget(makeTestableWidget( OrgasPage()));
      Finder disableButton = find.byKey(const ValueKey("btnDeleteOption"));
      await tester.tap(disableButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      Finder confirmButton = find.byKey(const ValueKey("btnConfirmDelete"));
      await tester.tap(confirmButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      //assert

      verify(() => mockOrgaBloc.add(OnOrgaDelete(tOrga2.id))).called(1);
    });

    testWidgets('click en eliminar y luego cancelar debe cerrar el diálogo',
        (WidgetTester tester) async {
      // arrange
      when(() => mockOrgaBloc.state).thenReturn(OrgaLoaded(tOrga2));
      when(() => mockOrgaUserBloc.state).thenReturn(OrgaUserStart());

      // act
      await tester.pumpWidget(makeTestableWidget( OrgasPage()));
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
      when(() => mockOrgaBloc.state).thenReturn(OrgaLoaded(tOrga2));
      when(() => mockOrgaUserBloc.state).thenReturn(OrgaUserStart());

      // act
      await tester.pumpWidget(makeTestableWidget( OrgasPage()));
      Finder disableButton = find.byKey(const ValueKey("btnEnableOption"));
      await tester.tap(disableButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      Finder confirmButton = find.byKey(const ValueKey("btnConfirmEnable"));
      await tester.tap(confirmButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      //assert

      verify(() => mockOrgaBloc.add(OnOrgaEnable(tOrga2.id, false))).called(1);
    });

    testWidgets('click en deshabilitar y luego cancelar debe cerrar el diálogo',
        (WidgetTester tester) async {
      // arrange
      when(() => mockOrgaBloc.state).thenReturn(OrgaLoaded(tOrga2));
      when(() => mockOrgaUserBloc.state).thenReturn(OrgaUserStart());

      // act
      await tester.pumpWidget(makeTestableWidget( OrgasPage()));
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

  group('lista de usuarios de organización', () {
    testWidgets('mostrar lista de usuarios al clic del botón',
        (WidgetTester tester) async {
      when(() => mockOrgaBloc.state).thenReturn(OrgaLoaded(tOrga2));
      when(() => mockOrgaUserBloc.state).thenReturn(
          OrgaUserListLoaded(tOrga2.id, <User>[tUser2], tListOrgaUser));

      // act
      await tester.pumpWidget(makeTestableWidget( OrgasPage()));

      Finder listItemFirstUser =
          find.text(tUser2.name); //por ahora sólo tenemos el ID

      //assert
      expect(listItemFirstUser, findsOneWidget);
    });
  });
  final tOrga = fakeListOrgas[1].toEntity();
  group('mostrar modificar organizacion',(){
    testWidgets('mostrar campo para modificar orga',
      (WidgetTester tester)async{
        when(() => mockOrgaBloc.state).thenReturn(OrgaEditing(tOrga, true));
        await tester.pumpWidget(makeTestableWidget(OrgasPage()));
        Finder widgetOrgaName = find.byKey(const ValueKey('orgaName'));
        Finder widgetCode = find.byKey(const ValueKey('code'));
        expect(widgetOrgaName, equals(findsOneWidget));
        expect(widgetCode, equals(findsOneWidget));
      }
    );
    testWidgets('boton cancelar y guardar',
      (WidgetTester tester) async {
        // arrange
        when(() => mockOrgaBloc.state).thenReturn(OrgaEditing(tOrga, true));
        // act
        await tester.pumpWidget(makeTestableWidget( OrgasPage()));
        Finder cancelButton = find.byKey(const ValueKey('cancelButton'));
        Finder saveButton = find.byKey(const ValueKey('saveButton'));
         //assert
        expect(cancelButton,findsOneWidget);
        expect(saveButton, findsOneWidget);
      },
    );
    testWidgets('mostrar datos de orga', 
      (WidgetTester tester)async{
        when(() => mockOrgaBloc.state).thenReturn(OrgaEditing(tOrga, true));
        await tester.pumpWidget(makeTestableWidget(OrgasPage()));
        Finder nombre = find.text(tOrga.name);
        Finder code = find.text(tOrga2.code);
        expect(nombre, equals(findsOneWidget));
        expect(code, equals(findsOneWidget));
      },
    );
  });
}
