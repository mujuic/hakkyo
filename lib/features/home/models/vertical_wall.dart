import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:hakkyo/features/home/bloc/action_bloc.dart';
import 'package:hakkyo/features/home/flame_layer/hakkyo.dart';
import 'package:hakkyo/features/home/models/haksen.dart';

class VerticalWall extends SpriteComponent 
with HasGameRef<Hakkyo>, CollisionCallbacks, FlameBlocListenable<ActionBloc,ActionState>{

  final Vector2 wallPosition;

  VerticalWall({required this.wallPosition}) : super(position: wallPosition, size: Vector2(1, 800)){
    debugMode = false;
  }  


  @override 
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
    sprite = await gameRef.loadSprite('wall.jpg');
  }

  @override
  void onNewState(ActionState state) {
    super.onNewState(state);
  }

  @override
  void update(double dt){
    // x +=1; 
    // y +=1;
  }

 @override 
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other){
    if(other is Haksen){
      print("there is a wall....");
      // removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
  // @override
  // void onCollisionEnd(PositionComponent other) {
  //   gameRef.actionBloc.add(ActionEventReset());
  //   super.onCollisionEnd(other);
  // }
}