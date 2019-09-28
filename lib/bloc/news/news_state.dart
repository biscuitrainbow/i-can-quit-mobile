import 'package:equatable/equatable.dart';
import 'package:i_can_quit/data/model/news.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NewsState extends Equatable {
  NewsState([List props = const <dynamic>[]]) : super(props);
}

class InitialNewsState extends NewsState {}

class NewsLoaded extends NewsState {
  final List<News> news;

  NewsLoaded({@required this.news});
}
