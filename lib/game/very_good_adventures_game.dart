import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:very_good_adventures/game/game.dart';

class VeryGoodAdventuresGame extends FlameBlocGame
    with HasKeyboardHandlerComponents {
  static final Vector2 resolution = Vector2(600, 400);

  late final Player player;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    camera.viewport = FixedResolutionViewport(
      Vector2(resolution.x, resolution.y),
    );

    await add(Background());

    await add(player = Player()..y = 40);

    await Future.wait([
      add(
        Pickupable(item: GameItem.sword)
          ..x = -80
          ..y = -40,
      ),
      add(
        Pickupable(item: GameItem.shield)
          ..x = -10
          ..y = -40,
      ),
      add(
        Pickupable(item: GameItem.birdHoddie)
          ..x = 40
          ..y = -40,
      ),
      add(
        Pickupable(item: GameItem.unicornHoddie)
          ..x = 100
          ..y = -40,
      ),
    ]);

    camera.followComponent(player);
  }
}
