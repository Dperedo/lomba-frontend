import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/data/models/sort_model.dart';

void main() {
  const tSortModel = SortModel(<String, int>{'created': 1});

  const tSort = SortModel(<String, int>{'created': 1});

  group('sort model methods', () {
    test('sort model props', () {
      //

      //act
      final result = tSortModel.props;
      final result2 = tSort.props;

      //assert
      expect(result, equals(result2));
    });
  });
}
