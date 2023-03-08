import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/presentation/login/bloc/login_event.dart';

void main() {
  const tOnLoginChangeOrga = OnLoginChangeOrga('', '');
  const t_OnLoginChangeOrga = OnLoginChangeOrga('', '');
  final tOnLoginWithGoogle = OnLoginWithGoogle();
  final t_OnLoginWithGoogle = OnLoginWithGoogle();
  final tOnLoginStarter = OnLoginStarter();
  final t_OnLoginStarter = OnLoginStarter();

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

    test('OnLoginStarter', () {
      //act
      final result = tOnLoginStarter.props;
      final result2 = t_OnLoginStarter.props;

      //assert
      expect(result, equals(result2));
    });
  });
}
