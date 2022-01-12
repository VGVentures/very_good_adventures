import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_adventures/game/game.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  InventoryBloc() : super(const InventoryState.initial()) {
    on<GameItemPickedUp>(_handleGameItemPickedUp);
  }

  void _handleGameItemPickedUp(
    GameItemPickedUp event,
    Emitter<InventoryState> emit,
  ) {
    emit(
      state.copyWith(
        items: [
          ...state.items,
          event.gameItem,
        ],
      ),
    );
  }
}
