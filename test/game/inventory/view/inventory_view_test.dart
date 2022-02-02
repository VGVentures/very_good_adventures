// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_adventures/game/game.dart';

import '../../../helpers/helpers.dart';

class MockInventoryBloc extends Mock implements InventoryBloc {}

class MockPlayerBloc extends Mock implements PlayerBloc {}

void main() {
  late InventoryBloc bloc;
  late PlayerBloc playerBloc;

  setUp(() {
    bloc = MockInventoryBloc();
    playerBloc = MockPlayerBloc();
  });

  void _mockState(InventoryState state) {
    whenListen<InventoryState>(
      bloc,
      Stream.value(
        state,
      ),
      initialState: state,
    );
  }

  Future<void> _pumpView(WidgetTester tester) async {
    await tester.pumpApp(
      Scaffold(
        body: SizedBox(
          height: 200,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: bloc),
              BlocProvider.value(value: playerBloc),
            ],
            child: InventoryView(),
          ),
        ),
      ),
    );
  }

  group('InventoryView', () {
    testWidgets('renders', (tester) async {
      _mockState(
        InventoryState(
          items: const [
            GameItem.unicornHoddie,
            GameItem.sword,
            GameItem.shield,
          ],
        ),
      );

      await _pumpView(tester);

      expect(find.byKey(Key('_gear_unicornHoddie')), findsOneWidget);
      expect(find.byKey(Key('_gear_sword')), findsOneWidget);
      expect(find.byKey(Key('_gear_shield')), findsOneWidget);
    });

    testWidgets('adds [GameItemToggled] when taping an item', (tester) async {
      whenListen(
        playerBloc,
        Stream.value(PlayerState.initial()),
        initialState: PlayerState.initial(),
      );

      _mockState(
        InventoryState(
          items: const [
            GameItem.unicornHoddie,
            GameItem.sword,
            GameItem.shield,
          ],
        ),
      );

      await _pumpView(tester);

      await tester.tap(find.byKey(Key('_gear_shield')));

      verify(() => playerBloc.add(GameItemToggled(GameItem.shield))).called(1);
    });
  });
}
