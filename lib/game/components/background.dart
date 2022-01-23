import 'package:flame/components.dart';
import 'package:very_good_adventures/game/game.dart';

class Background extends SpriteComponent
    with HasGameRef<VeryGoodAdventuresGame> {
  Background()
      : super(
          size: Vector2(600, 200),
          priority: 1,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    anchor = Anchor.center;

    sprite = await gameRef.loadSprite('background.png');
  }
}
