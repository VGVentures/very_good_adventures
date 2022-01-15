// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_adventures/game/game.dart';

void main() {
  group('InventoryEvent', () {
    test('can be instantiated', () {
      expect(GameItemPickedUp(GameItem.sword), isNotNull);
    });

    test('supports value comparison', () {
      expect(
        GameItemPickedUp(GameItem.sword),
        equals(
          GameItemPickedUp(GameItem.sword),
        ),
      );

      expect(
        GameItemPickedUp(GameItem.sword),
        isNot(
          equals(
            GameItemPickedUp(GameItem.shield),
          ),
        ),
      );
    });
  });
}
