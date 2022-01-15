// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_adventures/app/app.dart';
import 'package:very_good_adventures/game/game.dart';

void main() {
  group('App', () {
    testWidgets('renders VeryGoodAdventuresGameView', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(VeryGoodAdventuresGameView), findsOneWidget);
    });
  });
}
