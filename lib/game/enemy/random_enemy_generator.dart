import 'dart:math';

import 'package:dodge_game/game/enemy/enemy.dart';
import 'package:dodge_game/utils/constants.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../game.dart';

class RandomEnemyGenerator extends Component with HasGameRef<DodgeGame> {
  Vector2 enemySize = Vector2(12, 12);
  Random random = Random();
  Random randomType = Random();

  Random directionRandom = Random();
  Random signRandom = Random();

  int _enemyCount = 0;

  void generateEnemies(int n) {
    for (var i = 0; i < n; i++) {
      int typeNum = (randomType.nextDouble() * 4).toInt();

      Enemy enemy = Enemy(
        directX: getDirectX(typeNum),
        directY: getDirectY(typeNum),
        size: enemySize,
        color: Colors.yellow,
        position: getStartPosition(typeNum),
        speed: 120,
        removeCallback: () {
          _enemyCount -= 1;
        },
      );
      enemy.anchor = getAnchor(typeNum);
      gameRef.add(enemy);
    }
    _enemyCount += n;
  }

  double getDirectX(typeNum) {
    var condition = signRandom.nextDouble() < 0.5;
    var minusDirection = -directionRandom.nextDouble() - 1;
    var plusDirection = directionRandom.nextDouble() + 1;

    if (typeNum == 0) {
      return condition ? minusDirection : plusDirection;
    } else if (typeNum == 1) {
      return condition ? minusDirection : plusDirection;
    } else if (typeNum == 2) {
      return minusDirection;
    } else {
      return plusDirection;
    }
  }

  double getDirectY(typeNum) {
    var condition = signRandom.nextDouble() < 0.5;
    var minusDirection = -directionRandom.nextDouble() - 1;
    var plusDirection = directionRandom.nextDouble() + 1;

    if (typeNum == 0) {
      return plusDirection;
    } else if (typeNum == 1) {
      return minusDirection;
    } else if (typeNum == 2) {
      return condition ? minusDirection : plusDirection;
    } else {
      return condition ? minusDirection : plusDirection;
    }
  }

  Anchor getAnchor(int typeNum) {
    var anchor = Anchor.topCenter;
    if (typeNum == 0) {
      anchor = Anchor.topCenter;
    } else if (typeNum == 1) {
      anchor = Anchor.bottomCenter;
    } else if (typeNum == 2) {
      anchor = Anchor.centerLeft;
    } else {
      anchor = Anchor.centerRight;
    }
    return anchor;
  }

  Vector2 getStartPosition(int typeNum) {
    var startPosition = Vector2(getRandomX(), 1);
    if (typeNum == 0) {
      startPosition = Vector2(getRandomX(), 1);
    } else if (typeNum == 1) {
      startPosition = Vector2(getRandomX(), gameRef.size.y);
    } else if (typeNum == 2) {
      startPosition = Vector2(gameRef.size.x, getRandomY());
    } else {
      startPosition = Vector2(1, getRandomY());
    }
    return startPosition;
  }

  double getRandomY() => random.nextDouble() * gameRef.size.y;

  double getRandomX() => random.nextDouble() * gameRef.size.x;

  void setMoveScope(Vector2 position, Vector2 initialSize) {
    position.clamp(
      Vector2.zero() + initialSize / 2,
      gameRef.size - initialSize / 2,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    final diff = GameOptions.enemyCount - _enemyCount;
    if (diff > 0) {
      generateEnemies(diff);
    }
  }
}
