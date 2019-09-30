import 'package:equatable/equatable.dart';
import 'package:i_can_quit/data/model/user.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const <dynamic>[]]) : super(props);
}

class Register extends RegisterEvent {
  final User user;

  Register({@required this.user}) : super([user]);
}
