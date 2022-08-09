import 'dart:async';

import 'package:get/get.dart';

class GameTimerController extends GetxController {
  Timer? _timer;
  int _numTime = 0;
  String timeText = '0s';

  void start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      ++_numTime;
      timeText = '${_numTime}s';
      update();
    });
  }

  void pause() {
    _timer?.cancel();
  }

  void resume() {
    start();
  }

  void stop() {
    _timer?.cancel();
    _numTime = 0;
  }

  void restart() {
    stop();
    start();
  }

  @override
  void onClose() {
    stop();
    super.onClose();
  }
}
