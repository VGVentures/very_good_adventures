import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_adventures/game/game.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Background', () {
    FlameTester(VeryGoodAdventuresGame.new).test('loads correctly',
        (game) async {
      final background = Background();
      await game.ensureAdd(background);

      expect(background.size, equals(Vector2(600, 200)));
      expect(background.anchor, equals(Anchor.center));
      expect(background.sprite, isNotNull);
    });
  });
}
