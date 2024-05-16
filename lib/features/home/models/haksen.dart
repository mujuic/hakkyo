import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:hakkyo/features/home/flame_layer/hakkyo.dart';
import 'package:hakkyo/features/home/models/computer.dart';
import 'package:hakkyo/features/home/models/horizontal_wall.dart';
import 'package:hakkyo/features/home/models/vertical_wall.dart';
import 'package:hakkyo/features/home/models/window.dart';

class Haksen extends SpriteAnimationComponent with CollisionCallbacks, HasGameRef<Hakkyo> {
  Haksen() : super(position: Vector2(163,233), size: Vector2.all(80)) {
    debugMode = false;
  }

  bool flipped = false;

  bool collided = false;

  JoystickDirection collidedDirection = JoystickDirection.idle;

  double speed = 3;

  late final SpriteAnimation runAnimation;

  late final SpriteAnimation idleAnimation;
  
  @override 
  Future<void> onLoad() async {
    await super.onLoad();

    add(RectangleHitbox());

    var idleData = SpriteAnimationData.sequenced(amount: 11, stepTime: 0.1, textureSize: Vector2.all(32));

    var idleImage = await Flame.images.load('ivan_idle.png') as Image;

    idleAnimation = SpriteAnimation.fromFrameData(idleImage, idleData);

    var runData = SpriteAnimationData.sequenced(amount: 12, stepTime: 0.1, textureSize: Vector2.all(32));

    var runImage = await Flame.images.load('ivan_run.png') as Image;

    runAnimation = SpriteAnimation.fromFrameData(runImage, runData);

    animation = idleAnimation;
  }

  @override
  void update(double dt){
    super.update(dt);

    final bool moveLeft = gameRef.joystick.delta[0] < 0;

    final bool moveRight = gameRef.joystick.delta[0] > 0;

    final bool moveUp = gameRef.joystick.delta[1] < 0;

    final bool moveDown = gameRef.joystick.delta[1] > 0;

    if (gameRef.joystick.delta[0] > -0.01 && gameRef.joystick.delta[0] < 0.01) {
      animation = idleAnimation;
    } else {
      animation = runAnimation;
    }
    if (gameRef.joystick.delta[0] >= 0) {
      if (flipped) {
        flipHorizontallyAroundCenter();
        flipped = false;
      }
    } else {
      if (!flipped) {
        flipHorizontallyAroundCenter();
        flipped = true;
      }
    }

    

    if(!collided){
      position.add(gameRef.joystick.delta * dt * speed);
    }else{
      if(collidedDirection == JoystickDirection.right && !moveRight){
        position.add(gameRef.joystick.delta * dt * speed);
      }
      if(collidedDirection == JoystickDirection.left && !moveLeft){
        position.add(gameRef.joystick.delta * dt * speed);
      }
      if(collidedDirection == JoystickDirection.up && !moveUp){
        position.add(gameRef.joystick.delta * dt * speed);
      }
      if(collidedDirection == JoystickDirection.down && !moveDown){
        position.add(gameRef.joystick.delta * dt * speed);
      }
      if(collidedDirection == JoystickDirection.downLeft && !moveDown && !moveLeft){
        position.add(gameRef.joystick.delta * dt * speed);
      }
      if(collidedDirection == JoystickDirection.downRight && !moveDown && !moveRight){
        position.add(gameRef.joystick.delta * dt * speed);
      }
      if(collidedDirection == JoystickDirection.upLeft && !moveUp && !moveLeft){
        position.add(gameRef.joystick.delta * dt * speed);
      }
      if(collidedDirection == JoystickDirection.upRight && !moveUp && !moveRight){
        position.add(gameRef.joystick.delta * dt * speed);
      }


    }

    // //идем налево
    // if (moveLeft && x > 0) {
    //   if (!collided || collidedDirection != JoystickDirection.left) {
    //     x += vectorX;
    //   }
    // }
    // //идем направо
    // if (moveRight && x < gameRef.size[0]) {
    //   if (!collided || collidedDirection != JoystickDirection.right) {
    //     x += vectorX;
    //   }
    // }

    // //идем наверх
    // if (moveUp && y > 0) {
    //   if (!collided || collidedDirection != JoystickDirection.up) {
    //     y += vectorY;
    //   }
    // }

    // //идем вниз
    // if (moveDown && y < gameRef.size[1] - height) {
    //   if (!collided || collidedDirection != JoystickDirection.down) {
    //     y += vectorY;
    //   }
    // }

    

  }
  

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Computer || other is HorizontalWall || other is VerticalWall || other is Window) {
      if (!collided) {
        collided = true;
        collidedDirection = gameRef.joystick.direction;
      }
    }
    //print(collidedDirection);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    collidedDirection = JoystickDirection.idle;
    collided = false;
  }
}