import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:very_good_adventures/game/game.dart';

class VeryGoodAdventuresGameView extends StatelessWidget {

  const VeryGoodAdventuresGameView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GameWidget(game: VeryGoodAdventuresGame()),
    );
  }
}
