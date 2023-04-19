import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:lomba_frontend/core/fakedata.dart';
import 'package:lomba_frontend/core/widgets/scaffold_manager.dart';
import 'package:lomba_frontend/presentation/orgas/bloc/orga_bloc.dart';
import 'package:lomba_frontend/presentation/orgas/bloc/orga_event.dart';
import 'package:lomba_frontend/presentation/orgas/bloc/orga_state.dart';
import 'package:lomba_frontend/presentation/orgas/bloc/orgauser_bloc.dart';
import 'package:lomba_frontend/presentation/orgas/bloc/orgauser_event.dart';
import 'package:lomba_frontend/presentation/orgas/bloc/orgauser_state.dart';
import 'package:lomba_frontend/presentation/orgas/pages/orgas_page.dart';
import 'package:lomba_frontend/domain/entities/user.dart';
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

  Widget makeTestableWidgetWithScreen(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OrgaUserBloc>.value(
          value: mockOrgaUserBloc,
        ),
        BlocProvider<OrgaBloc>.value(
          value: mockOrgaBloc,
        ),
      ],
      child:
          MaterialApp(home: SizedBox(width: 2400, height: 1600, child: body)),
    );
  }

  final tOrga = fakeListOrgas[1].toEntity();
  final tUser2 = fakeListUsers[1].toEntity();
  final tOrga2 = fakeListOrgas[1].toEntity();
  final tOrga1 = fakeListOrgas[0].toEntity();

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

  group('lista de organizaciones al entrar a la página', () {
    testWidgets(
      'en el primer estado de la página debe al menos mostrar el título',
      (WidgetTester tester) async {
        // arrange
        when(() => mockOrgaBloc.state).thenReturn(const OrgaStart(""));

        // act
        await tester.pumpWidget(makeTestableWidget(OrgasPage()));
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
        when(() => mockOrgaBloc.state).thenReturn(OrgaLoaded(tOrga2, ""));
        when(() => mockOrgaUserBloc.state).thenReturn(const OrgaUserStart(""));

        // act
        await tester.pumpWidget(makeTestableWidget(OrgasPage()));
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
      when(() => mockOrgaBloc.state).thenReturn(OrgaLoaded(tOrga2, ""));
      when(() => mockOrgaUserBloc.state).thenReturn(const OrgaUserStart(""));

      // act
      await tester.pumpWidget(makeTestableWidget(OrgasPage()));
      Finder disableButton = find.byKey(const ValueKey("btnDeleteOption"));
      await tester.tap(disableButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      Finder confirmButton = find.byKey(const ValueKey("btnConfirmDelete"));
      await tester.tap(confirmButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      // Finder btnGd = find.byKey(const ValueKey("btnGd"));
      // await tester.tap(btnGd);
      // await tester.pumpAndSettle(const Duration(milliseconds: 600));
      //assert

      verify(() => mockOrgaBloc.add(OnOrgaDelete(tOrga2.id, tOrga2.name)))
          .called(1);
    });

    testWidgets('click en eliminar y luego cancelar debe cerrar el diálogo',
        (WidgetTester tester) async {
      // arrange
      when(() => mockOrgaBloc.state).thenReturn(OrgaLoaded(tOrga2, ""));
      when(() => mockOrgaUserBloc.state).thenReturn(OrgaUserStart(""));

      // act
      await tester.pumpWidget(makeTestableWidget(OrgasPage()));
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
      when(() => mockOrgaBloc.state).thenReturn(OrgaLoaded(tOrga2, ""));
      when(() => mockOrgaUserBloc.state).thenReturn(OrgaUserStart(""));

      // act
      await tester.pumpWidget(makeTestableWidget(OrgasPage()));
      Finder disableButton = find.byKey(const ValueKey("btnEnableOption"));
      await tester.tap(disableButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      Finder confirmButton = find.byKey(const ValueKey("btnConfirmEnable"));
      await tester.tap(confirmButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      //assert

      verify(() =>
              mockOrgaBloc.add(OnOrgaEnable(tOrga2.id, false, tOrga2.name)))
          .called(1);
    });

    testWidgets('click en deshabilitar y luego cancelar debe cerrar el diálogo',
        (WidgetTester tester) async {
      // arrange
      when(() => mockOrgaBloc.state).thenReturn(OrgaLoaded(tOrga2, ""));
      when(() => mockOrgaUserBloc.state).thenReturn(const OrgaUserStart(""));

      // act
      await tester.pumpWidget(makeTestableWidget(OrgasPage()));
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
      when(() => mockOrgaBloc.state).thenReturn(OrgaLoaded(tOrga2, ""));
      when(() => mockOrgaUserBloc.state).thenReturn(OrgaUserListLoaded(
          tOrga2.id,
          <User>[tUser2],
          tListOrgaUser,
          '',
          const <String, int>{"email": 1},
          1,
          10,
          1,
          1,
          1));
      await tester.pumpWidget(makeTestableWidget(OrgasPage()));
      Finder listItemFirstUser =
          find.text(tUser2.name); //por ahora sólo tenemos el ID
      expect(listItemFirstUser, findsOneWidget);

      Finder verUsuariosButton =
          find.byKey(const ValueKey('btnViewUsersOption'));
      await tester.tap(verUsuariosButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      expect(verUsuariosButton, equals(findsOneWidget));
    });
  });

  group('mostrar modificar organizacion', () {
    testWidgets('mostrar campo para modificar orga',
        (WidgetTester tester) async {
      when(() => mockOrgaBloc.state).thenReturn(OrgaEditing(tOrga, true));
      await tester.pumpWidget(makeTestableWidget(OrgasPage()));
      Finder widgetOrgaName = find.byKey(const ValueKey('orgaName'));
      Finder widgetCode = find.byKey(const ValueKey('code'));
      expect(widgetOrgaName, equals(findsOneWidget));
      expect(widgetCode, equals(findsOneWidget));
    });
    testWidgets(
      'boton cancelar y guardar',
      (WidgetTester tester) async {
        // arrange
        when(() => mockOrgaBloc.state).thenReturn(OrgaEditing(tOrga, true));
        // act
        await tester.pumpWidget(makeTestableWidget(OrgasPage()));
        Finder cancelButton = find.byKey(const ValueKey('cancelButton'));
        Finder saveButton = find.byKey(const ValueKey('saveButton'));
        //assert
        expect(cancelButton, findsOneWidget);
        expect(saveButton, findsOneWidget);
      },
    );
    testWidgets(
      'mostrar datos de orga',
      (WidgetTester tester) async {
        when(() => mockOrgaBloc.state).thenReturn(OrgaEditing(tOrga, true));
        await tester.pumpWidget(makeTestableWidget(OrgasPage()));
        Finder nombre = find.text(tOrga.name);
        Finder code = find.text(tOrga2.code);
        expect(nombre, equals(findsOneWidget));
        expect(code, equals(findsOneWidget));
      },
    );
  });
  group('mostrar campos y botones para agregar orga', () {
    testWidgets(
      'debe mostrar campo de nombre de organizacion y codigo',
      (WidgetTester tester) async {
        // arrange
        when(() => mockOrgaBloc.state).thenReturn(OrgaAdding(true, true));
        // act
        await tester.pumpWidget(makeTestableWidget(OrgasPage()));
        Finder orgaNameTextField = find.byKey(const ValueKey("orgaName1"));
        Finder codeTextField = find.byKey(const ValueKey("code"));

        expect(codeTextField, equals(findsOneWidget));
        expect(orgaNameTextField, equals(findsOneWidget));
      },
    );
    testWidgets(
      'debe mostrar botones para agregar orga',
      (WidgetTester tester) async {
        // arrange
        when(() => mockOrgaBloc.state).thenReturn(OrgaAdding(true, true));
        // act
        await tester.pumpWidget(makeTestableWidget(OrgasPage()));

        Finder cancelButton = find.byKey(const ValueKey("cancel1"));
        await tester.tap(cancelButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 600));
        Finder saveButton = find.byKey(const ValueKey("save1"));
        await tester.tap(saveButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 600));

        expect(saveButton, equals(findsOneWidget));
        expect(cancelButton, equals(findsOneWidget));
      },
    );
  });
  group('mostrar botones para asociar usuario, modificar orga y volver', () {
    testWidgets(
      'mostrar boton asociar usuario',
      (WidgetTester tester) async {
        when(() => mockOrgaBloc.state).thenReturn(OrgaLoaded(tOrga2, ""));
        when(() => mockOrgaUserBloc.state).thenReturn(OrgaUserStart(""));
        await tester.pumpWidget(makeTestableWidget(OrgasPage()));
        Finder asociarButton =
            find.byKey(const ValueKey('btnAddOrgaUserOption'));
        await tester.tap(asociarButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 600));
        expect(asociarButton, equals(findsOneWidget));
      },
    );
    testWidgets(
      'mostrar boton modificar orga',
      (WidgetTester tester) async {
        when(() => mockOrgaBloc.state).thenReturn(OrgaLoaded(tOrga2, ""));
        when(() => mockOrgaUserBloc.state).thenReturn(OrgaUserStart(""));
        await tester.pumpWidget(makeTestableWidget(OrgasPage()));
        Finder modifyButton = find.byKey(const ValueKey('btnModifyOrga'));
        await tester.tap(modifyButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 600));
        expect(modifyButton, equals(findsOneWidget));
      },
    );
    testWidgets(
      'mostrar boton volver',
      (WidgetTester tester) async {
        when(() => mockOrgaBloc.state).thenReturn(OrgaLoaded(tOrga2, ""));
        when(() => mockOrgaUserBloc.state).thenReturn(OrgaUserStart(""));
        await tester.pumpWidget(makeTestableWidget(OrgasPage()));
        Finder backButton = find.byKey(const ValueKey('btnVolver'));
        await tester.tap(backButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 600));
        expect(backButton, equals(findsOneWidget));
      },
    );
  });
  group('mostrar botones al editar orga', () {
    testWidgets(
      'mostrar boton volver',
      (WidgetTester tester) async {
        when(() => mockOrgaBloc.state).thenReturn(OrgaEditing(tOrga2, true));
        when(() => mockOrgaUserBloc.state).thenReturn(OrgaUserStart(""));
        await tester.pumpWidget(makeTestableWidget(OrgasPage()));
        Finder cancelButton = find.byKey(const ValueKey('cancelButton'));
        await tester.tap(cancelButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 600));
        expect(cancelButton, equals(findsOneWidget));
      },
    );
    testWidgets(
      'mostrar boton guardar',
      (WidgetTester tester) async {
        when(() => mockOrgaBloc.state).thenReturn(OrgaEditing(tOrga2, true));
        when(() => mockOrgaUserBloc.state).thenReturn(OrgaUserStart(""));
        await tester.pumpWidget(makeTestableWidget(OrgasPage()));
        Finder saveButton = find.byKey(const ValueKey('saveButton'));
        await tester.tap(saveButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 600));
        expect(saveButton, equals(findsOneWidget));
      },
    );
  });
  testWidgets(
    'mostrar icono back funcionando en appbar',
    (WidgetTester tester) async {
      when(() => mockOrgaBloc.state).thenReturn(OrgaLoaded(tOrga2, ""));
      when(() => mockOrgaUserBloc.state).thenReturn(OrgaUserStart(""));
      await tester.pumpWidget(makeTestableWidget(OrgasPage()));
      Finder iconBackButton = find.byKey(const ValueKey('btnOrganizacion'));
      await tester.tap(iconBackButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      expect(iconBackButton, equals(findsOneWidget));
    },
  );
  testWidgets(
    'mostrar agregar orga float button',
    (WidgetTester tester) async {
      when(() => mockOrgaBloc.state).thenReturn(OrgaListLoaded(tListOrgas));
      when(() => mockOrgaUserBloc.state).thenReturn(OrgaUserStart(""));
      await tester.pumpWidget(makeTestableWidget(OrgasPage()));
      Finder addButton = find.byKey(const ValueKey('btnAddOption'));
      await tester.tap(addButton);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      expect(addButton, equals(findsOneWidget));
    },
  );

  group('mostrar editar asociacion', () {
    testWidgets(
      'Mostrar boton de eliminar asociacion',
      (WidgetTester tester) async {
        //arrange
        when(() => mockOrgaUserBloc.state).thenReturn(OrgaUserListLoaded(
            tOrga2.id,
            fakeListUsers,
            fakeListOrgaUsers,
            '',
            const <String, int>{"email": 1},
            1,
            10,
            0,
            0,
            1));
        when(() => mockOrgaBloc.state).thenReturn(OrgaLoaded(tOrga2, ""));
        //act

        await tester.pumpWidget(makeTestableWidgetWithScreen(OrgasPage()));

        Finder userButton =
            find.byKey(ValueKey("btnTxtUser${fakeListUsers[0].id}"));

        //await tester.tap(userButton);
        await tester.tap(userButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 2000));
        
        Finder deleteButton = find.byKey(const ValueKey("btnEliminarAsociacion"));
        await tester.press(deleteButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 600));

        //assert
        expect(deleteButton, equals(findsOneWidget));
      },
    );
    testWidgets(
      'Mostrar boton de guardar',
      (WidgetTester tester) async {
        //arrange
        when(() => mockOrgaUserBloc.state).thenReturn(OrgaUserListLoaded(
            tOrga2.id,
            fakeListUsers,
            fakeListOrgaUsers,
            '',
            const <String, int>{"email": 1},
            1,
            10,
            1,
            1,
            1));
        when(() => mockOrgaBloc.state).thenReturn(OrgaLoaded(tOrga2, ""));
        //act
        await tester.pumpWidget(makeTestableWidget(OrgasPage()));

        Finder userButton =
            find.byKey(ValueKey("btnTxtUser${fakeListUsers[0].id}"));

        await tester.tap(userButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        Finder saveButton = find.byKey(const ValueKey('btnGuardarAsoc'));

        //await tester.tap(saveButton);
        //await tester.pumpAndSettle(const Duration(milliseconds: 600));

        expect(saveButton, equals(findsOneWidget));
      },
    );
    testWidgets(
      'Mostrar boton de cancelar',
      (WidgetTester tester) async {
        //arrange
        when(() => mockOrgaUserBloc.state).thenReturn(OrgaUserListLoaded(
            tOrga2.id,
            fakeListUsers,
            fakeListOrgaUsers,
            '',
            const <String, int>{"email": 1},
            1,
            10,
            1,
            1,
            1));
        when(() => mockOrgaBloc.state).thenReturn(OrgaLoaded(tOrga2, ""));
        //act

        await tester.pumpWidget(makeTestableWidget(OrgasPage()));

        Finder userButton =
            find.byKey(ValueKey("btnTxtUser${fakeListUsers[0].id}"));

        await tester.tap(userButton);
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        Finder cancelButton = find.byKey(const ValueKey('btnCancelarAsoc'));
        //await tester.tap(cancelButton);
        //await tester.pumpAndSettle(const Duration(milliseconds: 600));

        expect(cancelButton, equals(findsOneWidget));
      },
    );
  });

  group('description', () {
    testWidgets(
      'mostrar usuarios disponibles',
      (WidgetTester tester) async {
        when(() => mockOrgaUserBloc.state).thenReturn(
            OrgaUserListUserNotInOrgaLoaded(tOrga.id, fakeListUsers, '',
                const <String, int>{"email": 1}, 1, 10, 1, 1, 1));
        when(() => mockOrgaBloc.state).thenReturn(OrgaLoaded(tOrga, ""));
        await tester.pumpWidget(makeTestableWidget(OrgasPage()));
        Finder usuariosDispoText = find.text('Usuarios disponibles');
        expect(usuariosDispoText, equals(findsOneWidget));
      },
    );
    // testWidgets('Mostrar boton de eliminar asociacion',
    // (WidgetTester tester) async{
    // when(() => mockOrgaUserBloc.state).thenReturn(OrgaUserListUserNotInOrgaLoaded(tOrga.id, fakeListUsers));
    // when(() => mockOrgaBloc.state).thenReturn(OrgaLoaded(tOrga));
    // await tester.pumpWidget(makeTestableWidget(OrgasPage()));
    // Finder txtButton = find.byKey(const ValueKey('txtBtnAccount'));
    // await tester.tap(txtButton);
    // await tester.pumpAndSettle(const Duration(milliseconds: 600));
    // Finder showedDialog = find.byType(AlertDialog);
    // expect(showedDialog, findsNothing);

    // },
    // );
  });

  testWidgets(
    'Muestra la organización y la lista de usuarios',
    (WidgetTester tester) async {
      when(() => mockOrgaUserBloc.state).thenReturn(OrgaUserListLoaded(
          tOrga1.id,
          fakeListUsers,
          fakeListOrgaUsers,
          '',
          const <String, int>{"email": 1},
          1,
          10,
          1,
          0,
          1));
      when(() => mockOrgaBloc.state).thenReturn(OrgaLoaded(tOrga, ""));
      await tester.pumpWidget(makeTestableWidget(OrgasPage()));
      Finder textButton = find.text('Súper Administrador');
      expect(textButton, equals(findsOneWidget));
      // Finder verUsuariosButton = find.byKey(const ValueKey('btnTxtUser'));
      // await tester.tap(verUsuariosButton);
      // await tester.pumpAndSettle(const Duration(milliseconds: 600));
      // expect(verUsuariosButton, equals(findsOneWidget));
    },
  );
}
