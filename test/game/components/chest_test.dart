import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_adventures/game/game.dart';

class MockInventoryBloc extends Mock implements InventoryBloc {}

class MockPlayerBloc extends Mock implements PlayerBloc {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Chest', () {
    FlameTester(() {
      return VeryGoodAdventuresGame(
        playerBloc: MockPlayerBloc(),
        inventoryBloc: MockInventoryBloc(),
      );
    }).test('loads correctly', (game) async {
      final chest = Chest(item: GameItem.sword);
      await game.ensureAdd(chest);

      expect(chest.sprites, isNotNull);
    });
  });
}
