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
        Text('Head: ${gear[GearSlot.head]?.name ?? '-'}'),
        Text('L Hand: ${gear[GearSlot.leftHand]?.name ?? '-'}'),
        Text('R Hand: ${gear[GearSlot.rightHand]?.name ?? '-'}'),
      ],
    );
  }
}
