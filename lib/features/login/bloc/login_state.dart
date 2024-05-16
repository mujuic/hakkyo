part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateLoaded extends LoginState {
  final String cookie;

  LoginStateLoaded({required this.cookie});
} 

class LoginFailure extends LoginState {}
