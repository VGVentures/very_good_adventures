import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_adventures/game/game.dart';

class VeryGoodAdventuresGameView extends StatelessWidget {
  const VeryGoodAdventuresGameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<InventoryBloc>(create: (_) => InventoryBloc())
        ],
        child: Row(
          children: [
            Expanded(child: GameWidget(game: VeryGoodAdventuresGame())),
            const InventoryView(),
          ],
        ),
      ),
    );
  }
}
