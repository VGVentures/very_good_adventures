import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_adventures/game/game.dart';

void main() {
  group('Player', () {
    test('loads correctly', () async {
      final player = Player();

      await player.onLoad();

      expect(player.size, equals(Vector2(20, 60)));
      expect(player.anchor, equals(Anchor.center));
      expect(
        player.paint.color.value,
        equals(Colors.white.value),
      );
    });

    group('update', () {
      test(
        'calculates the correct position when moving vertically',
        () {
          final player = Player()
            ..direction = Vector2(0, 1)
            ..update(0.1);

          expect(player.position.y, equals(10));
        },
      );

      test(
        'calculates the correct position when moving horizontally',
        () {
          final player = Player()
            ..direction = Vector2(1, 0)
            ..update(0.1);

          expect(player.position.x, equals(10));
        },
      );

      test(
        'calculates the correct position when moving on both axis',
        () {
          final player = Player()
            ..direction = Vector2(1, 1)
            ..update(0.1);

          expect(player.position, equals(Vector2.all(10)));
        },
      );
    });

    group('onNewState', () {
      bool Function(Component) findPlayerGear(GameItem item) =>
          (Component child) => child is PlayerGear && child.item == item;

      test('adds the new gear', () {
        final player = Player()
          ..onNewState(
            const PlayerState(
              gear: {
                GearSlot.head: GameItem.birdHoddie,
                GearSlot.rightHand: GameItem.sword,
                GearSlot.leftHand: GameItem.shield,
              },
            ),
          )
          ..updateTree(0);

        expect(player.children.length, equals(3));
        expect(
          player.children.where(findPlayerGear(GameItem.birdHoddie)).length,
          equals(1),
        );
        expect(
          player.children.where(findPlayerGear(GameItem.sword)).length,
          equals(1),
        );
        expect(
          player.children.where(findPlayerGear(GameItem.shield)).length,
          equals(1),
        );
      });

      test('removes gear', () {
        final player = Player()
          ..onNewState(
            const PlayerState(
              gear: {
                GearSlot.head: GameItem.birdHoddie,
                GearSlot.rightHand: GameItem.sword,
                GearSlot.leftHand: GameItem.shield,
              },
            ),
          )
          ..updateTree(0)
          ..onNewState(
            const PlayerState(
              gear: {
                GearSlot.rightHand: GameItem.sword,
              },
            ),
          )
          ..updateTree(0);

        expect(player.children.length, equals(1));
        expect(
          player.children.where(findPlayerGear(GameItem.sword)).length,
          equals(1),
        );
      });
    });
  });
}
