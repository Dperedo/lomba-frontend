import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/fakedata.dart';

void main() {
  test('TestRandomItem', () {
    //arrange
    final randomItem = TestRandomItem('id', 'name', 1, 'text');

    //act

    //assert
    expect(randomItem.id, equals('id'));
    expect(randomItem.name, equals('name'));
    expect(randomItem.num, equals(1));
    expect(randomItem.text, equals('text'));
  });

  test('List<TestRandomItem>', () {
    //arrange

    //act

    //assert
    expect(testRandomItemList.length, equals(101));
  });
}
