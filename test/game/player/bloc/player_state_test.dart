// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_adventures/game/game.dart';

void main() {
  group('PlayerState', () {
    test('can be instantiated', () {
      expect(PlayerState(gear: const {}), isNotNull);
    });

    test('initial returns the correct initial state', () {
      expect(
        PlayerState.initial(),
        equals(
          PlayerState(
            gear: const {
              GearSlot.head: null,
              GearSlot.leftHand: null,
              GearSlot.rightHand: null,
            },
          ),
        ),
      );
    });

    test('supports value comparison', () {
      expect(
        PlayerState.initial(),
        equals(PlayerState.initial()),
      );

      expect(
        PlayerState.initial(),
        isNot(
          equals(
            PlayerState(
              gear: const {
                GearSlot.head: GameItem.birdHoddie,
              },
            ),
          ),
        ),
      );
    });

    group('isItemEquiped', () {
      test('returns true when the item is equipped', () {
        expect(
          PlayerState(
            gear: const {
              GearSlot.head: GameItem.birdHoddie,
            },
          ).isItemEquiped(GameItem.birdHoddie),
          isTrue,
        );
      });

      test('returns false when the item is equipped', () {
        expect(
          PlayerState(
            gear: const {
              GearSlot.head: GameItem.unicornHoddie,
            },
          ).isItemEquiped(GameItem.birdHoddie),
          isFalse,
        );
      });
    });

    test('copyWithGear returns a new instance with the gear equipped', () {
      expect(
        PlayerState.initial().copyWithGear(
          slot: GearSlot.leftHand,
          item: GameItem.sword,
        ),
        equals(
          PlayerState(
            gear: const {
              GearSlot.head: null,
              GearSlot.leftHand: GameItem.sword,
              GearSlot.rightHand: null,
            },
          ),
        ),
      );
    });
  });
}
