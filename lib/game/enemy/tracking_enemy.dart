import 'dart:math';

import 'package:dodge_game/game/enemy/enemy.dart';
import 'package:dodge_game/game/game.dart';
import 'package:dodge_game/game/knows_game_size.dart';
import 'package:dodge_game/game/player.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class TrackingEnemy extends CustomPainterComponent
    with KnowsGameSize, CollisionCallbacks, HasGameRef<DodgeGame>, Enemy {
  TrackingEnemy({
    required Player player,
    required Function? removeCallback,
    required Color color,
    required double speed,
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
    _player = player;
    _color = color;
    _speed = speed;
  }

  late Player _player;
  late Function? _removeCallback;
  late Color _color;
  late double _speed;
  final nearLimit = 70.0;

  @override
  void onMount() {
    super.onMount();
    final shape = CircleHitbox.relative(
      0.8,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);
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

  double xOut = 0;
  double yOut = 0;

  @override
  void update(double dt) {
    super.update(dt);

    var x = xOut == 0 ? _player.x - position.x : xOut;
    var y = yOut == 0 ? _player.y - position.y : yOut;

    if (x.abs() < nearLimit) {
      if (x < 0) {
        x = -nearLimit;
      } else {
        x = nearLimit;
      }
      xOut = x;
    }
    if (y.abs() < nearLimit) {
      if (y < 0) {
        y = -nearLimit;
      } else {
        y = nearLimit;
      }
      yOut = y;
    }

    final direction = Vector2(x, y);

    position += direction * _speed / 5 * dt;

    if (position.y > gameRef.size.y ||
        position.y < -50 ||
        position.x > gameRef.size.x ||
        position.x < -50) {
      removeFromParent();
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

    canvas.drawCircle(
      Offset.zero,
      8,
      Paint()..color = _color,
    );
  }
}
