part of 'player_bloc.dart';

class PlayerState extends Equatable {
  const PlayerState({required this.gear});

  const PlayerState.initial()
      : this(
          gear: const {
            GearSlot.head: null,
            GearSlot.leftHand: null,
            GearSlot.rightHand: null,
          },
        );

  final Map<GearSlot, GameItem?> gear;

  @override
  List<Object?> get props => [gear];

  bool isItemEquiped(GameItem item) {
    return gear.values.contains(item);
  }

  PlayerState copyWithGear({
    required GearSlot slot,
    required GameItem? item,
  }) {
    return PlayerState(
      gear: {
        ...gear,
        slot: item,
      },
    );
  }
}
