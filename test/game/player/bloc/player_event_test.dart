// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_adventures/game/game.dart';

void main() {
  group('GameItemToggled', () {
    test('can be instantiated', () {
      expect(
        GameItemToggled(GameItem.sword),
        isNotNull,
      );
    });

    test('supports value comparison', () {
      expect(
        GameItemToggled(GameItem.sword),
        equals(GameItemToggled(GameItem.sword)),
      );
      expect(
        GameItemToggled(GameItem.sword),
        isNot(
          equals(GameItemToggled(GameItem.unicornHoddie)),
        ),
      );
    });
  });
}
