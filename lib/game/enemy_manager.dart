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

  EnemyManager({required this.spriteSheet}) : super() {
    timer = Timer(1, onTick: _spawnEnemy, repeat: true);
  }

  void _spawnEnemy() {
    generateEnemies(EnemyType.top, 2);
    generateEnemies(EnemyType.bottom, 2);
    generateEnemies(EnemyType.left, 2);
    generateEnemies(EnemyType.right, 2);
  }

  void generateEnemies(EnemyType type, int n) {
    for (var i = 0; i < n; i++) {
      var startPosition = Vector2(random.nextDouble() * gameRef.size.x, 0);
      var anchor = Anchor.topCenter;

      if (type == EnemyType.bottom) {
        startPosition = Vector2(random.nextDouble() * gameRef.size.x, gameRef.size.y);
        anchor = Anchor.bottomCenter;
      } else if (type == EnemyType.left) {
        startPosition = Vector2(gameRef.size.x, random.nextDouble() * gameRef.size.y);
        anchor = Anchor.centerLeft;
      } else if (type == EnemyType.right) {
        startPosition = Vector2(0, random.nextDouble() * gameRef.size.y);
        anchor = Anchor.centerRight;
      }

      Enemy enemy = Enemy(
        type,
        sprite: spriteSheet.getSpriteById(11),
        size: enemySize,
        position: startPosition,
      );
      enemy.anchor = anchor;
      gameRef.add(enemy);
    }
  }

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
