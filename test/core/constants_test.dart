import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/constants.dart';

void main() {
  test('clase con lista de roles debe tener la cantidad de 5', () {
    //arrange
    const rolesWaited = 5;

    //act
    final roles = Roles.toList();

    //assert
    expect(roles.length, equals(rolesWaited));
  });

  test('clase con lista de boxpages debe tener la cantidad de 7', () {
    //arrange
    const boxPagesWaited = 7;

    //act
    final boxpages = BoxPages.toList();

    //assert
    expect(boxpages.length, equals(boxPagesWaited));
  });
}
