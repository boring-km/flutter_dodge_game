import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('랜덤 테스트', () {
    Random random = Random();

    print(random.nextDouble());
  });
}
