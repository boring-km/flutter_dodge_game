import 'package:dodge_game/presentation/score/score_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScoreScreen extends GetView<ScoreScreenController> {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Score Screen'),
      )
    );
  }
}
