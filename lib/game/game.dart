import 'dart:async';

import 'package:dodge_game/game/enemy_manager.dart';
import 'package:dodge_game/game/player.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:sensors_plus/sensors_plus.dart';

class DodgeGame extends FlameGame with PanDetector, TapDetector {
  late Player player;
  late SpriteSheet _spriteSheet;
  late EnemyManager _enemyManager;

  late StreamSubscription<AccelerometerEvent> _streamSubscription;

  var count = 0;

  var baseX = 0.0;
  var baseY = 0.0;

  @override
  Future<void> onLoad() async {
    await images.load('simpleSpace_tilesheet@2.png');

    _spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: images.fromCache('simpleSpace_tilesheet@2.png'),
      columns: 8,
      rows: 6,
    );

    player = Player(
      sprite: _spriteSheet.getSpriteById(6),
      size: Vector2(24, 24),
      position: size / 2,
    );

    player.anchor = Anchor.center;

    add(player);

    _enemyManager = EnemyManager(spriteSheet: _spriteSheet);
    add(_enemyManager);

    _streamSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      var newY = event.y - baseY;
      var newX = event.x - baseX;

      if (-0.1 <= newX && newX <= 0.1) newX = 0.0;
      if (-0.1 <= newY && newY <= 0.1) newY = 0.0;

      newX = num.parse((newX).toStringAsFixed(2)) as double;
      newY = num.parse((newY).toStringAsFixed(2)) as double;
      if (count == 100) {
        print('x: $newX, y: $newY, z: ${event.z}');
        count = 0;
      }
      count++;
      player.setMoveDirection(Vector2(newY, newX));
    });
  }

  @override
  void onPanStart(DragStartInfo info) {}

  @override
  void onPanUpdate(DragUpdateInfo info) {}

  @override
  void onPanEnd(DragEndInfo info) {
    player.setMoveDirection(Vector2.zero());
    _streamSubscription.cancel();
  }

  @override
  void onPanCancel() {}

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    final temp = accelerometerEvents.listen((AccelerometerEvent event) {
      var newY = num.parse(event.y.toStringAsFixed(2)) as double;
      var newX = num.parse(event.x.toStringAsFixed(2)) as double;
      baseX = newX;
      baseY = newY;
    });
    Future.delayed(const Duration(seconds: 1), () => temp.cancel());
  }
}
