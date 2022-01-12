import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Pickupable extends RectangleComponent {
  Pickupable() : super(size: Vector2.all(20)) {
    paint = Paint()..color = Colors.blue;
  }
}
