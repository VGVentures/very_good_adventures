import 'package:flame/components.dart';
import 'package:very_good_adventures/game/game.dart';

class Pickupable extends SpriteComponent
    with HasGameRef<VeryGoodAdventuresGame> {
  Pickupable({
    required this.item,
  }) : super(
          priority: 3,
        );

  final GameItem item;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    anchor = Anchor.center;

    sprite = await gameRef.loadSprite('${item.name}.png');

    final factor = 20 / sprite!.image.height;
    size = Vector2(
      sprite!.image.width * factor,
      sprite!.image.height * factor,
    );
  }
}
