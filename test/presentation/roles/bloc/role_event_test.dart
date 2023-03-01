import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/presentation/roles/bloc/role_event.dart';

void main() {
  
  const tOnRoleLoad = OnRoleLoad('');
  const t_OnRoleLoad = OnRoleLoad('');
  const tOnRoleListLoad = OnRoleListLoad();
  const t_OnRoleListLoad = OnRoleListLoad();

  group('role event', () {
    test('On Role Load', () {
      //act
      final result = tOnRoleLoad.props;
      final result2 = t_OnRoleLoad.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Role List Load', () {
      //act
      final result = tOnRoleListLoad.props;
      final result2 = t_OnRoleListLoad.props;

      //assert
      expect(result, equals(result2));
    });
  });
}