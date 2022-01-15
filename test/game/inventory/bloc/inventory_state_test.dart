// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_adventures/game/game.dart';

void main() {
  group('InventoryState', () {
    test('can be instantiated', () {
      expect(InventoryState(items: const []), isNotNull);
    });

    test('returns the correct initial state', () {
      expect(
        InventoryState.initial(),
        equals(
          InventoryState(items: const []),
        ),
      );
    });

    test('supports value comparison', () {
      expect(
        InventoryState(items: const [GameItem.sword]),
        equals(
          InventoryState(
            items: const [GameItem.sword],
          ),
        ),
      );

      expect(
        InventoryState(items: const [GameItem.sword]),
        isNot(
          equals(
            InventoryState(
              items: const [GameItem.shield],
            ),
          ),
        ),
      );
    });

    test('copy the instance with a new items', () {
      expect(
        InventoryState.initial().copyWith(items: [GameItem.sword]),
        equals(
          InventoryState(
            items: const [GameItem.sword],
          ),
        ),
      );
    });
  });
}
