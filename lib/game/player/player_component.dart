import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/services.dart';
import 'package:very_good_adventures/game/game.dart';

class PlayerGear extends SpriteComponent
    with HasGameRef<VeryGoodAdventuresGame> {
  PlayerGear({
    required this.slot,
    required this.item,
  }) : super(priority: slot == GearSlot.head ? 4 : 5);

  final GearSlot slot;
  final GameItem item;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('${item.name}_gear.png');

    switch (slot) {
      case GearSlot.head:
        anchor = Anchor.bottomCenter;
        size = Vector2(70, 40);
        position = Vector2(15, 8);
        break;
      case GearSlot.leftHand:
        anchor = Anchor.center;
        size = Vector2(40, 75);
        position = Vector2(0, 20);
        break;
      case GearSlot.rightHand:
        anchor = Anchor.center;
        size = Vector2(45, 75);
        position = Vector2(30, 20);
        break;
    }
  }
}

class Player extends PositionComponent
    with KeyboardHandler, HasGameRef<VeryGoodAdventuresGame> {
  Player()
      : super(
          size: Vector2(30, 60),
          priority: 3,
        );

  Vector2 direction = Vector2.zero();
  bool goingRight = true;

  late final PositionComponent idle;
  late final PositionComponent running;

  static const speed = 100.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    anchor = Anchor.center;

    await add(
      FlameBlocListener<PlayerBloc, PlayerState>(onNewState: _handleNewState),
    );

    final idleSprite = await gameRef.loadSprite('player.png');
    idle = SpriteComponent(sprite: idleSprite, size: size);
    await add(idle);

    final runningFrames = await Future.wait([
      gameRef.loadSprite('player_2.png'),
      gameRef.loadSprite('player_3.png'),
      gameRef.loadSprite('player_4.png'),
    ]);

    final runningAnimation = SpriteAnimation(
      runningFrames
          .map(
            (sprite) => SpriteAnimationFrame(sprite, 0.2),
          )
          .toList(),
    );
    running = SpriteAnimationComponent(animation: runningAnimation, size: size);
  }

  @override
  void update(double dt) {
    super.update(dt);

    final newPosition = position + direction * speed * dt;

    position
      ..x = newPosition.x
      ..y = newPosition.y;
  }

  void _handleNewState(PlayerState state) {
    for (final child in children.whereType<PlayerGear>()) {
      child.shouldRemove = true;
    }

    for (final entry in state.gear.entries) {
      final item = entry.value;
      if (item != null) {
        add(PlayerGear(slot: entry.key, item: item));
      }
    }
  }

  void changeDirection({double x = 0, double y = 0}) {
    direction
      ..x = x
      ..y = y;

    if (direction == Vector2.zero()) {
      if (!idle.isMounted) {
        running.removeFromParent();
        add(idle);
      }
    } else {
      if (!running.isMounted) {
        idle.removeFromParent();
        add(running);
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
      changeDirection(x: isDown ? -1 : 0);
      goingRight = false;
      return true;
    }
    if (event.logicalKey == LogicalKeyboardKey.keyD) {
      if (!goingRight) {
        flipHorizontallyAroundCenter();
      }
      changeDirection(x: isDown ? 1 : 0);
      goingRight = true;
      return true;
    }
    if (event.logicalKey == LogicalKeyboardKey.keyW) {
      changeDirection(y: isDown ? -1 : 0);
      return true;
    }
    if (event.logicalKey == LogicalKeyboardKey.keyS) {
      changeDirection(y: isDown ? 1 : 0);
      return true;
    }
    if (!isDown && event.logicalKey == LogicalKeyboardKey.space) {
      final closeChests = gameRef.descendants().whereType<Chest>().where(
        (chest) {
          if (!(chest.current ?? false)) {
            final distance = position.distanceTo(chest.position);
            return distance <= 50;
          }
          return false;
        },
      ).toList();

      if (closeChests.isNotEmpty) {
        final chest = closeChests.first..current = true;

        gameRef.inventoryBloc.add(
          GameItemPickedUp(
            chest.item,
          ),
        );
      }

      return true;
    }
    return false;
  }
}
