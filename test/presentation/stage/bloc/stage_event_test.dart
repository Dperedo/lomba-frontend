import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/presentation/stage/bloc/stage_event.dart';

void main() {
  
  const tOnStageLoad = OnStageLoad('');
  const t_OnStageLoad = OnStageLoad('');
  const tOnStageListLoad = OnStageListLoad();
  const t_OnStageListLoad = OnStageListLoad();

  group('stage event', () {
    test('On Stage Load', () {
      //act
      final result = tOnStageLoad.props;
      final result2 = t_OnStageLoad.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Stage List Load', () {
      //act
      final result = tOnStageListLoad.props;
      final result2 = t_OnStageListLoad.props;

      //assert
      expect(result, equals(result2));
    });
  });
}