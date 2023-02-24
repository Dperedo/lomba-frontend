import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/core/model_container.dart';

void main() {
  test('ModelContainer', () {
    //arrange
    const modelContainer = ModelContainer([], 1, 10, 1, 10, 1, 2, 'kind');

    //act

    //assert
    expect(modelContainer.items.length, equals(0));
  });

  test('ModelContainer - prueba de propiedades', () {
    //arrange
    const modelContainer = ModelContainer([], 1, 10, 1, 10, 1, 2, 'kind');

    //act

    //assert
    expect(modelContainer.props, equals(<Object>[[], 1]));
  });
}
