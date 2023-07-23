import 'dart:math';

import 'package:dodge_game/game/enemy/enemy.dart';
import 'package:dodge_game/game/enemy/line/line.dart';
import 'package:dodge_game/game/game.dart';
import 'package:dodge_game/game/knows_game_size.dart';
import 'package:dodge_game/game/player.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class LineEnemy extends CustomPainterComponent
    with KnowsGameSize, CollisionCallbacks, HasGameRef<DodgeGame>, Enemy {
  LineEnemy({
    required Function? removeCallback,
    required Color color,
    required double duration,
    required this.start,
    required this.end,
    super.position,
    super.size,
    super.scale,
    double? angle,
    super.anchor,
    super.children,
    super.priority,
  }) : super(
          angle: angle,
        ) {
    angle = pi;
    _removeCallback = removeCallback;
    _duration = duration;
    linePaint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round;
  }

  final Offset start;
  final Offset end;

  late Function? _removeCallback;
  late double _duration;

  late Paint linePaint;

  double progress = 0;
  bool isEnd = false;
  Line? line;

  @override
  void onMount() {
    super.onMount();

    add(RectangleHitbox());
    line = Line(start, end, progress);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Player) {
      destroy();
    }
  }

  void destroy() {
    removeFromParent();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (line == null || line!.progress < 0) return;
    line!.check();
    // 선 이동 및 사라지는 효과 갱신
    if (line!.isEnd) {
      line!.progress -= dt / _duration;
    } else {
      line!.progress += dt / _duration;
    }
  }

  @override
  void removeFromParent() {
    _removeCallback?.call();
    super.removeFromParent();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (line == null) return;
    if (!isEnd) {
      final currentOffset =
          line!.start + (line!.end - line!.start) * line!.progress;
      canvas.drawLine(line!.start, currentOffset, linePaint..strokeWidth = 5);

      if (line!.isEnd) {
        isEnd = true;
      }
    } else {
      final currentOffset =
          start + (end - start) * (1 - line!.progress);
      canvas.drawLine(currentOffset, end, linePaint..strokeWidth = 5);

      final shape = CircleHitbox.relative(
        5,
        parentSize: size,
        position: size / 2,
        anchor: Anchor.center,
      );
      add(shape);


      if (line!.progress < 0) {
        line = null;
        removeFromParent();
      }
    }
  }
}
