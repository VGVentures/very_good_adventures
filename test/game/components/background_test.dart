import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_adventures/game/game.dart';

class MockInventoryBloc extends Mock implements InventoryBloc {}

class MockPlayerBloc extends Mock implements PlayerBloc {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Background', () {
    FlameTester(() {
      return VeryGoodAdventuresGame(
        inventoryBloc: MockInventoryBloc(),
        playerBloc: MockPlayerBloc(),
      );
    }).test('loads correctly', (game) async {
      final background = Background();
      await game.ensureAdd(background);

      expect(background.size, equals(Vector2(600, 200)));
      expect(background.anchor, equals(Anchor.center));
      expect(background.sprite, isNotNull);
    });
  });
}
