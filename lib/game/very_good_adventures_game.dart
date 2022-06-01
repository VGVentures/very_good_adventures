import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:very_good_adventures/game/game.dart';

class VeryGoodAdventuresGame extends FlameGame
    with HasKeyboardHandlerComponents {
  VeryGoodAdventuresGame({
    required this.playerBloc,
    required this.inventoryBloc,
  });

  static final Vector2 resolution = Vector2(600, 400);

  late final Player player;
  final PlayerBloc playerBloc;
  final InventoryBloc inventoryBloc;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    camera.viewport = FixedResolutionViewport(
      Vector2(resolution.x, resolution.y),
    );

    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<PlayerBloc, PlayerState>.value(
            value: playerBloc,
          ),
          FlameBlocProvider<InventoryBloc, InventoryState>.value(
            value: inventoryBloc,
          ),
        ],
        children: [
          Background(),
          player = Player()..y = 40,
          Chest(item: GameItem.sword)
            ..x = -80
            ..y = -40,
          Chest(item: GameItem.shield)
            ..x = -10
            ..y = -40,
          Chest(item: GameItem.birdHoddie)
            ..x = 40
            ..y = -40,
          Chest(item: GameItem.unicornHoddie)
            ..x = 100
            ..y = -40,
        ],
      ),
    );

    camera.followComponent(player);
  }
}
