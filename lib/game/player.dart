import 'package:dodge_game/game/enemy.dart';
import 'package:dodge_game/game/game.dart';
import 'package:dodge_game/game/knows_game_size.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Player extends SpriteComponent with KnowsGameSize, CollisionCallbacks, HasGameRef<DodgeGame> {
  // Player joystick
  JoystickComponent joystickLeft;
  JoystickComponent joystickRight;

  final double _speed = 150;
  int _health = 100;
  int get health => _health;

  Player({
    Sprite? sprite,
    required this.joystickLeft,
    required this.joystickRight,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size);

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

    if (other is Enemy) {
      if (_health > 0) {
        _health -= 5;
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // position += _moveDirection.normalized() * _speed * dt;
    if (!joystickLeft.delta.isZero()) {
      position.add(joystickLeft.relativeDelta * _speed * dt);
    }
    if (!joystickRight.delta.isZero()) {
      position.add(joystickRight.relativeDelta * _speed * dt);
    }

    position.clamp(
      Vector2.zero() + size / 2,
      gameRef.size - size / 2,
    );
  }

  void setMoveDirection(Vector2 newMoveDirection) {}
}
