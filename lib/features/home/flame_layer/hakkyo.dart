import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hakkyo/features/home/bloc/action_bloc.dart';
import 'package:hakkyo/features/home/models/computer.dart';
import 'package:hakkyo/features/home/models/haksen.dart';
import 'package:hakkyo/features/home/models/horizontal_wall.dart';
import 'package:hakkyo/features/home/models/vertical_wall.dart';
import 'package:hakkyo/features/home/models/window.dart';


class Hakkyo extends FlameGame with HasCollisionDetection{

  final ActionBloc actionBloc;

  final JoystickComponent joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: BasicPalette.white.withAlpha(200).paint()),
      background: CircleComponent(radius: 50, paint: BasicPalette.white.withAlpha(100).paint()),
      margin: const EdgeInsets.only(left: 70, bottom: 70),
  );

  Hakkyo({required this.actionBloc});

  @override
  Future<void> onLoad() async{
    await super.onLoad();

    add(SpriteComponent(sprite: await loadSprite('ivan_room.jpg'))..size = size);

    add(FlameBlocProvider<ActionBloc, ActionState>.value(
      value: actionBloc, children: [
        HorizontalWall(wallPosition: Vector2(0,70)),
        HorizontalWall(wallPosition: Vector2(0,383)),
        VerticalWall(wallPosition: Vector2(20,0)),
        VerticalWall(wallPosition: Vector2(390,0)),
        Window(),
        Computer(),
        Haksen(),
      ])
    );

    add(joystick);
  }



}