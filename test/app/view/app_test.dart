// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_adventures/app/app.dart';
import 'package:very_good_adventures/game/game.dart';
import 'package:very_good_adventures/title/title.dart';

import '../../helpers/helpers.dart';

class MockInventoryBloc extends Mock implements InventoryBloc {}

class MockPlayerBloc extends Mock implements PlayerBloc {}

void main() {
  group('App', () {
    testWidgets('renders the TitleView', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(TitleView), findsOneWidget);
    });

    testWidgets('open the game when tapping on Play', (tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.text('Play!'));

      await tester.pump(); // One for the navigation animation
      await tester.pump(); // One for the page itself to render

      expect(find.byType(VeryGoodAdventuresPage), findsOneWidget);
    });

    testWidgets('request focus on hover', (tester) async {
      final inventoryBloc = MockInventoryBloc();
      final playerBloc = MockPlayerBloc();

      whenListen(
        inventoryBloc,
        Stream.value(const InventoryState.initial()),
        initialState: const InventoryState.initial(),
      );
      whenListen(
        playerBloc,
        Stream.value(const PlayerState.initial()),
        initialState: const PlayerState.initial(),
      );
      await tester.pumpApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<InventoryBloc>.value(value: inventoryBloc),
            BlocProvider<PlayerBloc>.value(value: playerBloc),
          ],
          child: const VeryGoodAdventuresPage(),
        ),
      );

      await tester.pump();

      // Remove focus
      tester
          .state<VeryGoodAdventuresGameViewState>(
            find.byType(
              VeryGoodAdventuresGameView,
            ),
          )
          .gameFocusNode
          .unfocus();

      await tester.pump();

      var hasFocus = tester
          .state<VeryGoodAdventuresGameViewState>(
            find.byType(
              VeryGoodAdventuresGameView,
            ),
          )
          .gameFocusNode
          .hasFocus;

      expect(hasFocus, isFalse);

      final gesture = await tester.createGesture(
        kind: PointerDeviceKind.mouse,
      );

      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await tester.pump();
      await gesture
          .moveTo(tester.getCenter(find.byType(VeryGoodAdventuresGameView)));
      await tester.pump();

      hasFocus = tester
          .state<VeryGoodAdventuresGameViewState>(
            find.byType(
              VeryGoodAdventuresGameView,
            ),
          )
          .gameFocusNode
          .hasFocus;

      expect(hasFocus, isTrue);
    });
  });
}
