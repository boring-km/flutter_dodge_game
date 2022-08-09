import 'package:dodge_game/game/enemy/enemy.dart';
import 'package:dodge_game/game/game.dart';
import 'package:dodge_game/game/knows_game_size.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Player extends SpriteComponent
    with KnowsGameSize, CollisionCallbacks, HasGameRef<DodgeGame> {
  Player({
    super.sprite,
    required this.joystickLeft,
    required this.joystickRight,
    super.position,
    super.size,
    required Function healthChangeCallback,
  }) {
    _healthChangeCallback = healthChangeCallback;
  }
  // Player joystick
  JoystickComponent joystickLeft;
  JoystickComponent joystickRight;

  final double _speed = 150;
  int _health = 100;

  int get health => _health;
  late Function _healthChangeCallback;

  @override
  void onMount() {
    super.onMount();

    final shape = RectangleHitbox.relative(
      Vector2(1, 1),
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
        _health -= 10;
      }
      _healthChangeCallback.call();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

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

  void revive() {
    _health = 100;
  }
}
