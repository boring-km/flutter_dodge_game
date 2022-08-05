import 'package:dodge_game/presentation/score/score_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScoreScreen extends GetView<ScoreScreenController> {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Score Screen'),
      ),
    );
  }
}
