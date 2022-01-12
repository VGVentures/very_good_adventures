import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:very_good_adventures/game/game.dart';

class Player extends RectangleComponent
    with KeyboardHandler, HasGameRef<VeryGoodAdventuresGame> {
  Player() : super(size: Vector2(20, 60));

  Vector2 direction = Vector2.zero();

  static const speed = 100.0;

  @override
  void update(double dt) {
    super.update(dt);

    final newPosition = position + direction * speed * dt;
    final rect = newPosition.toPositionedRect(size);

    if (rect.left > 0 && rect.right < VeryGoodAdventuresGame.resolution.x) {
      position.x = newPosition.x;
    }
    if (rect.top > 0 && rect.bottom < VeryGoodAdventuresGame.resolution.y) {
      position.y = newPosition.y;
    }
  }

  @override
  bool onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isDown = event is RawKeyDownEvent;

    if (event.logicalKey == LogicalKeyboardKey.keyA) {
      direction.x = isDown ? -1 : 0;
      return true;
    }
    if (event.logicalKey == LogicalKeyboardKey.keyD) {
      direction.x = isDown ? 1 : 0;
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
        return distance <= 40;
      }).toList();

      if (closePickups.isNotEmpty) {
        // TODO add bloc logic to the pick up item
        closePickups.first.shouldRemove = true;
      }

      return true;
    }
    return false;
  }
}
