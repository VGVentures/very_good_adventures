import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_adventures/game/game.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gear = context.select((PlayerBloc bloc) => bloc.state.gear);
    return Column(
      children: [
        Container(
          width: 200,
          height: 200,
          padding: const EdgeInsets.all(16),
          child: Hero(
            tag: 'logo',
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.4,
                  child: Image.asset(
                    'assets/images/player_silhouette.png',
                  ),
                ),
              ),
              Positioned(
                top: 6,
                left: 103,
                child: _ItemSlot(
                  item: gear[GearSlot.head],
                ),
              ),
              Positioned(
                top: 60,
                left: 40,
                child: _ItemSlot(
                  item: gear[GearSlot.leftHand],
                ),
              ),
              Positioned(
                top: 60,
                left: 168,
                child: _ItemSlot(
                  item: gear[GearSlot.rightHand],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _ItemSlot extends StatelessWidget {
  const _ItemSlot({Key? key, this.item}) : super(key: key);

  final GameItem? item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 35,
        height: 35,
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
