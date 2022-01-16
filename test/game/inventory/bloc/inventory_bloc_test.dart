import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_adventures/game/game.dart';

void main() {
  group('InventoryBloc', () {
    blocTest<InventoryBloc, InventoryState>(
      'adds a game item to the state on GameItemPickedUp',
      build: () {
        return InventoryBloc();
      },
      act: (bloc) => bloc.add(
        const GameItemPickedUp(GameItem.sword),
      ),
      expect: () => [
        const InventoryState(items: [GameItem.sword])
      ],
    );
  });
}
