import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_adventures/game/game.dart';

void main() {
  group('Pickupable', () {
    test('loads correctly', () async {
      final pickupable = Pickupable(item: GameItem.sword);

      await pickupable.onLoad();

      expect(pickupable.size, equals(Vector2.all(20)));
      expect(pickupable.anchor, equals(Anchor.center));
      expect(
        pickupable.paint.color.value,
        equals(Colors.blue.value),
      );
    });
  });
}
