import 'dart:math';

import 'package:dodge_game/game/enemy/get_random_start_position.dart';
import 'package:dodge_game/game/enemy/tracking/tracking_enemy.dart';
import 'package:dodge_game/game/game.dart';
import 'package:dodge_game/game/player.dart';
import 'package:dodge_game/utils/constants.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class TrackingEnemyGenerator extends Component with HasGameRef<DodgeGame> {
  TrackingEnemyGenerator({
    required Player player,
  }) {
    _player = player;
  }

  Vector2 enemySize = Vector2(12, 12);
  Random random = Random();
  Random randomType = Random();

  late Player _player;
  int _enemyCount = 0;
  double enemySpeed = 5;

  void generateEnemies(int n) {
    for (var i = 0; i < n; i++) {
      final typeNum = (randomType.nextDouble() * 4).toInt();
      final startPosition = getStartPosition(typeNum, gameRef);

      final enemy = TrackingEnemy(
        player: _player,
        size: enemySize,
        color: Colors.lightBlueAccent,
        position: startPosition,
        speed: enemySpeed,
        removeCallback: () {
          _enemyCount -= 1;
        },
      )..anchor = getAnchor(typeNum);
      gameRef.add(enemy);
    }
    _enemyCount += n;
  }

  Anchor getAnchor(int typeNum) {
    var anchor = Anchor.topCenter;
    if (typeNum == 0) {
      anchor = Anchor.topCenter;
    } else if (typeNum == 1) {
      anchor = Anchor.bottomCenter;
    } else if (typeNum == 2) {
      anchor = Anchor.centerLeft;
    } else {
      anchor = Anchor.centerRight;
    }
    return anchor;
  }


  void setMoveScope(Vector2 position, Vector2 initialSize) {
    position.clamp(
      Vector2.zero() + initialSize / 2,
      gameRef.size - initialSize / 2,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    final diff = GameOptions.trackerDotEnemyCount - _enemyCount;
    if (diff > 0) {
      generateEnemies(diff);
    }
  }
}
