import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/presentation/flow/bloc/flow_event.dart';

void main() {
  
  const tOnFlowLoad = OnFlowLoad('');
  const t_OnFlowLoad = OnFlowLoad('');
  const tOnFlowListLoad = OnFlowListLoad();
  const t_OnFlowListLoad = OnFlowListLoad();

  group('flow event', () {
    test('On Flow Load', () {
      //act
      final result = tOnFlowLoad.props;
      final result2 = t_OnFlowLoad.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Flow List Load', () {
      //act
      final result = tOnFlowListLoad.props;
      final result2 = t_OnFlowListLoad.props;

      //assert
      expect(result, equals(result2));
    });
  });
}