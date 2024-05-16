// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserState {
  late User user;
}

class UserStateInitial extends UserState {}

class UserStateLoading extends UserState{}

class UserStateLoaded extends UserState {

  UserStateLoaded({
    required this.user,
  });

  @override
  final User user;
}

class UserStateFailure extends UserState{}
