import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_adventures/game/game.dart';

void main() {
  group(
    'PlayerBloc',
    () {
      blocTest<PlayerBloc, PlayerState>(
        'equip the item on the first slot when all of the are free',
        build: () {
          return PlayerBloc();
        },
        act: (bloc) => bloc.add(const GameItemToggled(GameItem.sword)),
        expect: () => [
          const PlayerState(
            gear: {
              GearSlot.head: null,
              GearSlot.rightHand: null,
              GearSlot.leftHand: GameItem.sword,
            },
          ),
        ],
      );

      blocTest<PlayerBloc, PlayerState>(
        'equip the item on the second slot when the second is free',
        build: () {
          return PlayerBloc();
        },
        seed: () => const PlayerState(
          gear: {
            GearSlot.head: null,
            GearSlot.rightHand: null,
            GearSlot.leftHand: GameItem.shield,
          },
        ),
        act: (bloc) => bloc.add(const GameItemToggled(GameItem.sword)),
        expect: () => [
          const PlayerState(
            gear: {
              GearSlot.head: null,
              GearSlot.rightHand: GameItem.sword,
              GearSlot.leftHand: GameItem.shield,
            },
          ),
        ],
      );

      blocTest<PlayerBloc, PlayerState>(
        'equip the item on the first slot when the it is free',
        build: () {
          return PlayerBloc();
        },
        seed: () => const PlayerState(
          gear: {
            GearSlot.head: null,
            GearSlot.rightHand: GameItem.shield,
            GearSlot.leftHand: null,
          },
        ),
        act: (bloc) => bloc.add(const GameItemToggled(GameItem.sword)),
        expect: () => [
          const PlayerState(
            gear: {
              GearSlot.head: null,
              GearSlot.rightHand: GameItem.shield,
              GearSlot.leftHand: GameItem.sword,
            },
          ),
        ],
      );

      blocTest<PlayerBloc, PlayerState>(
        'equip the item over the first slot when the none is free',
        build: () {
          return PlayerBloc();
        },
        seed: () => const PlayerState(
          gear: {
            GearSlot.head: null,
            GearSlot.rightHand: GameItem.shield,
            GearSlot.leftHand: GameItem.shield,
          },
        ),
        act: (bloc) => bloc.add(const GameItemToggled(GameItem.sword)),
        expect: () => [
          const PlayerState(
            gear: {
              GearSlot.head: null,
              GearSlot.rightHand: GameItem.shield,
              GearSlot.leftHand: GameItem.sword,
            },
          ),
        ],
      );

      blocTest<PlayerBloc, PlayerState>(
        'unequip the item if it is already equiped',
        build: () {
          return PlayerBloc();
        },
        seed: () => const PlayerState(
          gear: {
            GearSlot.head: null,
            GearSlot.rightHand: GameItem.shield,
            GearSlot.leftHand: null,
          },
        ),
        act: (bloc) => bloc.add(const GameItemToggled(GameItem.shield)),
        expect: () => [
          const PlayerState(
            gear: {
              GearSlot.head: null,
              GearSlot.rightHand: null,
              GearSlot.leftHand: null,
            },
          ),
        ],
      );
    },
  );
}
