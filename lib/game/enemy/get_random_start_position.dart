import 'dart:math';

import 'package:dodge_game/game/game.dart';
import 'package:flame/components.dart';

Vector2 getStartPosition(int typeNum, DodgeGame gameRef) {
  var startPosition = Vector2(getRandomX(gameRef), 0);
  if (typeNum == 0) {
    startPosition = Vector2(getRandomX(gameRef), 0);
  } else if (typeNum == 1) {
    startPosition = Vector2(getRandomX(gameRef), gameRef.size.y);
  } else if (typeNum == 2) {
    startPosition = Vector2(gameRef.size.x, getRandomY(gameRef));
  } else {
    startPosition = Vector2(0, getRandomY(gameRef));
  }
  return startPosition;
}

(Vector2, Vector2) getStartEndPosition(int typeNum, DodgeGame gameRef) {
  var startPosition = Vector2(gameRef.size.x, 0);
  var endPosition = Vector2(0, getRandomY(gameRef));

  if (typeNum == 1) {
    startPosition = Vector2(getRandomX(gameRef), gameRef.size.y);
    endPosition = Vector2(getRandomX(gameRef), 0);
  } else if (typeNum == 2) {
    startPosition = Vector2(gameRef.size.x, getRandomY(gameRef));
    endPosition = Vector2(0, getRandomY(gameRef));
  } else if (typeNum == 3) {
    startPosition = Vector2(0, getRandomY(gameRef));
    endPosition = Vector2(gameRef.size.x, getRandomY(gameRef));
  }

  return (startPosition, endPosition);
}

double getRandomY(DodgeGame gameRef) => Random().nextDouble() * gameRef.size.y;

double getRandomX(DodgeGame gameRef) => Random().nextDouble() * gameRef.size.x;
