import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/presentation/login/bloc/login_event.dart';

void main() {
  
  const tOnLoginChangeOrga = OnLoginChangeOrga('', '');
  const t_OnLoginChangeOrga = OnLoginChangeOrga('', '');
  final tOnLoginWithGoogle = OnLoginWithGoogle();
  final t_OnLoginWithGoogle = OnLoginWithGoogle();
  final tOnRestartLogin = OnRestartLogin();
  final t_OnRestartLogin = OnRestartLogin();

  group('login event', () {
    test('On Login Change Orga', () {
      //act
      final result = tOnLoginChangeOrga.props;
      final result2 = t_OnLoginChangeOrga.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Login With Google', () {
      //act
      final result = tOnLoginWithGoogle.props;
      final result2 = t_OnLoginWithGoogle.props;

      //assert
      expect(result, equals(result2));
    });

    test('OnRestartLogin', () {
      //act
      final result = tOnRestartLogin.props;
      final result2 = t_OnRestartLogin.props;

      //assert
      expect(result, equals(result2));
    });
  });
}