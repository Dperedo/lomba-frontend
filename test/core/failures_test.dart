import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/failures.dart';

void main() {
  test('ServerFailure', () {
    //arrange
    const fail = ServerFailure('mensaje');

    //act

    //assert
    expect(fail.props, equals(<Object>['mensaje']));
  });

  test('DatabaseFailure', () {
    //arrange
    const fail = DatabaseFailure('mensaje');

    //act

    //assert
    expect(fail.props, equals(<Object>['mensaje']));
  });

  test('CacheFailure', () {
    //arrange
    const fail = CacheFailure('mensaje');

    //act

    //assert
    expect(fail.props, equals(<Object>['mensaje']));
  });
}
