import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_adventures/game/game.dart';

class VeryGoodAdventuresGameView extends StatefulWidget {
  const VeryGoodAdventuresGameView({Key? key}) : super(key: key);

  @override
  State<VeryGoodAdventuresGameView> createState() =>
      VeryGoodAdventuresGameViewState();
}

class VeryGoodAdventuresGameViewState
    extends State<VeryGoodAdventuresGameView> {
  late FocusNode gameFocusNode;

  @override
  void initState() {
    super.initState();

    gameFocusNode = FocusNode();
  }

  @override
  void dispose() {
    gameFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<InventoryBloc>(create: (_) => InventoryBloc()),
          BlocProvider<PlayerBloc>(create: (_) => PlayerBloc())
        ],
        child: Row(
          children: [
            Expanded(
              child: MouseRegion(
                onHover: (_) {
                  if (!gameFocusNode.hasFocus) {
                    gameFocusNode.requestFocus();
                  }
                },
                child: GameWidget(
                  focusNode: gameFocusNode,
                  game: VeryGoodAdventuresGame(),
                ),
              ),
            ),
            SizedBox(
              width: 250,
              height: double.infinity,
              child: Column(
                children: const [
                  Expanded(child: PlayerView()),
                  Expanded(child: InventoryView()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
