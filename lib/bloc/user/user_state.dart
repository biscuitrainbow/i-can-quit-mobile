import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:i_can_quit/data/model/user.dart';

abstract class UserState extends Equatable {
  UserState([List props = const []]) : super(props);
}

class InitialUserState extends UserState {
  @override
  List<Object> get props => [];
}

class FetchUserSuccess extends UserState {
  final User user;

  FetchUserSuccess({@required this.user}) : super([user]);
}

class FetchUserLoading extends UserState {}
