import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/presentation/home/bloc/home_cubit.dart';

main() {
  late HomeLiveState testStateChangeValue = HomeLiveState();
  late HomeLiveState testStateMakeVote = HomeLiveState();
  setUp(() {
    testStateChangeValue.checks
        .addEntries(<String, bool>{"clave": true}.entries);
    testStateMakeVote.votes.addEntries(<String, int>{"postId": 1}.entries);
  });

  blocTest<HomeLiveCubit, HomeLiveState>(
    'HomeLiveCubit change check value',
    build: () => HomeLiveCubit(),
    act: (cubit) => cubit.changeCheckValue('clave', true),
    wait: const Duration(milliseconds: 500),
    expect: () => [testStateChangeValue],
  );

  blocTest<HomeLiveCubit, HomeLiveState>(
    'HomeLiveCubit make vote check value',
    build: () => HomeLiveCubit(),
    act: (cubit) => cubit.makeVote('postId', 1),
    wait: const Duration(milliseconds: 500),
    expect: () => [testStateMakeVote],
  );
}
