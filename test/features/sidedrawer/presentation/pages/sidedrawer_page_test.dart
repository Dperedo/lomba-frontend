import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:lomba_frontend/features/sidedrawer/presentation/bloc/sidedrawer_bloc.dart';
import 'package:lomba_frontend/features/sidedrawer/presentation/bloc/sidedrawer_event.dart';
import 'package:lomba_frontend/features/sidedrawer/presentation/bloc/sidedrawer_state.dart';
import 'package:lomba_frontend/features/sidedrawer/presentation/pages/sidedrawer_page.dart';
import 'package:mocktail/mocktail.dart';

class MockSideDrawerBloc extends MockBloc<SideDrawerEvent, SideDrawerState>
    implements SideDrawerBloc {}

class FakeSideDrawerState extends Fake implements SideDrawerState {}

class FakeSideDrawerEvent extends Fake implements SideDrawerEvent {}

void main() {
  late MockSideDrawerBloc mockSideDrawerBloc;

  setUpAll(() async {
    registerFallbackValue(FakeSideDrawerState());
    registerFallbackValue(FakeSideDrawerEvent());
    final di = GetIt.instance;
    di.registerFactory(() => mockSideDrawerBloc);
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SideDrawerBloc>.value(
      value: mockSideDrawerBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  setUp(() {
    mockSideDrawerBloc = MockSideDrawerBloc();
  });

  const listAnonymous = <String>["home", "login"];
  const listUser = <String>["home", "logoff", "profile"];
  const listAdmin = <String>["home", "logoff", "profile", "users"];
  const listSuperAdmin = <String>[
    "home",
    "logoff",
    "profile",
    "orgas",
    "users",
    "roles"
  ];

  group('desplegando opciones del menú lateral según el rol', () {
    testWidgets('cargando y mostrar progreso menú en el sidedrawer',
        (WidgetTester tester) async {
      //arrange
      when(() => mockSideDrawerBloc.state).thenReturn(SideDrawerEmpty());

      //act
      await tester.pumpWidget(makeTestableWidget(const SideDrawer()));
      final snipper = find.byType(CircularProgressIndicator);

      //assert
      expect(snipper, findsOneWidget);
    });

    testWidgets('mostrar opciones de anónimo en el menú sidedrawer',
        (WidgetTester tester) async {
      //arrange
      when(() => mockSideDrawerBloc.state)
          .thenReturn(const SideDrawerReady(listAnonymous,[],''));

      //act
      await tester.pumpWidget(makeTestableWidget(const SideDrawer()));

      //assert
      expect(find.text("Home"), findsOneWidget);
      expect(find.text("Iniciar sesión"), findsOneWidget);
    });

    testWidgets('mostrar opciones de rol usuario en el menú sidedrawer',
        (WidgetTester tester) async {
      //arrange
      when(() => mockSideDrawerBloc.state)
          .thenReturn(const SideDrawerReady(listUser,[],''));

      //act
      await tester.pumpWidget(makeTestableWidget(const SideDrawer()));

      //assert
      expect(find.text("Home"), findsOneWidget);
      expect(find.text("Perfil"), findsOneWidget);
      expect(find.text("Cerrar sesión"), findsOneWidget);
    });

    testWidgets('mostrar opciones de rol admin en el menú sidedrawer',
        (WidgetTester tester) async {
      //arrange
      when(() => mockSideDrawerBloc.state)
          .thenReturn(const SideDrawerReady(listAdmin,[],''));

      //act
      await tester.pumpWidget(makeTestableWidget(const SideDrawer()));

      //assert
      expect(find.text("Home"), findsOneWidget);
      expect(find.text("Perfil"), findsOneWidget);
      expect(find.text("Cerrar sesión"), findsOneWidget);
      expect(find.text("Usuarios"), findsOneWidget);
    });

    testWidgets('mostrar opciones de rol super admin en el menú sidedrawer',
        (WidgetTester tester) async {
      //arrange
      when(() => mockSideDrawerBloc.state)
          .thenReturn(const SideDrawerReady(listSuperAdmin,[],''));

      //act
      await tester.pumpWidget(makeTestableWidget(const SideDrawer()));

      //assert
      expect(find.text("Home"), findsOneWidget);
      expect(find.text("Perfil"), findsOneWidget);
      expect(find.text("Cerrar sesión"), findsOneWidget);
      expect(find.text("Organizaciones"), findsOneWidget);
      expect(find.text("Roles"), findsOneWidget);
      expect(find.text("Usuarios"), findsOneWidget);
    });
  });
}
