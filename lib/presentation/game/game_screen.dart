import 'package:dodge_game/game/game.dart';
import 'package:dodge_game/presentation/game/game_screen_controller.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameScreen extends GetView<GameScreenController> {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dodgeGame = DodgeGame();

    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: dodgeGame,
          ),
          GetBuilder<GameScreenController>(builder: (controller) {
            return Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        controller.toggleGameState(dodgeGame);
                      },
                      child: Container(
                        decoration: const ShapeDecoration(shape: CircleBorder(side: BorderSide()), color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            controller.getPauseIcon(),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                        dodgeGame.onPanEnd(null);
                      },
                      child: Container(
                        decoration: const ShapeDecoration(shape: CircleBorder(side: BorderSide()), color: Colors.white),
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.exit_to_app,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
