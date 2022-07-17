import 'dart:async';

import 'package:dodge_game/game/enemy/random_enemy_generator.dart';
import 'package:dodge_game/game/enemy/tracking_enemy_generator.dart';
import 'package:dodge_game/game/player.dart';
import 'package:dodge_game/presentation/game/game_screen_controller.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';

class DodgeGame extends FlameGame with PanDetector, HasDraggables, TapDetector, HasCollisionDetection {
  late Player player;
  late RandomEnemyGenerator _randomEnemyGenerator;
  late TrackingEnemyGenerator _trackingEnemyGenerator;
  late TextComponent _playerHealth;

  var count = 0;
  var baseX = 0.0;
  var baseY = 0.0;

  final GameScreenController _controller = Get.find<GameScreenController>();

  @override
  Future<void> onLoad() async {
    await images.load('simpleSpace_tilesheet@2.png');

    await initPlayer();
    initEnemy();
  }

  void initEnemy() {
    _randomEnemyGenerator = RandomEnemyGenerator();
    _trackingEnemyGenerator = TrackingEnemyGenerator(player: player);
    add(_randomEnemyGenerator);
    add(_trackingEnemyGenerator);
  }

  Future<void> initPlayer() async {
    final joystick1 = JoystickComponent(
      anchor: Anchor.bottomLeft,
      position: Vector2(30, size.y - 30),
      // size: 100,
      background: CircleComponent(
        radius: 60,
        paint: Paint()..color = Colors.white.withOpacity(0.5),
      ),
      knob: CircleComponent(radius: 30),
    );
    add(joystick1);
    final joystick2 = JoystickComponent(
      anchor: Anchor.bottomRight,
      position: Vector2(size.x - 30, size.y - 30),
      // size: 100,
      background: CircleComponent(
        radius: 60,
        paint: Paint()..color = Colors.white.withOpacity(0.5),
      ),
      knob: CircleComponent(radius: 30),
    );
    add(joystick2);

    player = Player(
      sprite: Sprite(await Flame.images.load('profile.png')),
      joystickLeft: joystick1,
      joystickRight: joystick2,
      size: Vector2(24, 24),
      position: size / 2,
      healthChangeCallback: _controller.healthChangeCallback,
    );

    player.anchor = Anchor.center;
    add(player);
    _controller.playerCallback();

    initializeMovement();
    _fixPlayerPosition();
  }

  void initializeMovement() {
    _playerHealth = TextComponent(
      text: '100%',
      position: Vector2(size.x / 2, size.y - 20),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );

    _playerHealth.anchor = Anchor.center;
    _playerHealth.positionType = PositionType.viewport;
    add(_playerHealth);
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
  void onPanEnd(DragEndInfo? info) {}

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
