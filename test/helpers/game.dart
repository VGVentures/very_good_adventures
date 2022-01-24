// ignore_for_file: invalid_use_of_internal_member

import 'package:flame/game.dart';

// https://github.com/flame-engine/flame/issues/1335
extension FlameGameExtension on FlameGame {
  Future<void> gameLoading() async {
    // This is internal to Flame, but it seems to be a the only way to make sure
    // that the game is completely loaded, keeping this in a separate file as a
    // PR on Flame will be made to include a similar helper
    await onLoadCache;
  }
}
