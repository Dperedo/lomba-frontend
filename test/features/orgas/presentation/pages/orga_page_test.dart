import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:lomba_frontend/features/orgas/presentation/bloc/orga_bloc.dart';
import 'package:lomba_frontend/features/orgas/presentation/bloc/orga_event.dart';
import 'package:lomba_frontend/features/orgas/presentation/bloc/orga_state.dart';
import 'package:lomba_frontend/features/orgas/presentation/pages/orgas_page.dart';
import 'package:mocktail/mocktail.dart';

class MockOrgaBloc extends MockBloc<OrgaEvent, OrgaState> implements OrgaBloc {}

class FakeOrgaState extends Fake implements OrgaState {}

class FakeOrgaEvent extends Fake implements OrgaEvent {}

void main() {
  late MockOrgaBloc mockOrgaBloc;

  setUpAll(() async {
    HttpOverrides.global = null;
    registerFallbackValue(FakeOrgaState());
    registerFallbackValue(FakeOrgaEvent());
    final di = GetIt.instance;
    mockOrgaBloc = MockOrgaBloc();
    di.registerFactory(() => mockOrgaBloc);
  });

  setUp(() {});

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<OrgaBloc>.value(
      value: mockOrgaBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('lista de organizaciones al entrar a la página', () {
    testWidgets(
      'en el primer estado de la página debe al menos mostrar el título',
      (WidgetTester tester) async {
        // arrange
        when(() => mockOrgaBloc.state).thenReturn(OrgaStart());

        // act
        await tester.pumpWidget(_makeTestableWidget(const OrgasPage()));
        Finder titulo = find.text("Organizaciones");

        // assert
        //verify(() => mockOrgaBloc.add(const OnOrgaListLoad("", "", 1)))
        //    .called(1);

        expect(titulo, equals(findsOneWidget));
      },
    );
  });
}
