import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_adventures/game/game.dart';

class InventoryView extends StatelessWidget {
  const InventoryView({Key? key}) : super(key: key);

  static const inventorySize = 12;

  @override
  Widget build(BuildContext context) {
    final gameItems = context.watch<InventoryBloc>().state.items;

    return Container(
      color: Colors.white,
      width: 250,
      height: double.infinity,
      child: GridView.count(
        crossAxisCount: 3,
        children: [
          for (var i = 0; i < inventorySize; i++)
            const Card(),
        ],
      ),
    );
  }
}
