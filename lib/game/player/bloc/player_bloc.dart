import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_adventures/game/game.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(const PlayerState.initial()) {
    on<GameItemToggled>(_onGameItemToggled);
  }

  void _onGameItemToggled(
    GameItemToggled event,
    Emitter<PlayerState> emit,
  ) {
    final item = event.item;

    if (state.isItemEquiped(item)) {
      final itemSlot = state.gear.entries
          .where(
            (entry) => entry.value == item,
          )
          .first
          .key;
      emit(state.copyWithGear(slot: itemSlot, item: null));
    } else {
      final possibleSlots = item.slots;
      final freeSlots = state.gear.entries
          .where(
            (entry) => possibleSlots.contains(entry.key) && entry.value == null,
          )
          .toList();

      if (freeSlots.isNotEmpty) {
        emit(state.copyWithGear(slot: freeSlots.first.key, item: item));
      } else {
        emit(state.copyWithGear(slot: possibleSlots.first, item: item));
      }
    }
  }
}
