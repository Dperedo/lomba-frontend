import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/presentation/recent/bloc/recent_cubit.dart';

main() {
  late RecentLiveState testStateChangeValue =
      const RecentLiveState(<String, bool>{"clave": true}, <String, int>{});
  late RecentLiveState testStateMakeVote =
      const RecentLiveState(<String, bool>{}, <String, int>{"postId": 1});
  setUp(() {});

  blocTest<RecentLiveCubit, RecentLiveState>(
    'RecentLiveCubit change check value',
    build: () => RecentLiveCubit(),
    act: (cubit) => cubit.changeCheckValue('clave', true),
    wait: const Duration(milliseconds: 500),
    expect: () => [testStateChangeValue],
  );

  blocTest<RecentLiveCubit, RecentLiveState>(
    'RecentLiveCubit make vote check value',
    build: () => RecentLiveCubit(),
    act: (cubit) => cubit.makeVote('postId', 1),
    wait: const Duration(milliseconds: 500),
    expect: () => [testStateMakeVote],
  );
}
