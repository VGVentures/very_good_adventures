// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_adventures/game/game.dart';

import '../../../helpers/helpers.dart';

class MockPlayerBloc extends Mock implements PlayerBloc {}

void main() {
  group('PlayerView', () {
    late PlayerBloc bloc;

    setUp(() {
      bloc = MockPlayerBloc();
    });

    void _mockState(PlayerState state) {
      whenListen<PlayerState>(
        bloc,
        Stream.value(state),
        initialState: state,
      );
    }

    Future<void> _pumpView(WidgetTester tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: Scaffold(
            body: PlayerView(),
          ),
        ),
      );
    }

    testWidgets('renders', (tester) async {
      _mockState(
        PlayerState(
          gear: const {
            GearSlot.head: GameItem.unicornHoddie,
            GearSlot.leftHand: GameItem.sword,
            GearSlot.rightHand: GameItem.shield,
          },
        ),
      );

      await _pumpView(tester);

      expect(
        find.text('Head: ${GameItem.unicornHoddie.name}'),
        findsOneWidget,
      );
      expect(
        find.text('L Hand: ${GameItem.sword.name}'),
        findsOneWidget,
      );
      expect(
        find.text('R Hand: ${GameItem.shield.name}'),
        findsOneWidget,
      );
    });

    testWidgets('renders when items are empty', (tester) async {
      _mockState(PlayerState.initial());

      await _pumpView(tester);

      expect(
        find.text('Head: -'),
        findsOneWidget,
      );
      expect(
        find.text('L Hand: -'),
        findsOneWidget,
      );
      expect(
        find.text('R Hand: -'),
        findsOneWidget,
      );
    });
  });
}
