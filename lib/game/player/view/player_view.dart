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
        PanelContainer(
          height: 120,
          child: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.8,
                  child: Image.asset(
                    'assets/images/player_silhouette.png',
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 88,
                child: ItemSlot(
                  item: gear[GearSlot.head],
                ),
              ),
              Positioned(
                top: 42,
                left: 40,
                child: ItemSlot(
                  item: gear[GearSlot.leftHand],
                ),
              ),
              Positioned(
                top: 42,
                left: 134,
                child: ItemSlot(
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
