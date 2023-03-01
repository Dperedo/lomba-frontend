import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/presentation/home/bloc/home_event.dart';

void main() {

  const tOnHomeLoaded = OnHomeLoaded();
  const t_OnHomeLoaded = OnHomeLoaded();
  const tOnHomeVote = OnHomeVote('',1);
  const t_OnHomeVote = OnHomeVote('',1);
  const tOnHomeLoading = OnHomeLoading('',<String, int>{'created': 1},1,10);
  const t_OnHomeLoading = OnHomeLoading('',<String, int>{'created': 1},1,10);

  group('home event', () {
    test('On Home Loaded', () {
      //act
      final result = tOnHomeLoaded.props;
      final result2 = t_OnHomeLoaded.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Home Vote', () {
      //act
      final result = tOnHomeVote.props;
      final result2 = t_OnHomeVote.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Home Loading', () {
      //act
      final result = tOnHomeLoading.props;
      final result2 = t_OnHomeLoading.props;

      //assert
      expect(result, equals(result2));
    });
  });
}