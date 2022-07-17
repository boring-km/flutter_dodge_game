import 'dart:math';

import 'package:dodge_game/game/knows_game_size.dart';
import 'package:dodge_game/game/player.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../game.dart';

class Enemy extends CustomPainterComponent with KnowsGameSize, CollisionCallbacks, HasGameRef<DodgeGame> {

  late double _directX;
  late double _directY;
  late Function()? _removeCallback;
  late Color _color;
  late double _speed;

  Enemy({
    required double directX,
    required double directY,
    required Function()? removeCallback,
    required Color color,
    required double speed,
    Vector2? position,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    Iterable<Component>? children,
    int? priority,
  }) : super(
          position: position,
          size: size,
          scale: scale,
          angle: angle,
          anchor: anchor,
          children: children,
          priority: priority,
        ) {
    angle = pi;
    _removeCallback = removeCallback;
    _directX = directX;
    _directY = directY;
    _color = color;
    _speed = speed;
  }

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

  @override
  void update(double dt) {
    super.update(dt);

    var direction = Vector2(_directX, _directY);

    position += direction * _speed / 10 * dt;

    if (position.y > gameRef.size.y
        || position.y < -50
        || position.x > gameRef.size.x
        || position.x < -50) {
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
      const Offset(0, 0),
      8,
      Paint()..color = _color,
    );
  }
}
