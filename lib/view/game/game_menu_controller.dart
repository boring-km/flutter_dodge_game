import 'package:dodge_game/game/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameMenuController extends GetxController {
  bool isPaused = false;

  void toggleGameState(DodgeGame dodgeGame) {
    if (isPaused) {
      dodgeGame.resumeGame();
      isPaused = false;
    } else {
      dodgeGame.pauseGame();
      isPaused = true;
    }
    update();
  }

  IconData getPauseIcon() {
    return isPaused ? Icons.play_arrow : Icons.pause;
  }
}
