part of 'inventory_bloc.dart';

abstract class InventoryEvent extends Equatable {
  const InventoryEvent();
}

class GameItemPickedUp extends InventoryEvent {

  const GameItemPickedUp(this.gameItem);

  final GameItem gameItem;

  @override
  List<Object?> get props => [gameItem];
}
