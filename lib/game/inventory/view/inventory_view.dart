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
      height: double.infinity,
      child: GridView.count(
        crossAxisCount: 6,
        children: [
          for (var i = 0; i < inventorySize; i++)
            _InventorySlot(
              item: i < gameItems.length ? gameItems[i] : null,
            ),
        ],
      ),
    );
  }
}

class _InventorySlot extends StatelessWidget {
  const _InventorySlot({
    Key? key,
    this.item,
  }) : super(key: key);

  final GameItem? item;

  @override
  Widget build(BuildContext context) {
    final name = item?.name;
    return InkWell(
      onTap: () {
        if (item != null) {
          context.read<PlayerBloc>().add(
                GameItemToggled(
                  item!,
                ),
              );
        }
      },
      child: Card(
        child: name != null ? Center(child: Text(name)) : null,
      ),
    );
  }
}
