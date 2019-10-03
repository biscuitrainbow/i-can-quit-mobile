import 'package:equatable/equatable.dart';

abstract class ApplicationState extends Equatable {
  const ApplicationState();
}

class InitialApplicationState extends ApplicationState {
  @override
  List<Object> get props => [];
}
