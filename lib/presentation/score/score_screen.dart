import 'package:dodge_game/presentation/score/score_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Scores',
                  style: TextStyle(fontSize: 36, color: Colors.white),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text(
                      'User Name',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    Text(
                      'Score',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    Text(
                      'Saved Time',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                GetBuilder<ScoreScreenController>(
                  builder: (controller) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: controller.scoreList.length,
                        itemBuilder: (context, index) {
                          final score = controller.scoreList[index];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                score.userName,
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                '${score.num}s',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                score.time,
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
