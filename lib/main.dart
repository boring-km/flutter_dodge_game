import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'dodge_game.dart';

void main() {
  final game = DodgeGame(children: [MyFace()]);
  runApp(
    GameWidget(
      game: game,
    ),
  );
}
