import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Background extends RectangleComponent {
  Background() : super(size: Vector2(600, 200));

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    anchor = Anchor.center;
    paint = Paint()..color = Colors.grey;
  }
}
