import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/services.dart';
import 'package:very_good_adventures/game/game.dart';

class PlayerGear extends SpriteComponent
    with HasGameRef<VeryGoodAdventuresGame> {
  PlayerGear({
    required this.slot,
    required this.item,
  });

  final GearSlot slot;
  final GameItem item;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('${item.name}.png');

    switch (item) {
      case GameItem.sword:
        size = Vector2(15, 30);
        anchor = Anchor.bottomCenter;
        position = Vector2(slot == GearSlot.leftHand ? 2 : 28, 37.5);
        break;
      case GameItem.shield:
        size = Vector2.all(25);
        anchor = Anchor.center;
        position = Vector2(slot == GearSlot.leftHand ? 0 : 30, 35);
        break;
      case GameItem.birdHoddie:
        anchor = Anchor.bottomCenter;
        position = Vector2(17, 8);

        final factor = 30 / sprite!.image.width;
        size = Vector2(
          sprite!.image.width * factor,
          sprite!.image.height * factor,
        );

        break;
      case GameItem.unicornHoddie:
        anchor = Anchor.bottomCenter;
        position = Vector2(25, 10);

        final factor = 45 / sprite!.image.width;
        size = Vector2(
          sprite!.image.width * factor,
          sprite!.image.height * factor,
        );

        break;
    }
  }
}

class Player extends SpriteComponent
    with
        KeyboardHandler,
        HasGameRef<VeryGoodAdventuresGame>,
        BlocComponent<PlayerBloc, PlayerState> {
  Player()
      : super(
          size: Vector2(30, 60),
          priority: 2,
        );

  Vector2 direction = Vector2.zero();
  bool goingRight = true;

  static const speed = 100.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    anchor = Anchor.center;

    sprite = await gameRef.loadSprite('player.png');
  }

  @override
  void update(double dt) {
    super.update(dt);

    final newPosition = position + direction * speed * dt;

    position
      ..x = newPosition.x
      ..y = newPosition.y;
  }

  @override
  void onNewState(PlayerState state) {
    for (final child in children) {
      child.shouldRemove = true;
    }

    for (final entry in state.gear.entries) {
      final item = entry.value;
      if (item != null) {
        add(PlayerGear(slot: entry.key, item: item));
      }
    }
  }

  @override
  bool onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isDown = event is RawKeyDownEvent;

    if (event.logicalKey == LogicalKeyboardKey.keyA) {
      if (goingRight) {
        flipHorizontallyAroundCenter();
      }
      direction.x = isDown ? -1 : 0;
      goingRight = false;
      return true;
    }
    if (event.logicalKey == LogicalKeyboardKey.keyD) {
      if (!goingRight) {
        flipHorizontallyAroundCenter();
      }
      direction.x = isDown ? 1 : 0;
      goingRight = true;
      return true;
    }
    if (event.logicalKey == LogicalKeyboardKey.keyW) {
      direction.y = isDown ? -1 : 0;
      return true;
    }
    if (event.logicalKey == LogicalKeyboardKey.keyS) {
      direction.y = isDown ? 1 : 0;
      return true;
    }
    if (event.logicalKey == LogicalKeyboardKey.space) {
      final closePickups =
          gameRef.children.whereType<Pickupable>().where((element) {
        final distance = position.distanceTo(element.position);
        return distance <= 50;
      }).toList();

      if (closePickups.isNotEmpty) {
        final pickup = closePickups.first..shouldRemove = true;

        gameRef.read<InventoryBloc>().add(
              GameItemPickedUp(
                pickup.item,
              ),
            );
      }

      return true;
    }
    return false;
  }
}
