import 'package:dodge_game/game/game.dart';
import 'package:dodge_game/presentation/game/game_health_controller.dart';
import 'package:dodge_game/presentation/game/game_menu_controller.dart';
import 'package:dodge_game/presentation/game/game_over_controller.dart';
import 'package:dodge_game/presentation/game/game_timer_controller.dart';
import 'package:dodge_game/presentation/menu/menu_screen.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dodgeGame = DodgeGame();

    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: dodgeGame,
          ),
          GetBuilder<GameMenuController>(
            builder: (controller) {
              return Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: () => controller.toggleGameState(dodgeGame),
                          child: DecoratedBox(
                            decoration: const ShapeDecoration(
                              shape: CircleBorder(side: BorderSide()),
                              color: Colors.white,
                            ),
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
                            Get.back<MenuScreen>();
                            dodgeGame.onPanEnd(null);
                          },
                          child: const DecoratedBox(
                            decoration: ShapeDecoration(
                              shape: CircleBorder(side: BorderSide()),
                              color: Colors.white,
                            ),
                            child: Padding(
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
            },
          ),
          GetBuilder<GameHealthController>(
            builder: (controller) {
              if (controller.isLoaded) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
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
            },
          ),
          GetBuilder<GameTimerController>(
            builder: (controller) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    controller.timeText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              );
            },
          ),
          GetBuilder<GameOverController>(
            builder: (controller) {
              if (controller.isGameOver) {
                return Center(
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white70),
                    width: context.width / 3,
                    height: context.height / 2,
                    child: Stack(
                      children: [
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              'GameOver',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 44,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          child: Text(
                            controller.getScoreText(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () => controller.restart(dodgeGame),
                                  child: const DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        'Restart',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: controller.moveToScoreScreen,
                                  child: const DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        'Score',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
