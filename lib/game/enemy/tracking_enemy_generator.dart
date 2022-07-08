import 'dart:math';

import 'package:dodge_game/game/enemy/enemy.dart';
import 'package:dodge_game/utils/constants.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../game.dart';

class TrackingEnemyGenerator extends Component with HasGameRef<DodgeGame> {
  Vector2 enemySize = Vector2(12, 12);
  Random random = Random();
  Random randomType = Random();

  late double _playerX;
  late double _playerY;

  int _enemyCount = 0;

  TrackingEnemyGenerator({
    required double playerX,
    required double playerY,
  }) {
    _playerX = playerX;
    _playerY = playerY;
  }

  void generateEnemies(int n) {
    for (var i = 0; i < n; i++) {

      final typeNum = (randomType.nextDouble() * 4).toInt();
      final startPosition = getStartPosition(typeNum);

      Enemy enemy = Enemy(
        directX: _playerX - startPosition.x,
        directY: _playerY - startPosition.y,
        size: enemySize,
        color: Colors.lightBlueAccent,
        position: startPosition,
        speed: 3,
        removeCallback: () {
          _enemyCount -= 1;
        },
      );
      enemy.anchor = getAnchor(typeNum);
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

  Vector2 getStartPosition(int typeNum) {
    var startPosition = Vector2(getRandomX(), 0);
    if (typeNum == 0) {
      startPosition = Vector2(getRandomX(), 0);
    } else if (typeNum == 1) {
      startPosition = Vector2(getRandomX(), gameRef.size.y);
    } else if (typeNum == 2) {
      startPosition = Vector2(gameRef.size.x, getRandomY());
    } else {
      startPosition = Vector2(0, getRandomY());
    }
    return startPosition;
  }

  double getRandomY() => random.nextDouble() * gameRef.size.y;

  double getRandomX() => random.nextDouble() * gameRef.size.x;

  void setMoveScope(Vector2 position, Vector2 initialSize) {
    position.clamp(
      Vector2.zero() + initialSize / 2,
      gameRef.size - initialSize / 2,
    );
  }

  double fromPlayerToEnemyX(Vector2 startPosition) {
    return (_playerX - startPosition.x) / 240;
  }

  double fromPlayerToEnemyY(Vector2 startPosition) {
    return (_playerY - startPosition.y) / 240;
  }

  @override
  void update(double dt) {
    super.update(dt);
    final diff = GameOptions.trackerCount - _enemyCount;
    if (diff > 0) {
      generateEnemies(diff);
    }
  }
}
