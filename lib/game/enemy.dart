import 'dart:math';

import 'package:dodge_game/game/knows_game_size.dart';
import 'package:flame/components.dart';

import 'game.dart';

class Enemy extends SpriteComponent with KnowsGameSize, HasGameRef<DodgeGame> {
  final double _speed = 120;

  late double _directX;
  late double _directY;

  Enemy({
    required double directX,
    required double directY,
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size) {
    angle = pi;
    _directX = directX;
    _directY = directY;
  }

  @override
  void update(double dt) {
    super.update(dt);

    var direction = Vector2(_directX, _directY);

    position += direction * _speed * dt;

    if (position.y > gameRef.size.y) {
      removeFromParent();
    }
  }
}

enum EnemyType { top, bottom, left, right, random }
