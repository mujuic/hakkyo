part of 'action_bloc.dart';

abstract class ActionEvent {}

class ActionEventComputer extends ActionEvent {}

class ActionEventReset extends ActionEvent {}

class ActionEventWindow extends ActionEvent {}