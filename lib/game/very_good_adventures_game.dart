import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:very_good_adventures/game/game.dart';

class VeryGoodAdventuresGame extends FlameGame
    with HasKeyboardHandlerComponents {
  static final Vector2 resolution = Vector2(600, 400);

  late final Player player;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    camera.viewport = FixedResolutionViewport(
      Vector2(resolution.x, resolution.y),
    );

    await add(
      player = Player()
        ..x = 80
        ..y = 120,
    );

    await Future.wait([
      add(
        Pickupable()
          ..x = 20
          ..y = 20,
      ),
      add(
        Pickupable()
          ..x = 80
          ..y = 20,
      ),
      add(
        Pickupable()
          ..x = 140
          ..y = 20,
      ),
    ]);

    camera.followComponent(player);
  }
}
