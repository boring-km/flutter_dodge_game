import 'package:dodge_game/game/game.dart';
import 'package:dodge_game/presentation/game/game_menu_controller.dart';
import 'package:dodge_game/presentation/game/game_screen_controller.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameScreen extends GetView<GameScreenController> {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dodgeGame = DodgeGame(
      playerInitCallback: controller.playerCallback,
      healthChangeCallback: controller.healthChangeCallback,
    );

    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: dodgeGame,
          ),
          GetBuilder<GameMenuController>(builder: (controller) {
            return Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                          decoration: const ShapeDecoration(
                              shape: CircleBorder(side: BorderSide()),
                              color: Colors.white),
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
                      padding: const EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                          dodgeGame.onPanEnd(null);
                        },
                        child: Container(
                          decoration: const ShapeDecoration(
                              shape: CircleBorder(side: BorderSide()),
                              color: Colors.white),
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
              ),
            );
          }),
          GetBuilder<GameScreenController>(builder: (controller) {
            if (controller.isLoaded) {
              return Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '${dodgeGame.player.health}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }
}
