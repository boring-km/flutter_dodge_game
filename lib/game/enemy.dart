import 'dart:math';

import 'package:dodge_game/game/knows_game_size.dart';
import 'package:flame/components.dart';

import 'game.dart';

class Enemy extends SpriteComponent with KnowsGameSize, HasGameRef<DodgeGame> {
  double _speed = 250;

  final EnemyType type;

  Enemy(
    this.type, {
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size) {
    angle = pi;
  }

  @override
  void update(double dt) {
    super.update(dt);

    var direction = Vector2(0, 1);

    if (type == EnemyType.bottom) {
      direction = Vector2(0, -1);
    } else if (type == EnemyType.left) {
      direction = Vector2(-1, 0);
    } else if (type == EnemyType.right) {
      direction = Vector2(1, 0);
    }

    position += direction * _speed * dt;

    if (position.y > gameRef.size.y) {
      removeFromParent();
    }
  }
}

enum EnemyType { top, bottom, left, right }
