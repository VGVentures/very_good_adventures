import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_adventures/game/game.dart';

void main() {
  group('Background', () {
    test('loads correctly', () async {
      final background = Background();

      await background.onLoad();

      expect(background.size, equals(Vector2(600, 200)));
      expect(background.anchor, equals(Anchor.center));
      expect(
        background.paint.color.value,
        equals(Colors.grey.value),
      );
    });
  });
}
