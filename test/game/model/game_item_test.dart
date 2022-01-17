import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_adventures/game/game.dart';

void main() {
  group('GameItem', () {
    test('returns the correct slot for sword', () {
      expect(
        GameItem.sword.slots,
        equals([GearSlot.leftHand, GearSlot.rightHand]),
      );
    });

    test('returns the correct slot for shield', () {
      expect(
        GameItem.shield.slots,
        equals([GearSlot.leftHand, GearSlot.rightHand]),
      );
    });

    test('returns the correct slot for unicornHoddie', () {
      expect(
        GameItem.unicornHoddie.slots,
        equals([GearSlot.head]),
      );
    });

    test('returns the correct slot for birdHoddie', () {
      expect(
        GameItem.birdHoddie.slots,
        equals([GearSlot.head]),
      );
    });
  });
}
