// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_adventures/app/app.dart';
import 'package:very_good_adventures/game/game.dart';

void main() {
  group('App', () {
    testWidgets('renders VeryGoodAdventuresGameView', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(VeryGoodAdventuresGameView), findsOneWidget);
    });

    testWidgets('request focus on hover', (tester) async {
      await tester.pumpWidget(const App());

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
