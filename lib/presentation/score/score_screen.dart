import 'package:dodge_game/presentation/score/score_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Score',
                  style: TextStyle(fontSize: 36),
                ),
                const SizedBox(height: 30,),
                GetBuilder<ScoreScreenController>(
                  builder: (controller) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: controller.scoreList.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text('User Name'),
                                Text('Score'),
                                Text('Saved Time')
                              ],
                            );
                          }
                          final score = controller.scoreList[index-1];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(score.userName),
                              Text('${score.num}s'),
                              Text(score.time)
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
