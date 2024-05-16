part of 'action_bloc.dart';

abstract class ActionState {
  late String text;
  late String buttonText;
  late double overMark;
}

class ActionInitial extends ActionState {
  String text = "거실";
  String buttonText = "모양";
}

class ActionStateComputer extends ActionState {
  String text = "COMPUTODO";
  String buttonText = '컴퓨터';
}

class ActionStateWindow extends ActionState {
  String text = "WINDOW";
  String buttonText = '창문';
}