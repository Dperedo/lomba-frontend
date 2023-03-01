import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/presentation/login/bloc/login_event.dart';

void main() {
  
  const tOnLoginChangeOrga = OnLoginChangeOrga('', '');
  const t_OnLoginChangeOrga = OnLoginChangeOrga('', '');

  group('login event', () {
    test('On Login Change Orga', () {
      //act
      final result = tOnLoginChangeOrga.props;
      final result2 = t_OnLoginChangeOrga.props;

      //assert
      expect(result, equals(result2));
    });
  });
}