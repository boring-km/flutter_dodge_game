import 'dart:math';

import 'package:dodge_game/game/enemy.dart';
import 'package:flame/components.dart';

import 'game.dart';

class EnemyManager extends Component with HasGameRef<DodgeGame> {
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
        directX: getRandomDirection(),
        directY: getRandomDirection(),
        size: enemySize,
        position: getStartPosition(typeNum),
        removeCallback: () {
          _enemyCount -= 1;
        },
      );
      enemy.anchor = getAnchor(typeNum);
      gameRef.add(enemy);
    }
  }

  double getRandomDirection() => signRandom.nextDouble() < 0.5 ? -directionRandom.nextDouble() - 1 : directionRandom.nextDouble() + 1;

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

    if (_enemyCount < 20) {
      var target = 20 - _enemyCount;
      generateEnemies(target);
      _enemyCount += target;
    }
  }
}
