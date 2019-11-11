import 'package:equatable/equatable.dart';

abstract class ApplicationEvent extends Equatable {
  const ApplicationEvent();
}

class InitilizeApplication extends ApplicationEvent {}

class ReadyApplication extends ApplicationEvent {}
