import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';

void main() {
  test('clase con lista de roles debe tener la cantidad de 4', () {
    //arrange
    const rolesWaited = 4;

    //act
    final roles = Roles.toList();

    //assert
    expect(roles.length, equals(rolesWaited));
  });
}
