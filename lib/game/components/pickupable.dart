import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:very_good_adventures/game/game.dart';

class Pickupable extends RectangleComponent {
  Pickupable({
    required this.item,
  }) : super(
          size: Vector2.all(20),
          priority: 3,
        ) {
    paint = Paint()..color = Colors.blue;
  }

  final GameItem item;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    anchor = Anchor.center;
  }
}
