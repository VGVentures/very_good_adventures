import 'package:flutter/material.dart';
import 'package:very_good_adventures/game/model/game_item.dart';

class ItemSlot extends StatelessWidget {
  const ItemSlot({
    Key? key,
    this.item,
    this.size = 35,
  }) : super(key: key);

  final GameItem? item;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(2),
        child: item != null
            ? Image.asset(
                'assets/images/${item!.name}.png',
                key: Key('_gear_${item!.name}'),
              )
            : null,
      ),
    );
  }
}
