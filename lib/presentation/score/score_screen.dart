import 'package:dodge_game/presentation/score/score_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildOrderTextWidget(
                      width: width,
                      child: buildMenuText('Order'),
                    ),
                    buildScoreTextWidget(
                      width: width,
                      child: buildMenuText('User Name'),
                    ),
                    buildScoreTextWidget(
                      width: width,
                      child: buildMenuText('Score'),
                    ),
                    buildScoreTextWidget(
                      width: width,
                      child: buildMenuText('Saved Time'),
                    ),
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
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildOrderTextWidget(
                                  width: width,
                                  child: buildUserText('${index+1}'),
                                ),
                                buildScoreTextWidget(
                                  width: width,
                                  child: buildUserText(score.userName),
                                ),
                                buildScoreTextWidget(
                                  width: width,
                                  child: buildUserText('${score.num}s'),
                                ),
                                buildScoreTextWidget(
                                  width: width,
                                  child: buildUserText(score.time),
                                ),
                              ],
                            ),
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

  Text buildUserText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white),
    );
  }

  SizedBox buildScoreTextWidget({
    required double width,
    required Text child,
  }) {
    return SizedBox(
      width: width / 5,
      child: child,
    );
  }

  SizedBox buildOrderTextWidget({
    required double width,
    required Text child,
  }) {
    return SizedBox(
      width: width / 10,
      child: child,
    );
  }

  Text buildMenuText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
    );
  }
}
