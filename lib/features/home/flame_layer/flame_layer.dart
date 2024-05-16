import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakkyo/features/home/bloc/action_bloc.dart';
import 'package:hakkyo/features/home/flame_layer/hakkyo.dart';

class FlameLayer extends StatelessWidget {
  const FlameLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: Hakkyo(actionBloc: context.read<ActionBloc>()),
    );
  }
}