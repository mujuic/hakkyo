import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:hakkyo/features/home/bloc/action_bloc.dart';
import 'package:hakkyo/features/home/flame_layer/hakkyo.dart';
import 'package:hakkyo/features/home/models/haksen.dart';

class Computer extends SpriteComponent 
with HasGameRef<Hakkyo>, CollisionCallbacks, FlameBlocListenable<ActionBloc,ActionState>{
  Computer() : super(position: Vector2(27,327.5), size: Vector2(70,56)) {
    debugMode = false;
  }


  @override 
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
    sprite = await gameRef.loadSprite('computer.jpg');
  }

  @override
  void onNewState(ActionState state) {
    // print('new state is ${state.score}');
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
      print("it is a computer!");
      gameRef.actionBloc.add(ActionEventComputer());
      // removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
  @override
  void onCollisionEnd(PositionComponent other) {
    gameRef.actionBloc.add(ActionEventReset());
    super.onCollisionEnd(other);
  }
}