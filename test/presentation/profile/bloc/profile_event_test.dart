import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/presentation/profile/bloc/profile_event.dart';

void main() {
  
  const tOnProfileLoad = OnProfileLoad('');
  const t_OnProfileLoad = OnProfileLoad('');

  test('On Profile Load', () {
    //act
    final result = tOnProfileLoad.props;
    final result2 = t_OnProfileLoad.props;

    //assert
    expect(result, equals(result2));
  });
}