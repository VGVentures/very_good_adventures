import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_adventures/game/game.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Chest', () {
    FlameTester(VeryGoodAdventuresGame.new).test('loads correctly',
        (game) async {
      final chest = Chest(item: GameItem.sword);
      await game.ensureAdd(chest);

      expect(chest.sprites, isNotNull);
    });
  });
}
