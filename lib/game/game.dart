import 'dart:async';

import 'package:dodge_game/game/enemy/random_enemy_generator.dart';
import 'package:dodge_game/game/enemy/tracking_enemy_generator.dart';
import 'package:dodge_game/game/player.dart';
import 'package:dodge_game/presentation/game/game_screen_controller.dart';
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
  late StreamSubscription<AccelerometerEvent> _streamSubscription;

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
    player = Player(
      sprite: Sprite(await Flame.images.load('profile.png')),
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
