import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:lomba_frontend/core/widgets/scaffold_manager.dart';
import 'package:lomba_frontend/presentation/sidedrawer/bloc/sidedrawer_bloc.dart';
import 'package:lomba_frontend/presentation/sidedrawer/bloc/sidedrawer_event.dart';
import 'package:lomba_frontend/presentation/sidedrawer/bloc/sidedrawer_state.dart';
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

  const listUser = <String>["recent", "logoff", "profile"];
  /*testWidgets('entrega mensaje bienvenido usuario logueado',
      (WidgetTester tester) async {
    //arrange
    when(() => mockSideDrawerBloc.state)
        .thenReturn(const SideDrawerReady(listUser, [], ''));

    const w = Text("Aprobados");
    //act
    await tester.pumpWidget(ScaffoldManager(
        title: AppBar(title: const Text("Aprobados")), child: w));
    final message = find.text("Aprobados");

    //assert
    expect(message, findsOneWidget);
  });*/
}
