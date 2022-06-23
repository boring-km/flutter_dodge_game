import 'dart:math';

import 'package:dodge_game/game/enemy.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import 'game.dart';

class EnemyManager extends Component with HasGameRef<DodgeGame> {
  late Timer timer;
  SpriteSheet spriteSheet;
  Vector2 enemySize = Vector2(12, 12);
  Random random = Random();
  Random randomType = Random();

  Random directionRandom = Random();
  Random signRandom = Random();

  EnemyManager({required this.spriteSheet}) : super() {
    timer = Timer(1, onTick: _spawnEnemy, repeat: true);
  }

  void _spawnEnemy() {
    generateEnemies(15);
  }

  void generateEnemies(int n) {
    for (var i = 0; i < n; i++) {
      int typeNum = (randomType.nextDouble() * 4).toInt();

      Enemy enemy = Enemy(
        directX: getRandomDirection(),
        directY: getRandomDirection(),
        size: enemySize,
        position: getStartPosition(typeNum),
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
    var startPosition = Vector2(getRandomX(), 0);
    // var anchor = Anchor.topCenter;
    if (typeNum == 0) {
      startPosition = Vector2(getRandomX(), 0);
      // anchor = Anchor.topCenter;
    } else if (typeNum == 1) {
      startPosition = Vector2(getRandomX(), gameRef.size.y);
      // anchor = Anchor.bottomCenter;
    } else if (typeNum == 2) {
      startPosition = Vector2(gameRef.size.x, getRandomY());
      // anchor = Anchor.centerLeft;
    } else {
      startPosition = Vector2(0, getRandomY());
      // anchor = Anchor.centerRight;
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
  void onMount() {
    super.onMount();
    timer.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    timer.update(dt);
  }
}
