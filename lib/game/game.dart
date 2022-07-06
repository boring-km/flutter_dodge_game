import 'dart:async';
import 'dart:ui' as ui;

import 'package:dodge_game/game/enemy_manager.dart';
import 'package:dodge_game/game/player.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:sensors_plus/sensors_plus.dart';

class DodgeGame extends FlameGame
    with PanDetector, TapDetector, HasCollisionDetection {
  late Player player;
  late EnemyManager _enemyManager;

  late StreamSubscription<AccelerometerEvent> _streamSubscription;

  var count = 0;

  var baseX = 0.0;
  var baseY = 0.0;

  late Function() _playerInitCallback;

  late Function() _healthChangeCallback;

  DodgeGame({
    required Function() playerInitCallback,
    required Function() healthChangeCallback,
  }) {
    _playerInitCallback = playerInitCallback;
    _healthChangeCallback = healthChangeCallback;
  }

  @override
  Future<void> onLoad() async {
    await images.load('simpleSpace_tilesheet@2.png');

    ui.Image image = await Flame.images.load('profile.png');
    player = Player(
      sprite: Sprite(image),
      size: Vector2(24, 24),
      position: size / 2,
      healthChangeCallback: _healthChangeCallback,
    );

    player.anchor = Anchor.center;

    add(player);
    _playerInitCallback.call();

    _enemyManager = EnemyManager();
    add(_enemyManager);

    _streamSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      var newY = event.y - baseY;
      var newX = event.x - baseX;

      if (-0.1 <= newX && newX <= 0.1) newX = 0.0;
      if (-0.1 <= newY && newY <= 0.1) newY = 0.0;

      newX = num.parse((newX).toStringAsFixed(2)) as double;
      newY = num.parse((newY).toStringAsFixed(2)) as double;
      if (count == 100) {
        count = 0;
      }
      count++;
      player.setMoveDirection(Vector2(newY, newX));
    });

    _fixPlayerPosition();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (player.health <= 0) {
      pauseEngine();
    }
  }

  @override
  void onPanEnd(DragEndInfo? info) {
    player.setMoveDirection(Vector2.zero());
    _streamSubscription.cancel();
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    _fixPlayerPosition();
  }

  void _fixPlayerPosition() {
    final temp = accelerometerEvents.listen((AccelerometerEvent event) {
      var newY = num.parse(event.y.toStringAsFixed(2)) as double;
      var newX = num.parse(event.x.toStringAsFixed(2)) as double;
      baseX = newX;
      baseY = newY;
    });
    Future.delayed(const Duration(seconds: 1), () => temp.cancel());
  }
}
