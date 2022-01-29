import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_adventures/game/game.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Pickupable', () {
    FlameTester(VeryGoodAdventuresGame.new).test('loads correctly',
        (game) async {
      final pickupable = Pickupable(item: GameItem.sword);
      await game.ensureAdd(pickupable);

      expect(pickupable.size.y, equals(20));
      expect(pickupable.anchor, equals(Anchor.center));
      expect(pickupable.sprite, isNotNull);
    });
  });
}
