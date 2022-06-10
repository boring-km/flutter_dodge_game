import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MyFace extends SpriteComponent {
  MyFace() : super(size: Vector2.all(200));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('kangmin.png');
  }
}

class DodgeGame extends FlameGame with SingleGameInstance {

  DodgeGame({
    Iterable<Component>? children,
    Camera? camera,
  }): super(children: children, camera: camera);


  @override
  Color backgroundColor() => const Color(0x00000000);

  @override
  Future<void> onLoad() async {
    await add(MyFace());
  }
}