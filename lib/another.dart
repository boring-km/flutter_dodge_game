import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setOrientation(DeviceOrientation.portraitUp);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: GameWidget(game: MyGame())),
    ),
  );
}

class MyGame extends FlameGame with TapDetector {
  Offset? startOffset;
  Offset? targetOffset;
  double progress = 0.0;
  double duration = 1.0; // 이동에 걸리는 시간 (초)
  Paint paint = Paint()
    ..color = Colors.blue
    ..strokeCap = StrokeCap.round;
  bool isEnd = false;

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    final screenSize = size.toOffset();
    startOffset = Offset(screenSize.dx / 2, screenSize.dy / 2);
    targetOffset = info.eventPosition.game.toOffset();
    progress = 0.0;
    isEnd = false;
    line = Line(startOffset!, targetOffset!, progress);
  }

  @override
  void render(Canvas canvas) {
    if (line == null) return;

    if (!isEnd) {
      final currentOffset = line!.start + (line!.end - line!.start) * line!.progress;
      canvas.drawLine(line!.start, currentOffset, paint..strokeWidth = 10);

      if (line!.isEnd) {
        isEnd = true;
      }
    } else {
      final currentOffset = startOffset! + (targetOffset! - startOffset!) * (1 - line!.progress);
      canvas.drawLine(currentOffset, targetOffset!, paint..strokeWidth = 10);
      if (line!.progress < 0) {
        line = null;
        removeFromParent();
      }
    }
    super.render(canvas);
  }
  Line? line;

  @override
  void update(double dt) {
    super.update(dt);
    if (line == null || line!.progress < 0) return;
    line!.check();
    // 선 이동 및 사라지는 효과 갱신
    if (line!.isEnd) {
      line!.progress -= dt / duration;
    } else {
      line!.progress += dt / duration;
    }
  }
}

class Line {

  Line(this.start, this.end, this.progress);

  Offset start;
  Offset end;
  double progress;
  bool isEnd = false;

  bool check() {
    final res = progress >= 1.0;
    if (!isEnd && res) {
      isEnd = true;
    }
    return res;
  }
}