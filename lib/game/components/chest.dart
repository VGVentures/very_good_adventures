import 'package:flame/components.dart';
import 'package:very_good_adventures/game/game.dart';

class Chest extends SpriteGroupComponent<bool>
    with HasGameRef<VeryGoodAdventuresGame> {
  Chest({
    required this.item,
  }) : super(
          priority: 2,
          size: Vector2(32, 20),
        );

  final GameItem item;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    anchor = Anchor.center;

    final openChestSprite = await gameRef.loadSprite('chest_open.png');
    final closedChestSprite = await gameRef.loadSprite('chest_closed.png');

    sprites = {
      true: openChestSprite,
      false: closedChestSprite,
    };

    current = false;
  }
}
