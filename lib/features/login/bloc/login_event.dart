// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginEventLog extends LoginEvent {

  final String username;

  final String password;

  LoginEventLog({
    required this.username,
    
    required this.password,
  });
}
