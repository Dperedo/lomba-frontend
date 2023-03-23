import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/presentation/recent/bloc/recent_event.dart';

void main() {
  const tOnRecentLoaded = OnRecentLoaded();
  const t_OnRecentLoaded = OnRecentLoaded();
  const tOnRecentVote = OnRecentVote('', 1);
  const t_OnRecentVote = OnRecentVote('', 1);
  const tOnRecentLoading =
      OnRecentLoading('', <String, int>{'created': 1}, 1, 10);
  const t_OnRecentLoading =
      OnRecentLoading('', <String, int>{'created': 1}, 1, 10);
  const tOnRecentStarter = OnRecentStarter('');
  const t_OnRecentStarter = OnRecentStarter('');

  group('recent event', () {
    test('On Recent Loaded', () {
      //act
      final result = tOnRecentLoaded.props;
      final result2 = t_OnRecentLoaded.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Recent Vote', () {
      //act
      final result = tOnRecentVote.props;
      final result2 = t_OnRecentVote.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Recent Loading', () {
      //act
      final result = tOnRecentLoading.props;
      final result2 = t_OnRecentLoading.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Restart Recent', () {
      //act
      final result = tOnRecentStarter.props;
      final result2 = t_OnRecentStarter.props;

      //assert
      expect(result, equals(result2));
    });
  });
}
