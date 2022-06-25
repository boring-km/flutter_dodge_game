import 'package:dodge_game/game/game.dart';
import 'package:dodge_game/presentation/game/game_screen_controller.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameScreen extends GetView<GameScreenController> {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dodgeGame = DodgeGame();
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: dodgeGame,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  dodgeGame.onPanEnd(null);
                },
                child: const Icon(Icons.cancel),
              ),
            ),
          )
        ],
      ),
    );
  }
}
