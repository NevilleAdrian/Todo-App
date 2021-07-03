import 'package:flutter_test/flutter_test.dart';
import 'package:morphosis_flutter_demo/ui/utils/test_functions.dart';

void main() {
  group('Search Field test', () {
    test(
        'searching on TextFormField will return data that starts with typed data',
        () {
      final text = 'b';
      expect(onFilter(text), 'Billy');
    });

    test(
        'Searching on TextFormField will not return data that starts with typed data',
        () {
      final text = 'c';
      expect(onFilter(text), 'Billy');
    });
  });
}
