part of 'inventory_bloc.dart';

class InventoryState extends Equatable {
  const InventoryState({
    required this.items,
  });
  
  const InventoryState.initial() : this(items: const []);

  final List<GameItem> items;

  @override
  List<Object> get props => [items];

  InventoryState copyWith({
    List<GameItem>? items,
  }) {
    return InventoryState(items: items ?? this.items);
  }
}
