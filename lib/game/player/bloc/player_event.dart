part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();
}

class GameItemToggled extends PlayerEvent {
  const GameItemToggled(this.item);

  final GameItem item;

  @override
  List<Object?> get props => [item];
}
