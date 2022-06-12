import 'dart:math';

import 'package:dodge_game/game/enemy.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import 'game.dart';

class EnemyManager extends Component with HasGameRef<DodgeGame> {
  late Timer timer;
  SpriteSheet spriteSheet;
  Random random = Random();

  EnemyManager({required this.spriteSheet}) : super() {
    timer = Timer(1, onTick: _spawnEnemy, repeat: true);
  }

  void _spawnEnemy() {
    Vector2 initialSize = Vector2(64, 64);

    // random.nextDouble() generates a random number between 0 and 1.
    // Multiplying it by gameRef.size.x makes sure that the value remains between 0 and width of screen.
    Vector2 position = Vector2(random.nextDouble() * gameRef.size.x, 0);

    // Clamps the vector such that the enemy sprite remains within the screen.
    position.clamp(
      Vector2.zero() + initialSize / 2,
      gameRef.size - initialSize / 2,
    );

    Enemy enemy = Enemy(
      sprite: spriteSheet.getSpriteById(11),
      size: initialSize,
      position: position,
    );

    // Makes sure that the enemy sprite is centered.
    enemy.anchor = Anchor.center;

    // Add it to components list of game instance, instead of EnemyManager.
    // This ensures the collision detection working correctly.
    gameRef.add(enemy);
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
