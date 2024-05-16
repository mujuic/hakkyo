// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserEvent {}

class UserEventLogin extends UserEvent {
  final String cookie;

  final String username;

  UserEventLogin({
    required this.cookie,
    required this.username,
  });
}

