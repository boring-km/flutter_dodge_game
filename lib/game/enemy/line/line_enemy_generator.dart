import 'dart:math';

import 'package:dodge_game/game/enemy/get_random_start_position.dart';
import 'package:dodge_game/game/enemy/line/line_enemy.dart';
import 'package:dodge_game/game/game.dart';
import 'package:dodge_game/utils/constants.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class LineEnemyGenerator extends Component with HasGameRef<DodgeGame> {



  Random random = Random();
  Random randomType = Random();

  Random directionRandom = Random();
  Random signRandom = Random();

  int _enemyCount = 0;

  void generateEnemies(int n) {
    for (var i = 0; i < n; i++) {
      final typeNum = (randomType.nextDouble() * 4).toInt();
      final (startPosition, endPosition) = getStartEndPosition(typeNum, gameRef);
      
      final startOffset = Offset(startPosition.x, startPosition.y);
      final endOffset = Offset(endPosition.x, endPosition.y);

      final enemy = LineEnemy(
        start: startOffset,
        end: endOffset,
        size: Vector2(10, 10),
        color: Colors.yellow,
        position: startPosition,
        duration: 2,
        removeCallback: () {
          _enemyCount -= 1;
        },
      )..anchor = getAnchor(typeNum);
      gameRef.add(enemy);
    }
    _enemyCount += n;
  }

  double getDirectX(int typeNum) {
    final condition = signRandom.nextDouble() < 0.5;
    final minusDirection = -directionRandom.nextDouble() - 1;
    final plusDirection = directionRandom.nextDouble() + 1;

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

  double getDirectY(int typeNum) {
    final condition = signRandom.nextDouble() < 0.5;
    final minusDirection = -directionRandom.nextDouble() - 1;
    final plusDirection = directionRandom.nextDouble() + 1;

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

  void setMoveScope(Vector2 position, Vector2 initialSize) {
    position.clamp(
      Vector2.zero() + initialSize / 2,
      gameRef.size - initialSize / 2,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    final diff = GameOptions.lineEnemyCount - _enemyCount;
    if (diff > 0) {
      generateEnemies(diff);
    }
  }
}
