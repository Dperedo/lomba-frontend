import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:lomba_frontend/presentation/profile/bloc/profile_bloc.dart';
import 'package:lomba_frontend/presentation/profile/bloc/profile_event.dart';
import 'package:lomba_frontend/presentation/profile/bloc/profile_state.dart';
import 'package:lomba_frontend/presentation/profile/pages/profile_page.dart';
import 'package:lomba_frontend/domain/entities/user.dart';
import 'package:mocktail/mocktail.dart';

class MockProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProfileBloc {}

class FakeProfileState extends Fake implements ProfileState {}

class FakeProfileEvent extends Fake implements ProfileEvent {}

void main() {
  late MockProfileBloc mockProfileBloc;
  final newUserId = Guid.newGuid.toString();
  final tUser = User(
      id: newUserId,
      name: 'Test User',
      username: 'test',
      email: 'te@mp.com',
      enabled: true,
      builtIn: false);

  setUpAll(() async {
    registerFallbackValue(FakeProfileState());
    registerFallbackValue(FakeProfileEvent());
    final di = GetIt.instance;
    di.registerFactory(() => mockProfileBloc);
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<ProfileBloc>.value(
      value: mockProfileBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  setUp(() {
    mockProfileBloc = MockProfileBloc();
    //mockHomeBloc = MockHomeBloc();
  });

  testWidgets('Mostrar barra mientras carga la pagina',
      (WidgetTester tester) async {
    when(() => mockProfileBloc.state).thenReturn(ProfileLoading());
    await tester.pumpWidget(makeTestableWidget(const ProfilePage()));
    final widget = find.byType(CircularProgressIndicator);

    expect(widget, findsOneWidget);
  });

  testWidgets('Mostrar ', (WidgetTester tester) async {
    when(() => mockProfileBloc.state).thenReturn(ProfileLoaded(tUser));
    await tester.pumpWidget(makeTestableWidget(const ProfilePage()));
    final widget = find.text(tUser.email);

    expect(widget, findsOneWidget);
  });

  // testWidgets('entrega mensaje bienvenido usuario logueado',
  //     (WidgetTester tester) async {
  //   //arrange
  //   when(() => mockProfileBloc.state).thenReturn(const ProfileLoaded(true));

  //   //act
  //   await tester.pumpWidget(makeTestableWidget(const ProfilePage()));
  //   final message = find.text("Bienvenido usuario logueado!");

  //   //assert
  //   expect(message, findsOneWidget);
  // });

  // testWidgets('entrega mensaje de usuario anónimo sin loguear',
  //     (WidgetTester tester) async {
  //   //arrange
  //   when(() => mockProfileBloc.state).thenReturn(const ProfileLoaded(false));

  //   //act
  //   await tester.pumpWidget(makeTestableWidget(const ProfilePage()));
  //   final message = find.text("Usuario anónimo. Bienvenido.");

  //   //assert
  //   expect(message, findsOneWidget);
  // });
}
