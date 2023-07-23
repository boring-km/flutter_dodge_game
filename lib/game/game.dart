import 'dart:async';

import 'package:dodge_game/game/enemy/random/random_enemy_generator.dart';
import 'package:dodge_game/game/enemy/tracking/tracking_enemy_generator.dart';
import 'package:dodge_game/game/player.dart';
import 'package:dodge_game/view/game/game_health_controller.dart';
import 'package:dodge_game/view/game/game_over_controller.dart';
import 'package:dodge_game/view/game/game_timer_controller.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';

class DodgeGame extends FlameGame
    with PanDetector, TapDetector, HasCollisionDetection {
  late Player player;
  late RandomEnemyGenerator _randomEnemyGenerator;
  late TrackingEnemyGenerator _trackingEnemyGenerator;

  int count = 0;
  double baseX = 0;
  double baseY = 0;

  final GameHealthController _healthController =
      Get.find<GameHealthController>();
  final GameTimerController _timerController = Get.find<GameTimerController>();
  final GameOverController _gameOverController = Get.find<GameOverController>();

  late StreamSubscription<AccelerometerEvent> _streamSubscription;

  @override
  Future<void> onLoad() async {
    await images.load('simpleSpace_tilesheet@2.png');

    await initPlayer();
    initEnemy();
    _timerController.start();

    _streamSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      var newX = event.y - baseY;
      var newY = event.x - baseX;

      if (2 <= newY && newY <= 4) newY = 0.0;
      if (-0.3 <= newX && newX <= 0.3) newX = 0.0;

      newY = num.parse(newY.toStringAsFixed(2)) as double;
      newX = num.parse(newX.toStringAsFixed(2)) as double;
      checkFinalCount();
      count++;

      if (newY < 2) {
        newY *= 3;
      }
      newX *= 2;

      player.moveDirection = Vector2(newX, newY);
    });
  }

  void checkFinalCount() {
    if (count == 100) {
      count = 0;
    }
  }

  void initEnemy() {
    _randomEnemyGenerator = RandomEnemyGenerator();
    _trackingEnemyGenerator = TrackingEnemyGenerator(player: player);
    add(_randomEnemyGenerator);
    add(_trackingEnemyGenerator);
  }

  Future<void> initPlayer() async {
    player = Player(
      sprite: Sprite(await Flame.images.load('profile.png')),
      size: Vector2(24, 24),
      position: size / 2,
      healthChangeCallback: _healthController.update,
    );

    player.anchor = Anchor.center;
    add(player);
    _healthController.playerCallback();

    _fixPlayerPosition();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (player.health <= 0) {
      pauseEngine();
      _timerController.stop();
      _streamSubscription.pause();
      _gameOverController.gameOver(_timerController.timeText);
    }
  }

  @override
  void onPanEnd(DragEndInfo? info) {
    _streamSubscription.cancel();
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    _fixPlayerPosition();
  }

  @override
  void onRemove() {
    _streamSubscription.cancel();
    super.onRemove();
  }

  void _fixPlayerPosition() {
    final temp = accelerometerEvents.listen((AccelerometerEvent event) {
      final newY = num.parse(event.y.toStringAsFixed(2)) as double;
      final newX = num.parse(event.x.toStringAsFixed(2)) as double;
      baseX = newX / 3;
      baseY = newY / 3;
    });
    Future.delayed(const Duration(seconds: 1), temp.cancel);
  }

  void resumeGame() {
    _timerController.resume();
    _streamSubscription.resume();
    resumeEngine();
  }

  void pauseGame() {
    _timerController.pause();
    _streamSubscription.pause();
    pauseEngine();
  }

  void restart() {
    player.revive();
    _healthController.update();
    _streamSubscription.resume();
    resumeEngine();
  }
}
