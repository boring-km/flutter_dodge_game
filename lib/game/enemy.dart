import 'dart:math';

import 'package:dodge_game/game/knows_game_size.dart';
import 'package:flame/components.dart';

import 'game.dart';

class Enemy extends SpriteComponent with KnowsGameSize, HasGameRef<DodgeGame> {
  double _speed = 250;

  Enemy({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size) {
    angle = pi;
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += Vector2(0, 1) * _speed * dt;

    if (position.y > gameRef.size.y) {
      removeFromParent();
    }
  }
}
