import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_adventures/game/game.dart';

class VeryGoodAdventuresPage extends StatelessWidget {
  const VeryGoodAdventuresPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<InventoryBloc>(create: (_) => InventoryBloc()),
            BlocProvider<PlayerBloc>(create: (_) => PlayerBloc())
          ],
          child: const VeryGoodAdventuresPage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const VeryGoodAdventuresGameView();
  }
}
