import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Bullet extends SpriteComponent with CollisionCallbacks {

  double _speed = 450;

  Bullet({
    Sprite? sprite,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size);

  @override
  void update(double dt) {
    super.update(dt);

    this.position += Vector2(0, -1) * this._speed * dt;

    if(this.position.y < 0) {
      removeFromParent();
    }
  }
}